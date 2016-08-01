//
//  SquareCashStyleBar.h
//  BLKFlexibleHeightBar Demo
//
//  Created by Bryan Keller on 2/19/15.
//  Copyright (c) 2015 Bryan Keller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLKFlexibleHeightBar.h"

@interface SquareCashStyleBar : BLKFlexibleHeightBar

@property (strong, nonatomic) UIImageView *placeImageView;

- (id)initWithFrame:(CGRect)frame
          placeName:(NSString *)placeName
           features:(NSArray *)featuresImagesArray
           workhour:(NSString *)workhourText
           imageUrl:(NSString *) imageUrl;

@end
