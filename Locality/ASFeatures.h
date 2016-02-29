//
//  ASFeatures.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASServerObject.h"

@interface ASFeatures : ASServerObject

@property (assign, nonatomic) BOOL wifi;
@property (assign, nonatomic) BOOL chargers;
@property (assign, nonatomic) BOOL cards;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSNumber *featuresid;

@end
