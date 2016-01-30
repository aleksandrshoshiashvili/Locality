//
//  PlaceCell.h
//  Locality
//
//  Created by MacBookPro on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageViewPlace;
@property (strong, nonatomic) IBOutlet UILabel *labelPlaceName;
@property (strong, nonatomic) IBOutlet UILabel *labelDicount;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewDiscountDot;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelDistance;

@property (strong, nonatomic) UIColor *colorDiscount;

@end
