//
//  PlaceCell.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASPlace;

@interface PlaceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageViewPlace;
@property (strong, nonatomic) IBOutlet UILabel *labelPlaceName;
@property (strong, nonatomic) IBOutlet UILabel *labelDicount;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewDiscountDot;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UIView *viewDot;

@property (strong, nonatomic) UIColor *colorDiscount;

- (void)configurateCellWithPlace:(ASPlace *)place;

@end
