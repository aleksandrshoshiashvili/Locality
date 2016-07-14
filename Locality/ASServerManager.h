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

- (void)getCitiesOnSuccess:(void(^)(NSArray *array)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getCompanyWithId:(NSString *)companyId
                latitude:(double)lat
              longtitude:(double)lon
               onSuccess:(void(^)(ASPlace *place)) success
               onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getCompanyWithId:(NSString *)companyId
               onSuccess:(void(^)(ASPlace *place)) success
               onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getCompaniesByLatitude:(double)lat
                    longtitude:(double)lon
                      category:(NSString *)cat
                   subcategory:(NSString *)subcat
                     onSuccess:(void(^)(NSArray *array)) success
                     onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getCompaniesByLatitude:(double)lat
                    longtitude:(double)lon
                     onSuccess:(void(^)(NSArray *array)) success
                     onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getSharesBySharesIdString:(NSString *) sharesString
                        onSuccess:(void(^)(NSArray *array)) success
                        onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
