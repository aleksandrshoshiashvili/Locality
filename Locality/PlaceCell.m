//
//  PlaceCell.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "PlaceCell.h"
#import "ASPlace.h"
#import "Dot.h"
#import "Constants.h"

@implementation PlaceCell

//- (void)setFrame:(CGRect)frame {
//    frame.origin.y += 2;
//    frame.size.height -= 2 * 2;
//    [super setFrame:frame];
//}

//@property (strong, nonatomic) IBOutlet UIImageView *imageViewPlace;
//@property (strong, nonatomic) IBOutlet UILabel *labelPlaceName;
//@property (strong, nonatomic) IBOutlet UILabel *labelDicount;
//@property (strong, nonatomic) IBOutlet UIImageView *imageViewDiscountDot;
//@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
//@property (strong, nonatomic) IBOutlet UILabel *labelDistance;
//
//@property (strong, nonatomic) UIColor *colorDiscount;

- (void)configurateCellWithPlace:(ASPlace *)place {
  
  self.colorDiscount = [UIColor colorWithRed:(CGFloat)(arc4random_uniform(255))/255.0 green:(CGFloat)(arc4random_uniform(255))/255.0 blue:(CGFloat)(arc4random_uniform(255))/255.0 alpha:1.0];
  
  self.labelDicount.textColor = [UIColor whiteColor];
  
  self.labelPlaceName.text = place.title;
  self.labelDicount.text = place.descr;
  self.labelAddress.text = place.address;
  self.labelDistance.text = place.distance;
//  self.imageViewDiscountDot.image = [UIImage ];
//  self.imageViewDiscountDot = (UIImageView *)[[[Dot alloc] initWithFrame:self.imageViewDiscountDot.frame] redDot];
  [self whiteDot:self.viewDot];
//  self.imageViewDiscountDot.image = [UIImage imageNamed:@"cocktail_filled512.png"];
  [self.imageViewPlace sd_setImageWithURL:[NSURL URLWithString:place.imageUrl] placeholderImage:[UIImage imageNamed:@"testImage.jpg"]];
  
  
}

- (void)whiteDot:(UIView *)sender {
  sender.backgroundColor = [UIColor whiteColor];
  sender.layer.cornerRadius = sender.frame.size.height / 2.0;
  sender.clipsToBounds = YES;
}

- (void)redDot:(UIView *)sender {
  sender.backgroundColor = redDotColor;
  sender.layer.cornerRadius = sender.frame.size.height / 2.0;
  sender.clipsToBounds = YES;
}

- (void)greenDot:(UIView *)sender {
  sender.backgroundColor = greenDotColor;
  sender.layer.cornerRadius = sender.frame.size.height / 2.0;
  sender.clipsToBounds = YES;
}

- (void)blueDot:(UIView *)sender {
  sender.backgroundColor = blueDotColor;
  sender.layer.cornerRadius = sender.frame.size.height / 2.0;
  sender.clipsToBounds = YES;
}

@end
