//
//  ASServerManager.m
//  APITest
//
//  Created by Александр on 02.04.15.
//  Copyright (c) 2015 Александр. All rights reserved.
//

#import "ASServerManager.h"
#import "AFNetworking.h"
#import "ASPlace.h"
#import "ASFeatures.h"
#import "ASDiscount.h"
#import "ASCity.h"

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
    
    NSURL *url = [NSURL URLWithString:@"http://discountspanel.ru/api/"];
    
    self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    self.requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
  }
  return self;
}

- (void) getlistByLatitude:(double)lat
                longtitude:(double)lon
                 onSuccess:(void(^)(NSArray *array)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  NSDictionary *params =
  [NSDictionary dictionaryWithObjectsAndKeys:
   @(lat),        @"lat",
   @(lon),        @"long", nil];
  
  [self.requestOperationManager
   GET:@"getlist"
   parameters:params
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSDictionary *responseDict = (NSDictionary *)responseObject;
     
     NSArray *dictsArray  = responseDict.allValues;
     
     NSMutableArray *resultPlacesArray = [NSMutableArray array];
     
     for (NSDictionary *placeDict in dictsArray) {
       
       NSLog(@"placeDict = %@", placeDict);
       
       ASPlace *place = [[ASPlace alloc] initWithServerResponse:placeDict];
       [resultPlacesArray addObject:place];
       
     }
     
     if ([resultPlacesArray count] > 0) {
       if (success) {
         success(resultPlacesArray);
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

- (void) getlistByPlaceId:(NSString *)placeId
                onSuccess:(void(^)(ASPlace *place)) success
                onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  NSDictionary *params =
  [NSDictionary dictionaryWithObjectsAndKeys:
   placeId,        @"placeid", nil];
  
  [self.requestOperationManager
   GET:@"getplace"
   parameters:params
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSLog(@"JSON: %@", responseObject);
     
     NSDictionary *placeDict  = [responseObject objectForKey:@"place"];
     
     ASPlace *place = [[ASPlace alloc] initWithServerResponse:placeDict];
     
     if ([responseObject objectForKey:@"photos"] != nil) {
       place.imageUrl = [[[responseObject objectForKey:@"photos"] objectForKey:@"0"] objectForKey:@"url"];
     }
     
     NSDictionary *featuresDict = [responseObject objectForKey:@"features"];
     
     ASFeatures *feature = [[ASFeatures alloc] initWithServerResponse:featuresDict];
     
     NSDictionary *discsDict = [responseObject objectForKey:@"discs"];
     
     NSArray *discsArray = discsDict.allValues;
     NSMutableArray *discsResultArray = [NSMutableArray array];
     
     for (NSDictionary *disc in discsArray) {
       ASDiscount *discount = [[ASDiscount alloc] initWithServerResponse:disc];
       [discsResultArray addObject:discount];
     }
     
     place.featuresArray = @[feature];
     place.discountsArray = [NSArray arrayWithArray:discsResultArray];
     
     if (place != nil) {
       if (success) {
         success(place);
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

#pragma mark - Category

- (void) getlistByLatitude:(double)lat
                longtitude:(double)lon
               subcategory:(NSString *)subcategory
                 onSuccess:(void(^)(NSArray *array)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  
  NSDictionary *params =
  [NSDictionary dictionaryWithObjectsAndKeys:
   @(lat),        @"lat",
   @(lon),        @"long",
   [NSString stringWithFormat:@"(%@)", subcategory],   @"subcat", nil];
  
  [self.requestOperationManager
   GET:@"getlist"
   parameters:params
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSDictionary *responseDict = (NSDictionary *)responseObject;
     
     NSArray *dictsArray  = responseDict.allValues;
     
     NSMutableArray *resultPlacesArray = [NSMutableArray array];
     
     for (NSDictionary *placeDict in dictsArray) {
       
       NSLog(@"placeDict = %@", placeDict);
       
       ASPlace *place = [[ASPlace alloc] initWithServerResponse:placeDict];
       [resultPlacesArray addObject:place];
       
     }
     
     if ([resultPlacesArray count] > 0) {
       if (success) {
         success(resultPlacesArray);
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

- (void)getCitiesOnSuccess:(void(^)(NSArray *array)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  
  [self.requestOperationManager
   GET:@"cities"
   parameters:nil
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSArray *responseDict = (NSArray *)responseObject;
     NSMutableArray *resultArray = [NSMutableArray array];
     
     for (NSDictionary *dict in responseDict) {
       ASCity *city = [[ASCity alloc] initWithServerResponse:dict];
       [resultArray addObject:city];
     }
     
     if ([resultArray count] > 0) {
       if (success) {
         success(resultArray);
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

- (void)getCompanyWithId:(NSString *)companyId
                      latitude:(double)lat
                    longtitude:(double)lon
                     onSuccess:(void(^)(ASPlace *place)) success
                     onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  
  [self.requestOperationManager
   GET:[NSString stringWithFormat:@"companies/%@/lat%lf&lng%lf", companyId, lat, lon]
   parameters:nil
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSDictionary *responseDict = (NSDictionary *)[(NSArray *)responseObject firstObject];
     
     if (responseDict != nil) {
       ASPlace *place = [[ASPlace alloc] initWithServerResponse:responseDict];
       if (success) {
         success(place);
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

- (void)getCompanyWithId:(NSString *)companyId
               onSuccess:(void(^)(ASPlace *place)) success
               onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  
  [self.requestOperationManager
   GET:[NSString stringWithFormat:@"companies/%@", companyId]
   parameters:nil
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSDictionary *responseDict = (NSDictionary *)[(NSArray *)responseObject firstObject];
     
     if (responseDict != nil) {
       ASPlace *place = [[ASPlace alloc] initWithServerResponse:responseDict];
       if (success) {
         success(place);
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

- (void)getCompaniesByLatitude:(double)lat
               longtitude:(double)lon
                  category:(NSString *)cat
               subcategory:(NSString *)subcat
                onSuccess:(void(^)(NSArray *array)) success
                onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  
  [self.requestOperationManager
   GET:[NSString stringWithFormat:@"companies/lat%lf&lng%lf&cat%@&subcat%@", lat, lon, cat, subcat]
   parameters:nil
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSArray *responseDict = (NSArray *)responseObject;
     
     NSMutableArray *resultPlacesArray = [NSMutableArray array];
     
     for (NSDictionary *placeDict in responseDict) {
       
       NSLog(@"placeDict = %@", placeDict);
       ASPlace *place = [[ASPlace alloc] initWithServerResponse:placeDict];
       [resultPlacesArray addObject:place];
     }
     
     if ([resultPlacesArray count] > 0) {
       if (success) {
         success(resultPlacesArray);
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

- (void)getCompaniesByLatitude:(double)lat
                    longtitude:(double)lon
                     onSuccess:(void(^)(NSArray *array)) success
                     onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  
  [self.requestOperationManager
   GET:[NSString stringWithFormat:@"companies/lat%lf&lng%lf", lat, lon]
   parameters:nil
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSArray *responseDict = (NSArray *)responseObject;
     
     NSMutableArray *resultPlacesArray = [NSMutableArray array];
     
     for (NSDictionary *placeDict in responseDict) {
       
       NSLog(@"placeDict = %@", placeDict);
       ASPlace *place = [[ASPlace alloc] initWithServerResponse:placeDict];
       [resultPlacesArray addObject:place];
     }
     
     if ([resultPlacesArray count] > 0) {
       if (success) {
         success(resultPlacesArray);
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

- (void)getSharesBySharesIdString:(NSString *) sharesString
                        onSuccess:(void(^)(NSArray *array)) success
                        onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
  
  [self.requestOperationManager
   GET:[NSString stringWithFormat:@"shares/%@", sharesString]
   parameters:nil
   success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"JSON: %@", responseObject);
     
     NSArray *responseDict = (NSArray *)responseObject;
     
     NSMutableArray *resultPlacesArray = [NSMutableArray array];
     
     for (NSDictionary *placeDict in responseDict) {
       ASDiscount *share = [[ASDiscount alloc] initWithServerResponse:placeDict];
       [resultPlacesArray addObject:share];
     }
     
     if ([resultPlacesArray count] > 0) {
       if (success) {
         success(resultPlacesArray);
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
