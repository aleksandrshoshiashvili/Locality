//
//  ASPlace.h
//  Locality
//
//  Created by MacBookPro on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASServerManager.h"

@class ASPhoto;
@class ASFeatures;
@class ASDiscount;

@interface ASPlace : ASServerManager

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descr;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longtitude;
@property (strong, nonatomic) NSString *cityId;
@property (strong, nonatomic) NSString *workhours;
@property (assign, nonatomic) BOOL checked;

@property (strong, nonatomic) NSArray <ASDiscount *> *discountsArray;
@property (strong, nonatomic) NSArray <ASFeatures *> *featuresArray;
@property (strong, nonatomic) NSArray <ASPhoto *> *photosArray;

@end
