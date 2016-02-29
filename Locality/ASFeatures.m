//
//  ASFeatures.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASFeatures.h"

@implementation ASFeatures

- (id) initWithServerResponse:(NSDictionary *) responseObject {
  self = [super initWithServerResponse:responseObject];
  if (self) {
    
    self.cards = [[responseObject objectForKey:@"cards"] boolValue];
    self.email = [responseObject objectForKey:@"email"];
    self.featuresid = [responseObject objectForKey:@"feauteresid"];
    self.phone = [responseObject objectForKey:@"phone"];
    self.wifi = [[responseObject objectForKey:@"wi-fi"] boolValue];
    
    self.uid = [responseObject objectForKey:@"placeid"];
    
  }
  return self;
}


@end
