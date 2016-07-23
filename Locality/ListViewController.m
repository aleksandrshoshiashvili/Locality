//
//  ViewController.m
//  Locality
//
//  Created by NikoGenn on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

#import "ListViewController.h"
#import "PlaceViewController.h"
#import "PlaceCell.h"
#import "ASPlace.h"

#import "ASServerManager.h"

#import "OneLineFilterView.h"
#import "PlaceViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *placesArray;
@property (strong, nonatomic) NSMutableArray *filterArray;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *myLocation;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@end

@implementation ListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.locationManager = [[CLLocationManager alloc] init];
  [self setupLocation];
  
  _tableView.delegate = self;
  _tableView.dataSource = self;
  _tableView.backgroundColor = appMainColor;
  
  self.filterArray = [NSMutableArray array];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self getCompaniesByLocation];
  });
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self setupNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Notifications

- (void)setupNotifications {
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionChooseAllCategory) name:@"actionChooseAllNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCancelCategory) name:@"actionCancelNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionChooseSelectedFilterInOneLineView:) name:@"actionChooseFilterInOneLineViewNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionSelectedFilterButtonPressed:) name:@"actionFilterButtonPressedNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionResetFilters) name:@"actionResetFiltersNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionDelivery:) name:@"actionDeliverButtonPressedNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionTakeaway:) name:@"actionTakeawayButtonPressedNotification" object:nil];
}

#pragma mark - Location

- (void)setupLocation {
  self.locationManager.delegate = self;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  
  [self.locationManager startUpdatingLocation];
}

#pragma mark - Get Places

- (void)getCompaniesByCategory:(NSString *)cat subcategory:(NSString *)subcat {
  [super startLoader];
  [[ASServerManager sharedManager] getCompaniesByLatitude:self.myLocation.coordinate.latitude longtitude:self.myLocation.coordinate.longitude category:cat subcategory:subcat onSuccess:^(NSArray *array) {
    self.placesArray = [NSArray arrayWithArray:array];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self.tableView reloadData];
    [self stopLoader];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    [self stopLoader];
    NSLog(@"getCompaniesByLatitude error = %@, statusCode = %ld", error.localizedDescription, (long)statusCode);
  }];
}

- (void)getCompaniesBySubcategory:(NSString *)subcat {
  [super startLoader];
  [[ASServerManager sharedManager] getCompaniesByLatitude:self.myLocation.coordinate.latitude longtitude:self.myLocation.coordinate.longitude category:[NSString stringWithFormat:@"%ld", (long)self.filterTypeId] subcategory:subcat onSuccess:^(NSArray *array) {
    self.placesArray = [NSArray arrayWithArray:array];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self.tableView reloadData];
    [self stopLoader];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    [self stopLoader];
    NSLog(@"getCompaniesByLatitude error = %@, statusCode = %ld", error.localizedDescription, (long)statusCode);
  }];
}

- (void)getCompaniesByLocation {
  [super startLoader];
  [[ASServerManager sharedManager] getCompaniesByLatitude:self.myLocation.coordinate.latitude longtitude:self.myLocation.coordinate.longitude onSuccess:^(NSArray *array) {
    self.placesArray = [NSArray arrayWithArray:array];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self.tableView reloadData];
    [self stopLoader];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    [self stopLoader];
    NSLog(@"getCompaniesByLatitude error = %@, statusCode = %ld", error.localizedDescription, (long)statusCode);
  }];
}

- (void)getPlacesByLatitude:(double)lat andLongtitude:(double)lon {
  [super startLoader];
  [[ASServerManager sharedManager] getlistByLatitude:lat longtitude:lon onSuccess:^(NSArray *array) {
    
    self.placesArray = [NSArray arrayWithArray:array];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self.tableView reloadData];
    [self stopLoader];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    [self stopLoader];
    NSLog(@"getlistByLatitude error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
}

- (void)getPlacesById:(NSNumber *)placeId {
  [super startLoader];
  [[ASServerManager sharedManager] getlistByPlaceId:[placeId stringValue] onSuccess:^(ASPlace *place) {
    
    self.placesArray = @[place];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self.tableView reloadData];
    [self stopLoader];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    [self stopLoader];
    NSLog(@"getlistByPlaceId error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
}

- (void)getPlacesByLatitude:(double)lat andLongtitude:(double)lon subcategory:(NSString *)subcategory {
  [super startLoader];
  [[ASServerManager sharedManager] getCompaniesByLatitude:self.myLocation.coordinate.latitude longtitude:self.myLocation.coordinate.longitude category:[NSString stringWithFormat:@"%ld", (long)self.filterTypeId] subcategory:subcategory onSuccess:^(NSArray *array) {
    self.placesArray = [NSArray arrayWithArray:array];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self.tableView reloadData];
    [self stopLoader];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    [self stopLoader];
    NSLog(@"getCompaniesByLatitude error = %@, statusCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
//  [[ASServerManager sharedManager] getlistByLatitude:lat longtitude:lon subcategory:subcategory onSuccess:^(NSArray *array) {
//    self.placesArray = [NSArray arrayWithArray:array];
//    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
//    [self.tableView reloadData];
//  } onFailure:^(NSError *error, NSInteger statusCode) {
//    NSLog(@"getlistBySubcategory error = %@, statusCode = %ld", error.localizedDescription, (long)statusCode);
//  }];
  
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.filterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *placeCellIdentifier = @"PlaceCell";
  
  PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:placeCellIdentifier];
  
  if (!cell) {
    cell = (PlaceCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:placeCellIdentifier];
  }
  
  ASPlace *place = [self.filterArray objectAtIndex:indexPath.row];
  [cell configurateCellWithPlace:place];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 110.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  //    PlaceViewController *vc = [[PlaceViewController alloc] init];
  //    [self.navigationController pushViewController:vc animated:YES];
  
}

#pragma mark - Actions

- (void)actionResetFilters {
  self.subcategoryString = @"";
  [self getCompaniesByLocation];
  NSLog(@"actionResetFilters");
}

- (void)actionChooseAllCategory {
  NSLog(@"actionChooseAllCategory");
  
  if (self.filterTypeId == 1) {
    self.subcategoryString = @"1,2,3,4";
  } else if (self.filterTypeId == 2) {
    self.subcategoryString = @"5,6,7,8";
  } else if (self.filterTypeId == 3) {
    self.subcategoryString = @"9,10,11,12,13,14,15,16,17,18,19,20";
  }
  
  [self getCompaniesBySubcategory:self.subcategoryString];
  
}

- (void) actionCancelCategory {
  self.subcategoryString = @"";
  [self getCompaniesByLocation];
  NSLog(@"actionCancelCategory");
}

- (void)actionDelivery:(NSNotification *)notif {
  NSLog(@"actionDeliver");
//  UIButton *button = notif.object;
  
  [self createSubcategroryStringWithSubcategory:19];
  
//  if (button.tintColor == [UIColor whiteColor]) {
//    button.tintColor = selectFilterColor;
//  } else {
//    button.tintColor = [UIColor whiteColor];
//  }
}

- (void)actionTakeaway:(NSNotification *)notif {
  NSLog(@"actionTakeaway");
//  UIButton *button = notif.object;
  
  [self createSubcategroryStringWithSubcategory:20];
  
//  if (button.tintColor == [UIColor whiteColor]) {
//    button.tintColor = selectFilterColor;
//  } else {
//    button.tintColor = [UIColor whiteColor];
//  }
}

- (void) actionChooseSelectedFilterInOneLineView:(NSNotification *)notif {
  NSInteger tagId = [notif.object tag];
  NSLog(@"actionChooseSelectedFilterInOneLineView");
//  UIButton *button = notif.object;
  
  if (self.filterTypeId == 1) {
    switch (tagId) {
      case 1: {
        [self createSubcategroryStringWithSubcategory:1];
        break;
      }
      case 2: {
        [self createSubcategroryStringWithSubcategory:2];
        break;
      }
      case 3: {
        [self createSubcategroryStringWithSubcategory:3];
        break;
      }
      case 4: {
        [self createSubcategroryStringWithSubcategory:4];
        break;
      }
        
      default:
        break;
    }
  } else if (self.filterTypeId == 2) {
    switch (tagId) {
      case 1: {
        [self createSubcategroryStringWithSubcategory:5];
        break;
      }
      case 2: {
        [self createSubcategroryStringWithSubcategory:6];
        break;
      }
      case 3: {
        [self createSubcategroryStringWithSubcategory:7];
        break;
      }
      case 4: {
        [self createSubcategroryStringWithSubcategory:8];
        break;
      }
        
      default:
        break;
    }
  }
  
  if (self.subcategoryString != nil) {
    [self getCompaniesBySubcategory:self.subcategoryString];
  } else {
    [self getCompaniesByLocation];
  }
  
//  if (button.tintColor == [UIColor whiteColor]) {
//    button.tintColor = selectFilterColor;
//  } else {
//    button.tintColor = [UIColor whiteColor];
//  }
  
}

- (void) actionSelectedFilterButtonPressed:(NSNotification *)notif {
  NSInteger tagId = [notif.object tag];
  NSLog(@"actionSelectedFilterButtonPressed");
  
//  UIButton *button = notif.object;
  
  /*
   //Cat = 1 Drinks
   case Coffee = 1
   case Hot = 2
   case Ice = 3
   case Carry = 4
   //Cat = 2 Lounge
   case Beer = 5
   case Vine = 6
   case Strong = 7
   case Hookah = 8
   //Cat = 3 Food
   case Pizza = 9
   case Rolls = 10
   case Fastfood = 11
   case Breakfast = 12
   case Soup = 13
   case HotFood = 14
   case Vegan = 15
   case Exotic = 16
   case Dessert = 17
   case Bakery = 18
   case Delivery = 19
   case CarryFood = 20
   }
   */
  
  switch (tagId) {
    case 1: {
      [self createSubcategroryStringWithSubcategory:10];
      break;
    }
    case 2: {
      [self createSubcategroryStringWithSubcategory:9];
      break;
    }
    case 3: {
      [self createSubcategroryStringWithSubcategory:11];
      break;
    }
    case 4: {
      [self createSubcategroryStringWithSubcategory:14];
      break;
    }
    case 5: {
      [self createSubcategroryStringWithSubcategory:13];
      break;
    }
    case 6: {
      [self createSubcategroryStringWithSubcategory:12];
      break;
    }
    case 7: {
      [self createSubcategroryStringWithSubcategory:15];
      break;
    }
    case 8: {
      [self createSubcategroryStringWithSubcategory:16];
      break;
    }
    case 9: {
      [self createSubcategroryStringWithSubcategory:17];
      break;
    }
    case 10: {
      [self createSubcategroryStringWithSubcategory:18];
      break;
    }
    case 11: {
      break;
    }
    case 12: {
      break;
    }
      
    default:
      break;
  }
  
  if (self.subcategoryString != nil) {
    [self getCompaniesBySubcategory:self.subcategoryString];
  } else {
    [self getCompaniesByLocation];
  }
  
//  if (button.tintColor == [UIColor whiteColor]) {
//    button.tintColor = selectFilterColor;
//  } else {
//    button.tintColor = [UIColor whiteColor];
//  }
  
}

- (void)createSubcategroryStringWithSubcategory:(NSInteger) subcategoryId {
  
  NSMutableArray *subcatArray = [NSMutableArray arrayWithArray:[self.subcategoryString componentsSeparatedByString:@","]];
  NSString *subcatString = [NSString stringWithFormat:@"%ld", (long)subcategoryId];
  
  if (subcatArray.count == 1) {
    if ([subcatArray.firstObject isEqual: @""]) {
      [subcatArray removeObjectAtIndex:0];
    }
  }
  
  if ([subcatArray containsObject: subcatString]) {
    [subcatArray removeObject:subcatString];
  } else {
    [subcatArray addObject:subcatString];
  }
  
  subcatArray = (NSMutableArray *)[subcatArray sortedArrayUsingDescriptors:
                      @[[NSSortDescriptor sortDescriptorWithKey:@"intValue"
                                                      ascending:YES]]];
  
  NSString *resultString = @"";
  
  for (NSString *s in subcatArray) {
    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@,", s]];
  }
  
  if (resultString.length > 1) {
    resultString = [resultString stringByReplacingCharactersInRange:NSMakeRange(resultString.length - 1, 1) withString:@""];
  } else {
    resultString = nil;
  }
  
  self.subcategoryString = resultString;
  
  NSLog(@"subcategoryString = %@", self.subcategoryString);
  
}

#pragma mark - Segue
// openPlaceFromList

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"openPlaceFromList"]) {
    PlaceViewController *placeVC = segue.destinationViewController;
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ASPlace *place = [self.filterArray objectAtIndex:indexPath.row];
    placeVC.place = place;
    placeVC.myLocation = self.myLocation;
  }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  NSLog(@"didFailWithError: %@", error);
  UIAlertView *errorAlert = [[UIAlertView alloc]
                             initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
  CLLocation *currentLocation = newLocation;
  
  if (currentLocation != nil) {
    self.myLocation = currentLocation;
  }
}

@end
