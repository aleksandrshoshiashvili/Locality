//
//  ParentViewController.h
//  Locality
//
//  Created by MacBookPro on 27.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneLineFilterView;

@interface ParentViewController : UIViewController

@property (strong, nonatomic) OneLineFilterView *oneLineFilterView;
@property (assign, nonatomic) BOOL isFilterShown;

- (void)showOneLineFilterView:(BOOL)animated;
- (void)hideOneLineFilterView:(BOOL)animated;

@end