//
//  ASDiscount.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASDiscount.h"

@implementation ASDiscount

- (id) initWithServerResponse:(NSDictionary *) responseObject {
  self = [super initWithServerResponse:responseObject];
  if (self) {
    
    self.category = [responseObject objectForKey:@"category"];
    self.descr = [responseObject objectForKey:@"descr"];
    self.featured = [[responseObject objectForKey:@"featured"] boolValue];
    self.subcategory = [responseObject objectForKey:@"subcategory"];
    self.title = [responseObject objectForKey:@"title"];
    
    self.uid = [responseObject objectForKey:@"placeid"];
    
  }
  return self;
}

@end
