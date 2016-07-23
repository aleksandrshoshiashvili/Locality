//
//  PlaceMainDiscountCell.m
//  Locality
//
//  Created by MacBookPro on 22.04.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "PlaceMainDiscountCell.h"

@implementation PlaceMainDiscountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForRowWithShareDescr:(NSString *)shareDescr {
  return 10;
}

@end
