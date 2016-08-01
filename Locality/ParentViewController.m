//
//  ParentViewController.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 27.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "ParentViewController.h"
#import "OneLineFilterView.h"
#import "TwoLineFilterView.h"
#import "Dot.h"
#import "FilterCollectionViewCell.h"

@interface ParentViewController () <TwoLineFilterViewDelegate>

@property (strong, nonatomic) UIView *fakeView;

@end

@implementation ParentViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configurateNavigationController];
  [self configurateOneLineFilterView];
  [self configurateTwoLineFilterView];
  
  UIView *bottomStatusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, statusBarHeight)];
  bottomStatusBarView.backgroundColor = appMainColor;
  [self.view bringSubviewToFront:bottomStatusBarView];
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  self.navigationItem.backBarButtonItem = item;
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if (![self.view.subviews containsObject:self.fakeView]) {
    self.fakeView = [[UIView alloc] initWithFrame:self.view.frame];
    self.fakeView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fakeViewTapped)];
    [self.fakeView addGestureRecognizer:tap];
    [self.view addSubview:self.fakeView];
    self.fakeView.hidden = YES;
  }
  
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  if (self.isFilterShown) {
    [self hideOneLineFilterView:NO];
    [self hideTwoLineFilterView:NO];
  }
  
  self.fakeView.hidden = YES;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Configurate

- (void)configurateNavigationController {
  
  UIButton *coctailBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  UIButton *foodBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 30, 30)];
  [coctailBtn setImage:[UIImage imageNamed:@"cocktail_filled512.png"] forState:UIControlStateNormal];
  [foodBtn setImage:[UIImage imageNamed:@"food_new"] forState:UIControlStateNormal];
  
  UIBarButtonItem *coctailBarBtn = [[UIBarButtonItem alloc] initWithCustomView:coctailBtn];
  UIBarButtonItem *foodBarBtn = [[UIBarButtonItem alloc] initWithCustomView:foodBtn];
  
  [coctailBtn addTarget:self action:@selector(actionOpenCoctail:) forControlEvents:UIControlEventTouchUpInside];
  [foodBtn addTarget:self action:@selector(actionOpenFood:) forControlEvents:UIControlEventTouchUpInside];
  
  self.navigationItem.leftBarButtonItems = @[coctailBarBtn, foodBarBtn];
  
  UIButton *coffeeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 30, 30)];
  [coffeeBtn setImage:[UIImage imageNamed:@"coffee_new"] forState:UIControlStateNormal];
  [closeBtn setImage:[UIImage imageNamed:@"delete512.png"] forState:UIControlStateNormal];
  
  [coffeeBtn addTarget:self action:@selector(actionOpenCoffee:) forControlEvents:UIControlEventTouchUpInside];
  [closeBtn addTarget:self action:@selector(actionResetFilters) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *coffeeBarBtn = [[UIBarButtonItem alloc] initWithCustomView:coffeeBtn];
  UIBarButtonItem *closeBarBtn = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
  
  
  self.navigationItem.rightBarButtonItems = @[closeBarBtn, coffeeBarBtn];
  
  self.navigationController.navigationBar.translucent = YES;
  //    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:68.0/255.0 green:61.0/255.0 blue:68.0/255.0 alpha:1.0];
  
}

- (void)configurateOneLineFilterView {
  
  CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 154.0);
  self.oneLineFilterView = [[OneLineFilterView alloc] initWithFrame:frame type:OneLineFilterTypeLounge];
  self.oneLineFilterView.center = CGPointMake(self.view.center.x, -CGRectGetHeight(self.oneLineFilterView.frame) / 2.0 - 20);
  [self.view addSubview:self.oneLineFilterView];
  self.oneLineFilterView.alpha = 0.0;
  
}

- (void)configurateTwoLineFilterView {
  
  CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 242.0);
  self.twoLineFilterView = [[TwoLineFilterView alloc] initWithFrame:frame withCount:10];
  self.twoLineFilterView.center = CGPointMake(self.view.center.x, -CGRectGetHeight(self.twoLineFilterView.frame) / 2.0 - 20);
  [self.view addSubview:self.twoLineFilterView];
  self.twoLineFilterView.alpha = 0.0;
  
  self.twoLineFilterView.delegate = self;
  
}

#pragma mark - Actions

- (void)showOneLineFilterView:(BOOL)animated {
  
  CGFloat animateDuration = 0.0;
  
  if (animated) {
    animateDuration = 0.5;
  }
  
//  [self.view addSubview:self.fakeView];
  [self.view insertSubview:self.fakeView belowSubview:self.oneLineFilterView];
  
  self.fakeView.hidden = NO;
  
  [self configurateButtonsWithSubcategoryIds];
  
  [UIView animateWithDuration:animateDuration animations:^{
    self.navigationController.navigationBar.alpha = 0.0;
    self.oneLineFilterView.alpha = 1.0;
    self.oneLineFilterView.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.oneLineFilterView.frame) / 2.0 + 20);
  } completion:^(BOOL finished) {
    self.isFilterShown = YES;
  }];
}

- (void)hideOneLineFilterView:(BOOL)animated {
  
  CGFloat animateDuration = 0.0;
  
  if (animated) {
    animateDuration = 0.5;
  }
  
  self.fakeView.hidden = YES;
  
  [UIView animateWithDuration:animateDuration animations:^{
    self.navigationController.navigationBar.alpha = 1.0;
    self.oneLineFilterView.alpha = 0.0;
    self.oneLineFilterView.center = CGPointMake(self.view.center.x, -CGRectGetHeight(self.oneLineFilterView.frame) / 2.0 - 20 - 44);
  } completion:^(BOOL finished) {
    self.isFilterShown = NO;
  }];
}

- (void)showTwoLineFilterView:(BOOL)animated {
  
  CGFloat animateDuration = 0.0;
  
  if (animated) {
    animateDuration = 0.5;
  }
  
//  [self.view addSubview:self.fakeView];
  [self.view insertSubview:self.fakeView belowSubview:self.twoLineFilterView];
  
  self.fakeView.hidden = NO;
  
  [self configurateButtonsWithSubcategoryIds];
  
  [UIView animateWithDuration:animateDuration animations:^{
    self.navigationController.navigationBar.alpha = 0.0;
    self.twoLineFilterView.alpha = 1.0;
    self.twoLineFilterView.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.twoLineFilterView.frame) / 2.0 + 20);
  } completion:^(BOOL finished) {
    self.isFilterShown = YES;
  }];
}

- (void)hideTwoLineFilterView:(BOOL)animated {
  
  CGFloat animateDuration = 0.0;
  
  if (animated) {
    animateDuration = 0.5;
  }
  
  self.fakeView.hidden = YES;
  
  [UIView animateWithDuration:animateDuration animations:^{
    self.navigationController.navigationBar.alpha = 1.0;
    self.twoLineFilterView.alpha = 0.0;
    // было oneLineView
    self.twoLineFilterView.center = CGPointMake(self.view.center.x, -CGRectGetHeight(self.twoLineFilterView.frame) / 2.0 - 20 - 44);
  } completion:^(BOOL finished) {
    self.isFilterShown = NO;
  }];
}

- (void)actionOpenCoctail:(id)sender {
  
  [self.oneLineFilterView changeFilterType:OneLineFilterTypeLounge];
  self.filterTypeId = 2;
  [self showOneLineFilterView:YES];
  
}

- (void)actionOpenCoffee:(id)sender {
  
  [self.oneLineFilterView changeFilterType:OneLineFilterTypeDrinks];
  self.filterTypeId = 1;
  [self showOneLineFilterView:YES];
  
  
}

- (void)actionOpenFood:(id)sender {
  self.filterTypeId = 3;
  [self showTwoLineFilterView:YES];
}

- (void)actionResetFilters {
  self.subcategoryString = @"";
  [self configurateButtonsWithSubcategoryIds];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"actionResetFiltersNotification" object:nil];
  
//  if (self.filterTypeId == 3) {
//    [self.twoLineFilterView.buttonDelivery setTintColor:[UIColor whiteColor]];
//    [self.twoLineFilterView.buttonTakeaway setTintColor:[UIColor whiteColor]];
//    [self.twoLineFilterView deselectAllButtons];
//  } else {
//    [self.oneLineFilterView.buttonFirstIcon setTintColor:[UIColor whiteColor]];
//    [self.oneLineFilterView.buttonSecondIcon setTintColor:[UIColor whiteColor]];
//    [self.oneLineFilterView.buttonThirdIcon setTintColor:[UIColor whiteColor]];
//    [self.oneLineFilterView.buttonFourthIcon setTintColor:[UIColor whiteColor]];
//  }
}

#pragma mark - Filter Actions

- (IBAction)actionChooseAll:(id)sender {
//  NSLog(@"actionChooseAll");
  if (self.filterTypeId == 1) {
    self.subcategoryString = @"1,2,3,4";
  } else if (self.filterTypeId == 2) {
    self.subcategoryString = @"5,6,7,8";
  } else if (self.filterTypeId == 3) {
    self.subcategoryString = @"9,10,11,12,13,14,15,16,17,18,19,20";
  }
  [self configurateButtonsWithSubcategoryIds];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"actionChooseAllNotification" object:nil];
  
//  if (self.filterTypeId == 3) {
//    [self.twoLineFilterView.buttonDelivery setTintColor:selectFilterColor];
//    [self.twoLineFilterView.buttonTakeaway setTintColor:selectFilterColor];
//    [self.twoLineFilterView selectAllButtons];
//  } else {
//    [self.oneLineFilterView.buttonFirstIcon setTintColor:selectFilterColor];
//    [self.oneLineFilterView.buttonSecondIcon setTintColor:selectFilterColor];
//    [self.oneLineFilterView.buttonThirdIcon setTintColor:selectFilterColor];
//    [self.oneLineFilterView.buttonFourthIcon setTintColor:selectFilterColor];
//  }
  
}

- (IBAction)actionCancel:(id)sender {
//  NSLog(@"actionCancel");
  self.subcategoryString = @"";
  [self configurateButtonsWithSubcategoryIds];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"actionCancelNotification" object:nil];
  [self hideOneLineFilterView:YES];
  [self hideTwoLineFilterView:YES];
  
//  
//  if (self.filterTypeId == 3) {
//    [self.twoLineFilterView.buttonDelivery setTintColor:[UIColor whiteColor]];
//    [self.twoLineFilterView.buttonTakeaway setTintColor:[UIColor whiteColor]];
//    [self.twoLineFilterView deselectAllButtons];
//  } else {
//    [self.oneLineFilterView.buttonFirstIcon setTintColor:[UIColor whiteColor]];
//    [self.oneLineFilterView.buttonSecondIcon setTintColor:[UIColor whiteColor]];
//    [self.oneLineFilterView.buttonThirdIcon setTintColor:[UIColor whiteColor]];
//    [self.oneLineFilterView.buttonFourthIcon setTintColor:[UIColor whiteColor]];
//  }
}

- (IBAction)actionChooseFilterInOneLineView:(id)sender {
//  NSLog(@"actionChooseFilterInOneLineView: %ld", (long)[sender tag]);
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"actionChooseFilterInOneLineViewNotification" object:sender];
  
  switch ([sender tag]) {
    case 1: {
      break;
    }
    case 2: {
      break;
    }
    case 3: {
      break;
    }
    case 4: {
      break;
    }
      
    default:
      break;
  }
  
}

#pragma mark - TwoLineFilterViewDelegate

- (void)collectionViewDidScroll {
  [self configurateButtonsWithSubcategoryIds];
}

- (IBAction)actionDeliverButtonPressed:(UIButton *)sender {
  [self createSubcategroryStringWithSubcategory:19];
  [self configurateButtonsWithSubcategoryIds];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"actionDeliverButtonPressedNotification" object:sender];
}

- (IBAction)actionTakeawayButtonPressed:(UIButton *)sender {
  [self createSubcategroryStringWithSubcategory:20];
  [self configurateButtonsWithSubcategoryIds];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"actionTakeawayButtonPressedNotification" object:sender];
}

- (void)actionFilterButtonPressed:(UIButton *)sender {
//  NSLog(@"actionFilterButtonPressed: %ld", (long)sender.tag);
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"actionFilterButtonPressedNotification" object:sender];
  
  switch ([sender tag]) {
    case 1: {
      break;
    }
    case 2: {
      break;
    }
    case 3: {
      break;
    }
    case 4: {
      break;
    }
    case 5: {
      break;
    }
    case 6: {
      break;
    }
    case 7: {
      break;
    }
    case 8: {
      break;
    }
    case 9: {
      break;
    }
    case 10: {
      break;
    }
    case 11: {
      break;
    }
    case 12: {
      break;
    }
    case 19: {
    }
    case 20: {
    }
      
    default:
      break;
  }
  
}

- (void)fakeViewTapped {
  if (self.isFilterShown) {
    if (self.filterTypeId == 3) {
      [self hideTwoLineFilterView:YES];
    } else {
      [self hideOneLineFilterView:YES];
    }
  } else {
    self.fakeView.hidden = YES;
  }
}

- (void)createSubcategroryStringWithSubcategory:(NSInteger) subcategoryId {
  
  NSMutableArray *subcatArray = [NSMutableArray arrayWithArray:[self.subcategoryString componentsSeparatedByString:@","]];
  NSString *subcatString = [NSString stringWithFormat:@"%ld", (long)subcategoryId];
  
  if (subcatArray.count == 1) {
    if ([subcatArray.firstObject isEqual: @""]) {
      [subcatArray removeObjectAtIndex:0];
    }
  }
  
  if ([subcatArray containsObject: subcatString]) {
    [subcatArray removeObject:subcatString];
  } else {
    [subcatArray addObject:subcatString];
  }
  
  subcatArray = (NSMutableArray *)[subcatArray sortedArrayUsingDescriptors:
                                   @[[NSSortDescriptor sortDescriptorWithKey:@"intValue"
                                                                   ascending:YES]]];
  
  NSString *resultString = @"";
  
  for (NSString *s in subcatArray) {
    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@,", s]];
  }
  
  if (resultString.length > 1) {
    resultString = [resultString stringByReplacingCharactersInRange:NSMakeRange(resultString.length - 1, 1) withString:@""];
  } else {
    resultString = nil;
  }
  
  self.subcategoryString = resultString;
  
  NSLog(@"subcategoryString = %@", self.subcategoryString);
  
}

- (void)configurateButtonsWithSubcategoryIds {
  NSMutableArray *subcatArray = [NSMutableArray arrayWithArray:[self.subcategoryString componentsSeparatedByString:@","]];
  
  if (subcatArray.count == 1) {
    if ([subcatArray.firstObject isEqual: @""]) {
      [subcatArray removeObjectAtIndex:0];
    }
  }
  
  /*
   //Cat = 1 Drinks
   case Coffee = 1
   case Hot = 2
   case Ice = 3
   case Carry = 4
   //Cat = 2 Lounge
   case Beer = 5
   case Vine = 6
   case Strong = 7
   case Hookah = 8
   //Cat = 3 Food
   case Pizza = 9
   case Rolls = 10
   case Fastfood = 11
   case Breakfast = 12
   case Soup = 13
   case HotFood = 14
   case Vegan = 15
   case Exotic = 16
   case Dessert = 17
   case Bakery = 18
   case Delivery = 19
   case CarryFood = 20
   }
   */
  
  if (self.filterTypeId == 1) {
    if ([subcatArray containsObject:@"1"]) {
      self.oneLineFilterView.buttonFirstIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonFirstIcon.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"2"]) {
      self.oneLineFilterView.buttonSecondIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonSecondIcon.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"3"]) {
      self.oneLineFilterView.buttonThirdIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonThirdIcon.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"4"]) {
      self.oneLineFilterView.buttonFourthIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonFourthIcon.tintColor = [UIColor whiteColor];
    }
  } else if (self.filterTypeId == 2) {
    if ([subcatArray containsObject:@"5"]) {
      self.oneLineFilterView.buttonFirstIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonFirstIcon.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"6"]) {
      self.oneLineFilterView.buttonSecondIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonSecondIcon.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"7"]) {
      self.oneLineFilterView.buttonThirdIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonThirdIcon.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"8"]) {
      self.oneLineFilterView.buttonFourthIcon.tintColor = selectFilterColor;
    } else {
      self.oneLineFilterView.buttonFourthIcon.tintColor = [UIColor whiteColor];
    }
  } else if (self.filterTypeId == 3) {
    if ([subcatArray containsObject:@"10"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"9"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"11"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"14"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"13"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"12"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:5 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:5 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"15"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:6 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:6 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"16"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:7 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:7 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"17"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:8 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:8 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"18"]) {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:9 inSection:0]];
      cell.buttonFilter.tintColor = selectFilterColor;
    } else {
      FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[self.twoLineFilterView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:9 inSection:0]];
      cell.buttonFilter.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"19"]) {
      self.twoLineFilterView.buttonDelivery.tintColor = selectFilterColor;
    } else {
      self.twoLineFilterView.buttonDelivery.tintColor = [UIColor whiteColor];
    }
    if ([subcatArray containsObject:@"20"]) {
      self.twoLineFilterView.buttonTakeaway.tintColor = selectFilterColor;
    } else {
      self.twoLineFilterView.buttonTakeaway.tintColor = [UIColor whiteColor];
    }
  }
  
}

#pragma mark - LoaderView Func

- (void)createAndConfigurateLoader {
  self.loader = [PQFCirclesInTriangle createModalLoader];
  self.loader.loaderColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
  self.loader.maxDiam = 100;
}

- (void)startLoader {
  [self createAndConfigurateLoader];
  [self.loader showLoader];
  [self.view setUserInteractionEnabled:NO];
}

- (void)stopLoader {
  [self.loader removeLoader];
  [self.view setUserInteractionEnabled:YES];
}

@end
