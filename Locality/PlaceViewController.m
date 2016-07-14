//
//  PlaceViewController.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "PlaceViewController.h"
#import "MEExpandableHeaderView.h"

#import "PlaceAddressCell.h"
#import "PlaceDiscountCell.h"
#import "PlaceMainDiscountCell.h"

#import "BLKFlexibleHeightBar.h"
#import "BLKDelegateSplitter.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "SquareCashStyleBar.h"

#import "Constants.h"

#import "ASPlace.h"
#import "ASFeatures.h"
#import "ASDiscount.h"

#import "ASServerManager.h"

typedef enum {
  PlaceCellTypeAddress,
  PlaceCellTypeDiscount
} PlaceCellType;


@interface PlaceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) SquareCashStyleBar *myCustomBar;
@property (nonatomic) BLKDelegateSplitter *delegateSplitter;
@property(nonatomic, strong) MEExpandableHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlaceViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  //    [self setupHeaderView];
  
  // Setup the bar
  //    self.myCustomBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];
  
  //#import <SDWebImage/UIImageView+WebCache.h>
  self.place = [[ASPlace alloc] init];
  self.place.uid = @"1";
  [self getPlacesById:self.place.uid];
  
  
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.navigationController.navigationBarHidden = YES;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setupViews {
  
  NSMutableArray *featuresArray = [NSMutableArray array];
  
//  if (self.place.featuresArray.count != 0) {
//    if (self.place.featuresArray.firstObject.cards) {
//      [featuresArray addObject:[UIImage imageNamed:@"debit512.png"]];
//    }
//    if (self.place.featuresArray.firstObject.wifi) {
//      [featuresArray addObject:[UIImage imageNamed:@"wifi512.png"]];
//    }
//  }
  
  if (self.place.card) {
    [featuresArray addObject:[UIImage imageNamed:@"debit512.png"]];
  }
  if (self.place.wifi) {
    [featuresArray addObject:[UIImage imageNamed:@"wifi512.png"]];
  }
  
  self.myCustomBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)
                                                     placeName:self.place.name
                                                      features:featuresArray
                                                      workhour:self.place.workhours
                                                      imageUrl:self.place.imageUrl];
  
  SquareCashStyleBehaviorDefiner *behaviorDefiner = [[SquareCashStyleBehaviorDefiner alloc] init];
  [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
  [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
  behaviorDefiner.snappingEnabled = YES;
  behaviorDefiner.elasticMaximumHeightAtTop = NO; // Когда тянешь вниз
  self.myCustomBar.behaviorDefiner = behaviorDefiner;
  // Configure a separate UITableViewDelegate and UIScrollViewDelegate (optional)
  self.delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:behaviorDefiner secondDelegate:self];
  
  self.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
  self.tableView.dataSource = self;
  
  [self.view addSubview:self.myCustomBar];
  
  // Setup the table view
  //    self.tableView.contentOffset = CGPointMake(0.0, self.myCustomBar.maximumBarHeight);
  self.tableView.contentInset = UIEdgeInsetsMake(self.myCustomBar.maximumBarHeight, 0.0, 0.0, 0.0);
  self.tableView.backgroundColor = appMainColor;
  
  // Add close button - it's pinned to the top right corner, so it doesn't need to respond to bar height changes
  UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  closeButton.frame = CGRectMake(0.0 + 8.0, 30.0, 20.0, 20.0);
  closeButton.tintColor = [UIColor whiteColor];
  [closeButton setImage:[UIImage imageNamed:@"back512.png"] forState:UIControlStateNormal];
  [closeButton addTarget:self action:@selector(closeViewController:) forControlEvents:UIControlEventTouchUpInside];
  [self.myCustomBar addSubview:closeButton];
}

#pragma mark - Load

- (void)getSharesByIdString {
  
  [[ASServerManager sharedManager] getSharesBySharesIdString:self.place.sharesString onSuccess:^(NSArray *array) {
    self.place.discountsArray = [NSArray arrayWithArray:array];
    [self.tableView reloadData];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    NSLog(@"getSharesBySharesIdString error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
}

- (void)getPlacesById:(NSString *)placeId {
  
  [[ASServerManager sharedManager] getCompanyWithId:placeId latitude:self.myLocation.coordinate.latitude longtitude:self.myLocation.coordinate.longitude onSuccess:^(ASPlace *place) {
    self.place = place;
    [self getSharesByIdString];
    [self setupViews];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    NSLog(@"getCompanyWithId error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
//  [[ASServerManager sharedManager] getlistByPlaceId:[placeId stringValue] onSuccess:^(ASPlace *place) {
//    self.place = place;
//    [self setupViews];
//  } onFailure:^(NSError *error, NSInteger statusCode) {
//    NSLog(@"getlistByPlaceId error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
//  }];
  
}

#pragma mark - Actions

- (void)closeViewController:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.row) {
    case PlaceCellTypeAddress: {
      return 62.0;
    }
    case PlaceCellTypeDiscount: {
      return 73.0;
    }
    default: {
      return 29.0;
    }
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.place.discountsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *placeInfoCellIdentifier = @"PlaceInfoCell";
  static NSString *placeAddressCellIdentifier = @"PlaceAddressCell";
  static NSString *placeMainDiscountCellCellIdentifier = @"PlaceMainDiscountCell";
  static NSString *placeDiscountCellCellIdentifier = @"PlaceDiscountCell";
  
  switch (indexPath.row) {
    case PlaceCellTypeAddress: {
      
      PlaceAddressCell *placeAddressCell = (PlaceAddressCell *)[tableView dequeueReusableCellWithIdentifier:placeAddressCellIdentifier];
      
      if (!placeAddressCell) {
        placeAddressCell = (PlaceAddressCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeAddressCellIdentifier];
      }
      
      placeAddressCell.labelAddress.text = self.place.address;
      placeAddressCell.labelDistance.text = [NSString stringWithFormat:@"%@ км.", self.place.distance];
      placeAddressCell.backgroundColor = [UIColor lightGrayColor];
      
      return placeAddressCell;
      
      break;
    }
    case PlaceCellTypeDiscount: {
      PlaceMainDiscountCell *placeMaintDiscountCell = (PlaceMainDiscountCell *)[tableView dequeueReusableCellWithIdentifier:placeMainDiscountCellCellIdentifier];
      
      if (!placeMaintDiscountCell) {
        placeMaintDiscountCell = (PlaceMainDiscountCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeMainDiscountCellCellIdentifier];
      }
      
      ASDiscount *share = [self.place.discountsArray firstObject];
      
      placeMaintDiscountCell.discountLabel.text = share.name;
      placeMaintDiscountCell.discountDesctLabel.text = share.descr;
      
      return placeMaintDiscountCell;
      
      break;
    }
      
    default: {
      
      PlaceDiscountCell *placeDicountCell = (PlaceDiscountCell *)[tableView dequeueReusableCellWithIdentifier:placeDiscountCellCellIdentifier];
      
      if (!placeDicountCell) {
        placeDicountCell = (PlaceDiscountCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeDiscountCellCellIdentifier];
      }
      
      ASDiscount *share = [self.place.discountsArray objectAtIndex:indexPath.row - 2];
      
      placeDicountCell.discountLabel.text = share.name;
      placeDicountCell.backgroundColor = [UIColor whiteColor];
      
      return placeDicountCell;
      
      break;
    }
  }
  
  return nil;
  
}

#pragma mark - UITableViewDelegate

- (void)setupHeaderView {
  CGSize headerViewSize = CGSizeMake(320, 200);
  //    UIImage *backgroundImage = [UIImage imageNamed:@"testImage.jpg"];
  NSArray *images = @[@"http://www.topograph.ru/upload/iblock/46d/1.jpg", @"http://1.bp.blogspot.com/-q1Zuyf37-sc/UH_8Rv7NGOI/AAAAAAAACXI/_SyMJ2Du2Fk/s1600/sixty_resto2.jpg", @"http://family.ru/data/photo/1348127246.jpg", @"http://maybe-you.ru/wp-content/uploads/2013/08/image_3.jpg"];
  NSArray *pages = @[[self createPageViewWithText:@"First page"],
                     [self createPageViewWithText:@"Second page"],
                     [self createPageViewWithText:@"Third page"],
                     [self createPageViewWithText:@"Fourth page"]];
  //    MEExpandableHeaderView *headerView = [[MEExpandableHeaderView alloc] initWithSize:headerViewSize
  //                                                                      backgroundImage:backgroundImage
  //                                                                         contentPages:pages];
  MEExpandableHeaderView *headerView = [[MEExpandableHeaderView alloc] initWithSize:headerViewSize
                                                                             images:images
                                                                       contentPages:pages];
  
  headerView.frame = CGRectMake(0, 0, headerViewSize.width, headerViewSize.height);
  self.headerView = headerView;
  
  [self.view addSubview:self.headerView];
  
}

- (UIView*)createPageViewWithText:(NSString*)text {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
  
  label.font = [UIFont boldSystemFontOfSize:27.0];
  label.textColor = [UIColor whiteColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor clearColor];
  label.shadowColor = [UIColor darkGrayColor];
  label.shadowOffset = CGSizeMake(0, 1);
  label.text = text;
  
  return label;
}

#pragma mark - System

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
