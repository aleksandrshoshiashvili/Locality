//
//  ASCity.m
//  Locality
//
//  Created by Alex Shoshiashvili on 14.07.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASCity.h"

@implementation ASCity

- (id) initWithServerResponse:(NSDictionary *) responseObject {
  self = [super initWithServerResponse:responseObject];
  if (self) {
    
    self.name = [responseObject objectForKey:@"name"];
    self.descr = [responseObject objectForKey:@"description"];
    self.uid = [responseObject objectForKey:@"id"];
    
  }
  return self;
}

@end
