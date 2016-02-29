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

#import "InfoWindowOfMarkerView.h"

#import "ASPlace.h"

@interface MapViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property (strong, readwrite, nonatomic) GMSMapView *mapView;
@property (assign, nonatomic) BOOL firstLocationUpdate;
@property (strong, nonatomic) InfoWindowOfMarkerView *infoWindow;
@property (assign, nonatomic) BOOL isInfoWindowShown;
@property (strong, nonatomic) UIView *emptyView;

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
  
    _viewForMap.backgroundColor = appMainColor;
    [self.view insertSubview:(UIView *)self.twoLineFilterView aboveSubview:_mapView];
    
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
    
    for (int i = 0; i < 10; i++) {
        
        double lat = (double)arc4random_uniform(1080) / 3.0;
        double lon = (double)arc4random_uniform(1080) / 3.0;
        
        [self setMarkerWithPosition:CLLocationCoordinate2DMake(lat, lon)];
        
    }
    
}

- (void)setCoordinate:(double)latitude and:(double)longtitude {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longtitude
                                                                 zoom:16];
    
    [_mapView animateToCameraPosition:camera];
    
}

- (void)setMarkerWithPosition:(CLLocationCoordinate2D)position {
    
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    
    marker.map = _mapView;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
    marker.opacity = 0.75;
//    marker.infoWindowAnchor = CGPointMake(0.5, 0.2);
    marker.flat = YES;
//    marker.snippet = @"The best place on earth.";
//    marker.title = @"Somewhere";
//    marker.userData !!!
    
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
    
//    NSDictionary *dict = marker.userData;
    _infoWindow.labelPlaceName.text = @"Смузичная";
    _infoWindow.labelDiscountName.text = @"Носки от Рокетбанка";
    
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

- (void)mapView:(GMSMapView *)mapView
didChangeCameraPosition:(GMSCameraPosition *)position {
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
    }
}

@end
