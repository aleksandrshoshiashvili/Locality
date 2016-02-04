//
//  ASDiscount.h
//  Locality
//
//  Created by MacBookPro on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ASServerManager.h"

typedef enum {
    ASDiscountDrinks,
    ASDiscountLounge,
    ASDiscountFood
} ASDiscountType;

@interface ASDiscount : ASServerManager

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descr;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *subcategory;
@property (assign, nonatomic) BOOL featured;

@end
