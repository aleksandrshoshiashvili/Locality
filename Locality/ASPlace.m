//
//  ASPlace.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASPlace.h"

@implementation ASPlace

- (id) initWithServerResponse:(NSDictionary *) responseObject {
  self = [super initWithServerResponse:responseObject];
  if (self) {
    
    self.uid = [responseObject objectForKey:@"id"];
    self.accountId = [responseObject objectForKey:@"account_id"];
    self.name = [responseObject objectForKey:@"name"];
    self.descr = [responseObject objectForKey:@"description"];
    self.cityId = [responseObject objectForKey:@"city_id"];
    self.address = [responseObject objectForKey:@"address"];
    self.photosString = [responseObject objectForKey:@"photos"];
    self.sharesString = [responseObject objectForKey:@"shares"];
    self.distance = [responseObject objectForKey:@"distance"];

    
    
//    self.address = [responseObject objectForKey:@"address"];
//    self.distance = [responseObject objectForKey:@"distance"];
//    
//    self.disctitle = [responseObject objectForKey:@"disctitle"];
//    
//    self.category = [responseObject objectForKey:@"category"];
//    self.subcategory = [responseObject objectForKey:@"subcategory"];
//    
//    self.descr = [responseObject objectForKey:@"descr"];
//    self.title = [responseObject objectForKey:@"title"];
//    self.uid = [responseObject objectForKey:@"placeid"];
    
    if ([responseObject objectForKey:@"working"]!= nil) {
      self.working = [[responseObject objectForKey:@"working"] boolValue];
    } else {
      self.working = false;
    }
    
    if ([responseObject objectForKey:@"wifi_status"]!= nil) {
      self.wifi = [[responseObject objectForKey:@"wifi_status"] boolValue];
    } else {
      self.wifi = false;
    }
    
    if ([responseObject objectForKey:@"card_status"]!= nil) {
      self.card = [[responseObject objectForKey:@"card_status"] boolValue];
    } else {
      self.card = false;
    }
    
    if ([responseObject objectForKey:@"lat"]!= nil) {
      self.latitude = [[responseObject objectForKey:@"lat"] doubleValue];
    } else {
      self.latitude = 0.0;
    }
    
    if ([responseObject objectForKey:@"lng"]!= nil) {
      self.longtitude = [[responseObject objectForKey:@"lng"] doubleValue];
    } else {
      self.longtitude = 0.0;
    }
    
    self.imageUrl = [NSString stringWithFormat:@"http://discountspanel.ru/%@", self.photosString];
//    self.imageUrl = [responseObject objectForKey:@"photourl"];
    
  }
  return self;
}

@end
