//
//  MapViewController.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

//061789
#import <GoogleMaps/GoogleMaps.h>

#import "MapViewController.h"
#import "PlaceViewController.h"

#import "ASServerManager.h"

#import "InfoWindowOfMarkerView.h"

#import "ASPlace.h"
#import "ASDiscount.h"

@interface MapViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property (strong, readwrite, nonatomic) GMSMapView *mapView;
@property (assign, nonatomic) BOOL firstLocationUpdate;
@property (strong, nonatomic) InfoWindowOfMarkerView *infoWindow;
@property (assign, nonatomic) BOOL isInfoWindowShown;
@property (strong, nonatomic) UIView *emptyView;

@property (strong, nonatomic) NSArray *placesArray;
@property (strong, nonatomic) NSMutableArray *filterArray;
@property (strong, nonatomic) CLLocation *myLocation;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@end

@implementation MapViewController

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self initMap];
  [self initInfoWindowOfMarkerView];
  [self getCompaniesByLocation];
  [self setupNotifications];
  
  _viewForMap.backgroundColor = appMainColor;
  [self.view insertSubview:(UIView *)self.twoLineFilterView aboveSubview:_mapView];
  [self.view insertSubview:self.errorView aboveSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [_mapView removeObserver:self
                forKeyPath:@"myLocation"
                   context:NULL];
}

#pragma mark - Notifications

- (void)setupNotifications {
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionChooseAllCategory) name:@"actionChooseAllNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCancelCategory) name:@"actionCancelNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionChooseSelectedFilterInOneLineView:) name:@"actionChooseFilterInOneLineViewNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionSelectedFilterButtonPressed:) name:@"actionFilterButtonPressedNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionResetFilters) name:@"actionResetFiltersNotification" object:nil];
}

#pragma mark - Map

- (void)initMap {
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                          longitude:151.2086
                                                               zoom:35];
  
  CGRect mapFrame = self.view.frame;
  mapFrame.origin.y = statusBarHeight;
  mapFrame.size.height = mapFrame.size.height - tabBarHeight - navBarHeight;
  mapFrame.origin.y = navBarHeight;
  
  _mapView = [GMSMapView mapWithFrame:mapFrame camera:camera];
  //    _mapView.settings.compassButton = YES;
  _mapView.settings.myLocationButton = YES;
  
  _mapView.delegate = self;
  
  // Listen to the myLocation property of GMSMapView.
  [_mapView addObserver:self
             forKeyPath:@"myLocation"
                options:NSKeyValueObservingOptionNew
                context:NULL];
  
  [self.view addSubview:_mapView];
  [self.view insertSubview:(UIView *)self.oneLineFilterView aboveSubview:_mapView];
  
  // Ask for My Location data after the map has already been added to the UI.
  dispatch_async(dispatch_get_main_queue(), ^{
    _mapView.myLocationEnabled = YES;
  });
  
}

- (void)createPins {
  for (ASPlace *place in self.placesArray) {
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.latitude, place.longtitude);
    [self setMarkerWithPosition:position andPlace:place];
  }
//  for (int i = 0; i < 10; i++) {
//    
//    double lat = (double)arc4random_uniform(1080) / 3.0;
//    double lon = (double)arc4random_uniform(1080) / 3.0;
//    
////    [self setMarkerWithPosition:CLLocationCoordinate2DMake(lat, lon) andPlace:place];
//    
//  }
  
}

#pragma mark - Load Companies

- (void)getCompaniesByLocation {
  [[ASServerManager sharedManager] getCompaniesByLatitude:self.myLocation.coordinate.latitude longtitude:self.myLocation.coordinate.longitude onSuccess:^(NSArray *array) {
    self.placesArray = [NSArray arrayWithArray:array];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self createPins];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    NSLog(@"getCompaniesByLatitude error = %@, statusCode = %ld", error.localizedDescription, (long)statusCode);
  }];
}

- (void)getCompaniesBySubcategory:(NSString *)subcat {
  [[ASServerManager sharedManager] getCompaniesByLatitude:self.myLocation.coordinate.latitude longtitude:self.myLocation.coordinate.longitude category:[NSString stringWithFormat:@"%ld", (long)self.filterTypeId] subcategory:subcat onSuccess:^(NSArray *array) {
    self.placesArray = [NSArray arrayWithArray:array];
    self.filterArray = [NSMutableArray arrayWithArray:self.placesArray];
    self.errorView.hidden = YES;
    [self createPins];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    if (statusCode == 200 || error.localizedDescription == nil) {
      self.errorView.hidden = NO;
    }
    NSLog(@"getCompaniesByLatitude error = %@, statusCode = %ld", error.localizedDescription, (long)statusCode);
  }];
}

- (void)setCoordinate:(double)latitude and:(double)longtitude {
  
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                          longitude:longtitude
                                                               zoom:16];
  
  [_mapView animateToCameraPosition:camera];
  
}

- (void)setMarkerWithPosition:(CLLocationCoordinate2D)position andPlace:(ASPlace*)place {
  
  GMSMarker *marker = [GMSMarker markerWithPosition:position];
  
  marker.map = _mapView;
  marker.appearAnimation = kGMSMarkerAnimationPop;
  marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
  marker.opacity = 0.75;
  //    marker.infoWindowAnchor = CGPointMake(0.5, 0.2);
  marker.flat = YES;
  //    marker.snippet = @"The best place on earth.";
  //    marker.title = @"Somewhere";
  marker.userData = place;
  
}

- (void)setMarkerWithPlace:(ASPlace *)place style:(PlaceStyleType)styleType {
  
  CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.latitude, place.longtitude);
  
  GMSMarker *marker = [GMSMarker markerWithPosition:position];
  
  marker.map = _mapView;
  marker.appearAnimation = kGMSMarkerAnimationPop;
  
  UIImage *markerIcon = nil;
  
  switch (styleType) {
    case 0: {
      markerIcon = [UIImage imageNamed:@"location512.png"];
      break;
    }
    case 1: {
      break;
    }
    case 2: {
      break;
    }
      
    default:
      break;
  }
  
  marker.icon = markerIcon;
  marker.opacity = 0.75;
  marker.flat = YES;
  marker.userData = place;
  
}

#pragma mark - InfoWindowOfMarkerView

- (void)initInfoWindowOfMarkerView {
  InfoWindowOfMarkerView *view = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindowOfMarkerView" owner:self options:nil] objectAtIndex:0];
  view.frame = CGRectMake(0, self.view.frame.size.height + tabBarHeight + 110, self.view.frame.size.width, 110);
  _infoWindow = view;
  
  UITapGestureRecognizer *infoWindowTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionInfoWindowDidSelected)];
  [_infoWindow addGestureRecognizer:infoWindowTap];
  
  [self.view addSubview:_infoWindow];
}

- (void)configurateInfoWindowWithMarker:(GMSMarker *)marker {
  
  ASPlace *place = marker.userData;
  
  [[ASServerManager sharedManager] getSharesBySharesIdString:place.sharesString onSuccess:^(NSArray *array) {
    place.discountsArray = [NSArray arrayWithArray:array];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      ASDiscount *discount = [place.discountsArray firstObject];
      _infoWindow.labelDiscountName.text = discount.name;
    });
    
  } onFailure:^(NSError *error, NSInteger statusCode) {
    NSLog(@"getSharesBySharesIdString error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
  _infoWindow.labelPlaceName.text = place.name;
  _infoWindow.labelAddress.text = place.address;
  _infoWindow.labelDistance.text = [NSString stringWithFormat:@"%@ м.", place.distance];
  _infoWindow.labelDiscountsCount.text = place.sharesCountString;
  
}

- (void)showInfoWindow:(BOOL)animated {
  CGFloat animateDuration = 0.0;
  
  if (animated) {
    animateDuration = 0.5;
  }
  
  _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - _infoWindow.frame.size.height)];
  
  [self.view addSubview:_emptyView];
  
  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideInfoWindow)];
  UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideInfoWindow)];
  swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp;
  [_emptyView addGestureRecognizer:tapGestureRecognizer];
  [_emptyView addGestureRecognizer:swipeGestureRecognizer];
  
  [UIView animateWithDuration:animateDuration
                        delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     _infoWindow.center = CGPointMake(self.view.center.x, self.view.frame.size.height - tabBarHeight - _infoWindow.frame.size.height / 2.0);
                   } completion:^(BOOL finished) {
                     _isInfoWindowShown = YES;
                   }];
  
}

- (void)hideInfoWindow {
  [self hideInfoWindow:YES];
}

- (void)hideInfoWindow:(BOOL)animated {
  CGFloat animateDuration = 0.0;
  
  if (animated) {
    animateDuration = 0.5;
  }
  
  [_emptyView removeFromSuperview];
  
  [UIView animateWithDuration:animateDuration animations:^{
    _infoWindow.center = CGPointMake(self.view.center.x, self.view.frame.size.height + tabBarHeight + _infoWindow.frame.size.height / 2.0);
  } completion:^(BOOL finished) {
    _isInfoWindowShown = NO;
  }];
  
}

#pragma mark - Actions

- (void)actionInfoWindowDidSelected {
  
  PlaceViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"PlaceViewController"];
  [self.navigationController pushViewController:vc animated:YES];
  
}

#pragma mark - GMSMapViewDelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
  
  [self setCoordinate:marker.position.latitude and:marker.position.longitude];
  
  [self configurateInfoWindowWithMarker:marker];
  [self showInfoWindow:YES];
  
  return YES;
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
  if (self.isInfoWindowShown) {
    [self hideInfoWindow:YES];
  }
}

#pragma mark -

- (void)place:(ASPlace *)place {
  
  
  
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (!_firstLocationUpdate) {
    // If the first location update has not yet been recieved, then jump to that
    // location.
    _firstLocationUpdate = YES;
    CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
    _mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                     zoom:14];
    _myLocation = location;
  }
}

#pragma mark - Notifications Actions

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
    self.subcategoryString = @"9,10,11,12,13,14,15,16,17,18";
  }
  
  [self getCompaniesBySubcategory:self.subcategoryString];
  
}

- (void) actionCancelCategory {
  self.subcategoryString = @"";
  [self getCompaniesByLocation];
  NSLog(@"actionCancelCategory");
}

- (void) actionChooseSelectedFilterInOneLineView:(NSNotification *)notif {
  NSInteger tagId = [notif.object tag];
  NSLog(@"actionChooseSelectedFilterInOneLineView");
  
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
  
  [self getCompaniesBySubcategory:self.subcategoryString];
  
}

- (void) actionSelectedFilterButtonPressed:(NSNotification *)notif {
  NSInteger tagId = [notif.object tag];
  NSLog(@"actionSelectedFilterButtonPressed");
  
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
  
  [self getCompaniesBySubcategory:self.subcategoryString];
  
}

- (void) createSubcategroryStringWithSubcategory:(NSInteger) subcategoryId {
  
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
  
  NSString *resultString = @"";
  
  for (NSString *s in subcatArray) {
    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@,", s]];
  }
  
  if (resultString.length > 1) {
    resultString = [resultString stringByReplacingCharactersInRange:NSMakeRange(resultString.length - 1, 1) withString:@""];
  } else {
    resultString = @"";
  }
  
  self.subcategoryString = resultString;
  
  NSLog(@"%@", self.subcategoryString);
  
}

@end
