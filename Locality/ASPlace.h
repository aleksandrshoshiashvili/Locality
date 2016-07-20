//
//  ASPlace.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASServerObject.h"

@class ASPhoto;
@class ASFeatures;
@class ASDiscount;

@interface ASPlace : ASServerObject

@property (strong, nonatomic) NSString *descr;
@property (strong, nonatomic) NSString *accountId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *cityId;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *photosString;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longtitude;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *sharesString;
@property (assign, nonatomic) BOOL working;
@property (assign, nonatomic) BOOL wifi;
@property (assign, nonatomic) BOOL card;

@property (assign, nonatomic) NSInteger sharesCount;
@property (strong, nonatomic) NSString *sharesCountString;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *workhours;
@property (assign, nonatomic) BOOL checked;

@property (strong, nonatomic) NSString *disctitle;
@property (strong, nonatomic) NSNumber *category;
@property (strong, nonatomic) NSNumber *subcategory;
@property (strong, nonatomic) NSString *imageUrl;

@property (strong, nonatomic) NSArray <ASDiscount *> *discountsArray;
@property (strong, nonatomic) NSArray <ASFeatures *> *featuresArray;
@property (strong, nonatomic) NSArray <ASPhoto *> *photosArray;

- (id) initWithServerResponse:(NSDictionary *) responseObject;

@end
