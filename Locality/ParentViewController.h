//
//  ParentViewController.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 27.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class OneLineFilterView;
@class TwoLineFilterView;

@interface ParentViewController : UIViewController

@property (strong, nonatomic) OneLineFilterView *oneLineFilterView;
@property (strong, nonatomic) TwoLineFilterView *twoLineFilterView;
@property (assign, nonatomic) BOOL isFilterShown;
@property (strong, nonatomic) NSString *subcategoryString;
@property (assign, nonatomic) NSInteger filterTypeId;

- (void)showOneLineFilterView:(BOOL)animated;
- (void)hideOneLineFilterView:(BOOL)animated;

@end
