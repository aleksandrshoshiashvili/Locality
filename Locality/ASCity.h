//
//  ASCity.h
//  Locality
//
//  Created by Alex Shoshiashvili on 14.07.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASServerObject.h"

@interface ASCity : ASServerObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *descr;

- (id) initWithServerResponse:(NSDictionary *) responseObject;

@end