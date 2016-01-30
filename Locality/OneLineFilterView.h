//
//  OneLineFilterView.h
//  Locality
//
//  Created by MacBookPro on 26.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OneLineFilterTypeDrinks,
    OneLineFilterTypeLounge
} OneLineFilterType;

@interface OneLineFilterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelFilterName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirstIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSecondIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThirdIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFourthIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelFirstTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSecondTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelThirdTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelFourthTitle;

@property (weak, nonatomic) IBOutlet UIButton *buttonFirstIcon;
@property (weak, nonatomic) IBOutlet UIButton *buttonSecondIcon;
@property (weak, nonatomic) IBOutlet UIButton *buttonThirdIcon;
@property (weak, nonatomic) IBOutlet UIButton *buttonFourthIcon;

- (id)initWithFrame:(CGRect)frame type:(OneLineFilterType)type;
- (id)initDrinksFilterWithFrame:(CGRect)frame;
- (id)initLoungeFilterWithFrame:(CGRect)frame;

- (void)changeFilterType:(OneLineFilterType)type;

@end
