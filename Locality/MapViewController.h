//
//  MapViewController.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentViewController.h"

typedef enum {
    PlaceStyleTypeDrinks,
    PlaceStyleTypeLounge,
    PlaceStyleTypeFood
} PlaceStyleType;

@interface MapViewController : ParentViewController

- (void)setCoordinate:(double)latitude and:(double)longtitude;

@end
