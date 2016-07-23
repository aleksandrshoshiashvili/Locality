//
//  OneLineFilterView.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 26.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "OneLineFilterView.h"

@interface OneLineFilterView ()
@property (weak, nonatomic) IBOutlet UIButton *buttonChooseAll;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@end

@implementation OneLineFilterView

- (id)initWithFrame:(CGRect)frame type:(OneLineFilterType)type {
  
  self = [super initWithFrame:frame];
  if (self) {
    NSString *className = NSStringFromClass([self class]);
    OneLineFilterView *xibView = (OneLineFilterView *)[[[NSBundle mainBundle] loadNibNamed:className
                                                                                     owner:self
                                                                                   options:nil] objectAtIndex:0];
    
    xibView.frame = frame;
    
    [self changeFilterType:type];
    
    [self addSubview:xibView];
    
  }
  return self;
  
}

- (id)initDrinksFilterWithFrame:(CGRect)frame {
  
  self = [super initWithFrame:frame];
  if (self) {
    NSString *className = NSStringFromClass([self class]);
    OneLineFilterView *xibView = (OneLineFilterView *)[[[NSBundle mainBundle] loadNibNamed:className
                                                                                     owner:self
                                                                                   options:nil] objectAtIndex:0];
    
    xibView.frame = frame;
    
    self.labelFilterName.text = @"Напитки";
    
    self.labelFirstTitle.text = @"кофе";
    self.labelSecondTitle.text = @"горячие напитки";
    self.labelThirdTitle.text = @"холодные напитки";
    self.labelFourthTitle.text = @"кофе на вынос";
    
    self.imageViewFirstIcon.image = [UIImage imageNamed:@"coffee512.png"];
    self.imageViewSecondIcon.image = [UIImage imageNamed:@"hot512.png"];
    self.imageViewThirdIcon.image = [UIImage imageNamed:@"cold_drinks512.png"];
    self.imageViewFourthIcon.image = [UIImage imageNamed:@"coffeetogo512.png"];
    
    [self.buttonFirstIcon setImage:[UIImage imageNamed:@"coffee512.png"] forState:UIControlStateNormal];
    [self.buttonSecondIcon setImage:[UIImage imageNamed:@"hot512.png"] forState:UIControlStateNormal];
    [self.buttonThirdIcon setImage:[UIImage imageNamed:@"cold_drinks512.png"] forState:UIControlStateNormal];
    [self.buttonFourthIcon setImage:[UIImage imageNamed:@"coffeetogo512.png"] forState:UIControlStateNormal];
    
    [self.buttonFirstIcon setTintColor:[UIColor whiteColor]];
    [self.buttonSecondIcon setTintColor:[UIColor whiteColor]];
    [self.buttonThirdIcon setTintColor:[UIColor whiteColor]];
    [self.buttonFourthIcon setTintColor:[UIColor whiteColor]];
    
    [self addSubview:xibView];
  }
  return self;
  
}

- (id)initLoungeFilterWithFrame:(CGRect)frame {
  
  self = [super init];
  if (self) {
    NSString *className = NSStringFromClass([self class]);
    OneLineFilterView *xibView = (OneLineFilterView *)[[[NSBundle mainBundle] loadNibNamed:className
                                                                                     owner:self
                                                                                   options:nil] objectAtIndex:0];
    xibView.frame = frame;
    
    self.labelFilterName.text = @"Lounge";
    
    self.labelFirstTitle.text = @"пиво";
    self.labelSecondTitle.text = @"вино";
    self.labelThirdTitle.text = @"крепкий алкоголь";
    self.labelFourthTitle.text = @"кальян";
    
    self.imageViewFirstIcon.image = [UIImage imageNamed:@"beer512.png"];
    self.imageViewSecondIcon.image = [UIImage imageNamed:@"vino512.png"];
    self.imageViewThirdIcon.image = [UIImage imageNamed:@"krepkii512.png"];
    self.imageViewFourthIcon.image = [UIImage imageNamed:@"hookah512.png"];
    
    [self.buttonFirstIcon setImage:[UIImage imageNamed:@"beer512.png"] forState:UIControlStateNormal];
    [self.buttonSecondIcon setImage:[UIImage imageNamed:@"vino512.png"] forState:UIControlStateNormal];
    [self.buttonThirdIcon setImage:[UIImage imageNamed:@"krepkii512.png"] forState:UIControlStateNormal];
    [self.buttonFourthIcon setImage:[UIImage imageNamed:@"hookah512.png"] forState:UIControlStateNormal];
    
    [self.buttonFirstIcon setTintColor:[UIColor whiteColor]];
    [self.buttonSecondIcon setTintColor:[UIColor whiteColor]];
    [self.buttonThirdIcon setTintColor:[UIColor whiteColor]];
    [self.buttonFourthIcon setTintColor:[UIColor whiteColor]];
    
    [self addSubview:xibView];
  }
  return self;
  
}

- (void)changeFilterType:(OneLineFilterType)type {
  if (type == OneLineFilterTypeDrinks) {
    self.labelFilterName.text = @"Напитки";
    
    self.labelFirstTitle.text = @"кофе";
    self.labelSecondTitle.text = @"горячие напитки";
    self.labelThirdTitle.text = @"холодные напитки";
    self.labelFourthTitle.text = @"кофе на вынос";
    
    //        self.imageViewFirstIcon.image = [UIImage imageNamed:@"coffee512.png"];
    //        self.imageViewSecondIcon.image = [UIImage imageNamed:@"hot512.png"];
    //        self.imageViewThirdIcon.image = [UIImage imageNamed:@"cold_drinks512.png"];
    //        self.imageViewFourthIcon.image = [UIImage imageNamed:@"coffeetogo512.png"];
    
    [self.buttonFirstIcon setImage:[UIImage imageNamed:@"coffee512.png"] forState:UIControlStateNormal];
    [self.buttonSecondIcon setImage:[UIImage imageNamed:@"hot512.png"] forState:UIControlStateNormal];
    [self.buttonThirdIcon setImage:[UIImage imageNamed:@"cold_drinks512.png"] forState:UIControlStateNormal];
    [self.buttonFourthIcon setImage:[UIImage imageNamed:@"coffeetogo512.png"] forState:UIControlStateNormal];
    
  } else {
    self.labelFilterName.text = @"Lounge";
    
    self.labelFirstTitle.text = @"пиво";
    self.labelSecondTitle.text = @"вино";
    self.labelThirdTitle.text = @"крепкий алкоголь";
    self.labelFourthTitle.text = @"кальян";
    
    //        self.imageViewFirstIcon.image = [UIImage imageNamed:@"beer512.png"];
    //        self.imageViewSecondIcon.image = [UIImage imageNamed:@"vino512.png"];
    //        self.imageViewThirdIcon.image = [UIImage imageNamed:@"krepkii512.png"];
    //        self.imageViewFourthIcon.image = [UIImage imageNamed:@"hookah512.png"];
    
    [self.buttonFirstIcon setImage:[UIImage imageNamed:@"beer512.png"] forState:UIControlStateNormal];
    [self.buttonSecondIcon setImage:[UIImage imageNamed:@"vino512.png"] forState:UIControlStateNormal];
    [self.buttonThirdIcon setImage:[UIImage imageNamed:@"krepkii512.png"] forState:UIControlStateNormal];
    [self.buttonFourthIcon setImage:[UIImage imageNamed:@"hookah512.png"] forState:UIControlStateNormal];
    
    [self.buttonFirstIcon setTintColor:[UIColor whiteColor]];
    [self.buttonSecondIcon setTintColor:[UIColor whiteColor]];
    [self.buttonThirdIcon setTintColor:[UIColor whiteColor]];
    [self.buttonFourthIcon setTintColor:[UIColor whiteColor]];
    
  }
}

@end
