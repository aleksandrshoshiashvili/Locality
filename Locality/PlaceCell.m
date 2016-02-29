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
  
  self.labelDicount.textColor = self.colorDiscount;
  
  self.labelPlaceName.text =place.title;
  self.labelDicount.text = place.disctitle;
  self.labelAddress.text = place.address;
  self.labelDistance.text = place.distance;
  self.imageViewDiscountDot.image = [UIImage imageNamed:@"cocktail_filled512.png"];
  [self.imageViewPlace sd_setImageWithURL:[NSURL URLWithString:place.imageUrl] placeholderImage:[UIImage imageNamed:@"testImage.jpg"]];
  
  
}

@end
