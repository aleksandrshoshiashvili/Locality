//
//  MapViewController.m
//  Locality
//
//  Created by MacBookPro on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

//061789
#import <GoogleMaps/GoogleMaps.h>

#import "MapViewController.h"
#import "PlaceViewController.h"

#import "InfoWindowOfMarkerView.h"

#import "Constants.h"

@interface MapViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property (strong, readwrite, nonatomic) GMSMapView *mapView;
@property (assign, nonatomic) BOOL firstLocationUpdate;
@property (strong, nonatomic) InfoWindowOfMarkerView *infoWindow;
@property (assign, nonatomic) BOOL isInfoWindowShown;

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
//    CGFloat navBarHeight = 64.0;
    mapFrame.size.height = mapFrame.size.height - tabBarHeight;// - navBarHeight;
//    mapFrame.origin.y = navBarHeight;
    
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

    [self setMarkerWithPosition:_mapView.myLocation.coordinate];
    
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
    
    [UIView animateWithDuration:animateDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _infoWindow.center = CGPointMake(self.view.center.x, self.view.frame.size.height - tabBarHeight - _infoWindow.frame.size.height / 2.0);
                     } completion:^(BOOL finished) {
                         _isInfoWindowShown = YES;
                     }];
    
}

- (void)hideInfoWindow:(BOOL)animated {
    CGFloat animateDuration = 0.0;
    
    if (animated) {
        animateDuration = 0.5;
    }
    
    [UIView animateWithDuration:animateDuration animations:^{
        _infoWindow.center = CGPointMake(self.view.center.x, self.view.frame.size.height + tabBarHeight + _infoWindow.frame.size.height / 2.0);
    } completion:^(BOOL finished) {
        _isInfoWindowShown = NO;
    }];
    
}

#pragma mark - Actions

- (void)actionInfoWindowDidSelected {
    
    PlaceViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"PlaceViewController"];
    [self.navigationController presentViewController:vc animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
}

#pragma mark - GMSMapViewDelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    
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
