//
//  ASServerManager.m
//  APITest
//
//  Created by Александр on 02.04.15.
//  Copyright (c) 2015 Александр. All rights reserved.
//

#import "ASServerManager.h"
#import "AFNetworking.h"

@interface ASServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation ASServerManager

+ (ASServerManager *) sharedManager {
    
    static ASServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASServerManager alloc] init];
    });
    
    return manager;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"https://nmaidanov.ru/"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        self.requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

- (void) getPlace:(NSString *) placeID
       onSuccess:(void(^)(NSArray *array)) success
       onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     placeID,        @"place_id", nil];
    
    [self.requestOperationManager
     GET:@"place.get"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSArray *dictsArray  = [responseObject objectForKey:@"response"];
         
         if ([dictsArray count] > 0) {
             if (success) {
                 success(dictsArray);
             }
         } else {
             if (failure) {
                 failure(nil, operation.response.statusCode);
             }
         }
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
         
     }];
    
}

@end
