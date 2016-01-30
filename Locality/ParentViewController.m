//
//  ParentViewController.m
//  Locality
//
//  Created by MacBookPro on 27.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ParentViewController.h"
#import "OneLineFilterView.h"
#import "TwoLineFilterView.h"
#import "Constants.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurateNavigationController];
    [self configurateOneLineFilterView];
    [self configurateTwoLineFilterView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.isFilterShown) {
        [self hideOneLineFilterView:NO];
        [self hideTwoLineFilterView:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configurate

- (void)configurateNavigationController {
    
    UIButton *coctailBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *foodBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 30, 30)];
    [coctailBtn setImage:[UIImage imageNamed:@"cocktail_filled512.png"] forState:UIControlStateNormal];
    [foodBtn setImage:[UIImage imageNamed:@"food_filled512.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *coctailBarBtn = [[UIBarButtonItem alloc] initWithCustomView:coctailBtn];
    UIBarButtonItem *foodBarBtn = [[UIBarButtonItem alloc] initWithCustomView:foodBtn];
    
    [coctailBtn addTarget:self action:@selector(actionOpenCoctail:) forControlEvents:UIControlEventTouchUpInside];
    [foodBtn addTarget:self action:@selector(actionOpenFood:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItems = @[coctailBarBtn, foodBarBtn];
    
    UIButton *coffeeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 30, 30)];
    [coffeeBtn setImage:[UIImage imageNamed:@"drinks512.png"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"delete512.png"] forState:UIControlStateNormal];
    
    [coffeeBtn addTarget:self action:@selector(actionOpenCoffee:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *coffeeBarBtn = [[UIBarButtonItem alloc] initWithCustomView:coffeeBtn];
    UIBarButtonItem *closeBarBtn = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    
    self.navigationItem.rightBarButtonItems = @[closeBarBtn, coffeeBarBtn];
    
    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:68.0/255.0 green:61.0/255.0 blue:68.0/255.0 alpha:1.0];
    
}

- (void)configurateOneLineFilterView {
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 154.0);
    self.oneLineFilterView = [[OneLineFilterView alloc] initWithFrame:frame type:OneLineFilterTypeLounge];
    self.oneLineFilterView.center = CGPointMake(self.view.center.x, -self.oneLineFilterView.frame.size.height / 2.0 - 20);
    [self.view addSubview:self.oneLineFilterView];
    self.oneLineFilterView.alpha = 0.0;
    
}

- (void)configurateTwoLineFilterView {
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 242.0);
    self.twoLineFilterView = [[TwoLineFilterView alloc] initWithFrame:frame withCount:12];
    self.twoLineFilterView.center = CGPointMake(self.view.center.x, -self.twoLineFilterView.frame.size.height / 2.0 - 20);
    [self.view addSubview:self.twoLineFilterView];
    self.twoLineFilterView.alpha = 0.0;
    
}

#pragma mark - Actions

- (void)showOneLineFilterView:(BOOL)animated {
    
    CGFloat animateDuration = 0.0;
    
    if (animated) {
        animateDuration = 0.5;
    }
    
    [UIView animateWithDuration:animateDuration animations:^{
        self.navigationController.navigationBar.alpha = 0.0;
        self.oneLineFilterView.alpha = 1.0;
        self.oneLineFilterView.center = CGPointMake(self.view.center.x, self.oneLineFilterView.frame.size.height / 2.0 + 20);
    } completion:^(BOOL finished) {
        self.isFilterShown = YES;
    }];
}

- (void)hideOneLineFilterView:(BOOL)animated {
    
    CGFloat animateDuration = 0.0;
    
    if (animated) {
        animateDuration = 0.5;
    }
    
    [UIView animateWithDuration:animateDuration animations:^{
        self.navigationController.navigationBar.alpha = 1.0;
        self.oneLineFilterView.alpha = 0.0;
        self.oneLineFilterView.center = CGPointMake(self.view.center.x, -self.oneLineFilterView.frame.size.height / 2.0 - 20 - 44);
    } completion:^(BOOL finished) {
        self.isFilterShown = NO;
    }];
}

- (void)showTwoLineFilterView:(BOOL)animated {
    
    CGFloat animateDuration = 0.0;
    
    if (animated) {
        animateDuration = 0.5;
    }
    
    [UIView animateWithDuration:animateDuration animations:^{
        self.navigationController.navigationBar.alpha = 0.0;
        self.twoLineFilterView.alpha = 1.0;
        self.twoLineFilterView.center = CGPointMake(self.view.center.x, self.twoLineFilterView.frame.size.height / 2.0 + 20);
    } completion:^(BOOL finished) {
        self.isFilterShown = YES;
    }];
}

- (void)hideTwoLineFilterView:(BOOL)animated {
    
    CGFloat animateDuration = 0.0;
    
    if (animated) {
        animateDuration = 0.5;
    }
    
    [UIView animateWithDuration:animateDuration animations:^{
        self.navigationController.navigationBar.alpha = 1.0;
        self.twoLineFilterView.alpha = 0.0;
        self.twoLineFilterView.center = CGPointMake(self.view.center.x, -self.oneLineFilterView.frame.size.height / 2.0 - 20 - 44);
    } completion:^(BOOL finished) {
        self.isFilterShown = NO;
    }];
}

- (void)actionOpenCoctail:(id)sender {
    
    [self.oneLineFilterView changeFilterType:OneLineFilterTypeLounge];
    
    [self showOneLineFilterView:YES];
}

- (void)actionOpenCoffee:(id)sender {
    
    [self.oneLineFilterView changeFilterType:OneLineFilterTypeDrinks];
    
    [self showOneLineFilterView:YES];
    
}

- (void)actionOpenFood:(id)sender {
    
    [self showTwoLineFilterView:YES];
    
}

#pragma mark - Filter Actions

- (IBAction)actionChooseAll:(id)sender {
    NSLog(@"actionChooseAll");
}

- (IBAction)actionCancel:(id)sender {
    NSLog(@"actionCancel");
    
    [self hideOneLineFilterView:YES];
    [self hideTwoLineFilterView:YES];
}

- (IBAction)actionChooseFilterInOneLineView:(id)sender {
    NSLog(@"actionChooseFilterInOneLineView");
    
    switch ([sender tag]) {
        case 1: {
            NSLog(@"1");
            break;
        }
        case 2: {
            NSLog(@"2");
            break;
        }
        case 3: {
            NSLog(@"3");
            break;
        }
        case 4: {
            NSLog(@"4");
            break;
        }
            
        default:
            break;
    }
    
}

@end
