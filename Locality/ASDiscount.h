//
//  ASDiscount.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASServerObject.h"

typedef enum {
    ASDiscountDrinks,
    ASDiscountLounge,
    ASDiscountFood
} ASDiscountType;

@interface ASDiscount : ASServerObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descr;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *subcategory;
@property (assign, nonatomic) BOOL featured;

@end
