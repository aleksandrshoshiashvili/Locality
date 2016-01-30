//
//  ASServerManager.h
//  APITest
//
//  Created by Александр on 02.04.15.
//  Copyright (c) 2015 Александр. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASServerManager : NSObject

+ (ASServerManager *) sharedManager;

#pragma mark - Place

- (void) getPlace:(NSString *) placeID
        onSuccess:(void(^)(NSArray *array)) success
        onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;



@end
