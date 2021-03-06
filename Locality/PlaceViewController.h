//
//  PlaceViewController.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class ASPlace;

@interface PlaceViewController : UIViewController

@property (strong, nonatomic) ASPlace *place;
@property (strong, nonatomic) CLLocation *myLocation;

@end
