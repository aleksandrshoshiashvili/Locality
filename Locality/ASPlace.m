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
    
    self.address = [responseObject objectForKey:@"address"];
    self.distance = [responseObject objectForKey:@"distance"];
    
    self.disctitle = [responseObject objectForKey:@"disctitle"];
    
    self.category = [responseObject objectForKey:@"category"];
    self.subcategory = [responseObject objectForKey:@"subcategory"];
    
    self.descr = [responseObject objectForKey:@"descr"];
    self.title = [responseObject objectForKey:@"title"];
    self.uid = [responseObject objectForKey:@"placeid"];
    
    if ([responseObject objectForKey:@"working"]!= nil) {
      self.working = [[responseObject objectForKey:@"working"] boolValue];
    } else {
      self.working = false;
    }
    
    self.imageUrl = [responseObject objectForKey:@"photourl"];
    
  }
  return self;
}

@end
