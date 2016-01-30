//
//  InfoWindowOfMarkerView.h
//  Locality
//
//  Created by MacBookPro on 30.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoWindowOfMarkerView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelPlaceName;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelDiscountName;
@property (weak, nonatomic) IBOutlet UILabel *labelDiscountsCount;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDiscountDot;

- (id)initWithFrameNew:(CGRect)frame;

@end
