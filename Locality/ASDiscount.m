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
    
    self.accountId = [responseObject objectForKey:@"account_id"];
    self.name = [responseObject objectForKey:@"name"];
    self.descr = [responseObject objectForKey:@"description"];
    self.companyId = [responseObject objectForKey:@"company_id"];
    self.categoryId = [responseObject objectForKey:@"category_id"];
    self.specialStatus = [responseObject objectForKey:@"special_status"];
//    
//    self.category = [responseObject objectForKey:@"category"];
//    self.descr = [responseObject objectForKey:@"descr"];
//    self.featured = [[responseObject objectForKey:@"featured"] boolValue];
//    self.subcategory = [responseObject objectForKey:@"subcategory"];
//    self.title = [responseObject objectForKey:@"title"];
    
    self.uid = [responseObject objectForKey:@"id"];
    
  }
  return self;
}

@end
