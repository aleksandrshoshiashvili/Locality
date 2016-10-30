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

- (NSInteger)sharesCount {
  NSArray *sharesArray = [_sharesString componentsSeparatedByString:@";"];
  if (sharesArray) {
    return [sharesArray count];
  } else {
    return 0;
  }
}

- (NSString *)sharesCountString {
  
  NSArray *sharesArray = [_sharesString componentsSeparatedByString:@";"];
  NSInteger sharesCount = 0;
  if (sharesArray) {
    sharesCount = [sharesArray count];
  }
  
  if (sharesCount > 0) {
    switch (sharesCount) {
      case 1:
        return @"всего 1 акция";
      case 2:
        return @"и ещё 1 акция";
      case 3:
        return @"и ещё 2 акции";
      case 4:
        return @"и ещё 3 акции";
      case 5:
        return @"и ещё 4 акции";
      case 6:
        return @"и ещё 5 акций";
      case 7:
        return @"и ещё 6 акций";
      case 8:
        return @"и ещё 7 акций";
      default:
        return [NSString stringWithFormat:@"и ещё %ld акций", (long)sharesCount - 1];
    }
  } else {
    return @"Нет действующийх акций";
  }
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
  //Encode the properties of the object
  [encoder encodeObject:self.name forKey:@"name"];
  [encoder encodeObject:self.uid forKey:@"id"];
  [encoder encodeObject:self.accountId forKey:@"account_id"];
  [encoder encodeObject:self.descr forKey:@"description"];
  [encoder encodeObject:self.cityId forKey:@"city_id"];
  [encoder encodeObject:self.address forKey:@"address"];
  [encoder encodeObject:self.photosString forKey:@"photos"];
  [encoder encodeObject:self.sharesString forKey:@"shares"];
  [encoder encodeObject:self.distance forKey:@"distance"];
  
}

-(id)initWithCoder:(NSCoder *)decoder
{
  self = [super init];
  if ( self != nil )
  {
    //decode the properties
    self.name = [decoder decodeObjectForKey:@"name"];
    self.uid = [decoder decodeObjectForKey:@"id"];
    self.accountId = [decoder decodeObjectForKey:@"account_id"];
    self.descr = [decoder decodeObjectForKey:@"description"];
    self.cityId = [decoder decodeObjectForKey:@"city_id"];
    self.address = [decoder decodeObjectForKey:@"address"];
    self.photosString = [decoder decodeObjectForKey:@"photos"];
    self.sharesString = [decoder decodeObjectForKey:@"shares"];
    self.distance = [decoder decodeObjectForKey:@"distance"];
    
  }
  return self;
}


@end
