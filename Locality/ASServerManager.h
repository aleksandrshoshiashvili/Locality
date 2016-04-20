//
//  ASServerManager.h
//  APITest
//
//  Created by Александр on 02.04.15.
//  Copyright (c) 2015 Александр. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASPlace;

@interface ASServerManager : NSObject

+ (ASServerManager *) sharedManager;

#pragma mark - Place

- (void) getlistByLatitude:(double)lat
                longtitude:(double)lon
                 onSuccess:(void(^)(NSArray *array)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getlistByPlaceId:(NSString *)placeId
                onSuccess:(void(^)(ASPlace *place)) success
                onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getlistByLatitude:(double)lat
                longtitude:(double)lon
               subcategory:(NSString *)subcategory
                 onSuccess:(void(^)(NSArray *array)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
