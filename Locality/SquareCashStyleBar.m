//
//  SquareCashStyleBar.m
//  BLKFlexibleHeightBar Demo
//
//  Created by Bryan Keller on 2/19/15.
//  Copyright (c) 2015 Bryan Keller. All rights reserved.
//

#import "SquareCashStyleBar.h"

@interface SquareCashStyleBar ()

@end

@implementation SquareCashStyleBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self configureBar];
    }
    
    return self;
}

- (void)configureBar
{
    // Configure bar appearence
    self.maximumBarHeight = 200.0;
    self.minimumBarHeight = 65.0;
    self.backgroundColor = [UIColor colorWithRed:0.17 green:0.63 blue:0.11 alpha:1];
    
    
     // Add and configure name label
     UILabel *nameLabel = [[UILabel alloc] init];
     nameLabel.font = [UIFont systemFontOfSize:34.0];
     nameLabel.textColor = [UIColor whiteColor];
     nameLabel.text = @"Dobro Bar";
    
     BLKFlexibleHeightBarSubviewLayoutAttributes *initialNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialNameLabelLayoutAttributes.size = [nameLabel sizeThatFits:CGSizeZero];
    initialNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.maximumBarHeight * 0.5);
    [nameLabel addLayoutAttributes:initialNameLabelLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialNameLabelLayoutAttributes];
    midwayNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, (self.maximumBarHeight-self.minimumBarHeight) * 0.4 + self.minimumBarHeight - 50.0);
    [nameLabel addLayoutAttributes:midwayNameLabelLayoutAttributes forProgress:0.6];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayNameLabelLayoutAttributes];
    finalNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.minimumBarHeight - 25.0);
    [nameLabel addLayoutAttributes:finalNameLabelLayoutAttributes forProgress:1.0];
    
    [self addSubview:nameLabel];
    
    
    // Add and configure profile image
    UIImageView *profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testImage.jpg"]];
    profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialProfileImageViewLayoutAttributes.size = CGSizeMake(self.frame.size.width, self.maximumBarHeight);
    initialProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.maximumBarHeight * 0.5);
    [profileImageView addLayoutAttributes:initialProfileImageViewLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialProfileImageViewLayoutAttributes];
    finalProfileImageViewLayoutAttributes.size = CGSizeMake(self.frame.size.width, self.maximumBarHeight - self.minimumBarHeight - 25);
    finalProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.minimumBarHeight * 0.5);
    finalProfileImageViewLayoutAttributes.transform = CGAffineTransformMakeScale(1.0, 0.4);
//    finalProfileImageViewLayoutAttributes.alpha = 0.9;
    [profileImageView addLayoutAttributes:finalProfileImageViewLayoutAttributes forProgress:1.0];
    
    [self addSubview:profileImageView];
    
    [self insertSubview:profileImageView belowSubview:nameLabel];
    
    UILabel *workHourLabel = [[UILabel alloc] init];
    workHourLabel.font = [UIFont systemFontOfSize:16.0];
    workHourLabel.textColor = [UIColor whiteColor];
    workHourLabel.text = @"Работает до 23:00";
    
    CGSize workHourLabelSize = [workHourLabel sizeThatFits:CGSizeZero];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialWorkHourLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialWorkHourLabelLayoutAttributes.size = workHourLabelSize;
    initialWorkHourLabelLayoutAttributes.center = CGPointMake(0.0 + workHourLabelSize.width / 2 + 10, self.maximumBarHeight - 15.0);
    [workHourLabel addLayoutAttributes:initialWorkHourLabelLayoutAttributes forProgress:0.0];
    
//    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayWorkHourLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialWorkHourLabelLayoutAttributes];
//    midwayWorkHourLabelLayoutAttributes.center = CGPointMake(0.0 + workHourLabel.frame.size.width * 0.5 + 10.0, self.maximumBarHeight - workHourLabel.frame.size.height - 10.0);
//    midwayWorkHourLabelLayoutAttributes.transform = CGAffineTransformMakeScale(1.0, 0.8);
//    midwayWorkHourLabelLayoutAttributes.alpha = 0.8;
//    [workHourLabel addLayoutAttributes:midwayWorkHourLabelLayoutAttributes forProgress:0.6];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalWorkHourLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialWorkHourLabelLayoutAttributes];
    finalWorkHourLabelLayoutAttributes.center = CGPointMake(0.0 + workHourLabelSize.width / 2 + 10, self.minimumBarHeight - 25.0);
    finalWorkHourLabelLayoutAttributes.transform = CGAffineTransformMakeScale(1.0, 0.4);
    finalWorkHourLabelLayoutAttributes.alpha = 0.0;
    [workHourLabel addLayoutAttributes:finalWorkHourLabelLayoutAttributes forProgress:1.0];
    
    [self addSubview:workHourLabel];

    
    CGSize featureSize = CGSizeMake(20, 20);
    
    NSArray *imagesArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"wifi512.png"], [UIImage imageNamed:@"debit512.png"], nil];
    
    for (int i = 0; i < [imagesArray count]; i++) {
        
        UIImage *featureImage = [imagesArray objectAtIndex:i];
        UIImageView *featureImageView = [[UIImageView alloc] initWithImage:featureImage];
        featureImageView.tintColor = [UIColor whiteColor];
        
        BLKFlexibleHeightBarSubviewLayoutAttributes *initialFeatureImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
        initialFeatureImageViewLayoutAttributes.size = featureSize;
        initialFeatureImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width - featureSize.width * i - 5 * i - 20, self.maximumBarHeight - 15.0);
        [featureImageView addLayoutAttributes:initialFeatureImageViewLayoutAttributes forProgress:0.0];
        
        BLKFlexibleHeightBarSubviewLayoutAttributes *finalFeatureImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialFeatureImageViewLayoutAttributes];
        finalFeatureImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width - featureSize.width * i - 5 * i - 20, self.minimumBarHeight - 22.0);
        [featureImageView addLayoutAttributes:finalFeatureImageViewLayoutAttributes forProgress:1.0];
        
        [self addSubview:featureImageView];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
//    CGRect f = self.frame;
//    f.size.width = _tableView.frame.size.width;
//    self.frame = f;
    
//    if (scrollView.contentOffset.y < 0) {
//        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
////        initialFrame.origin.y = offsetY * -1;
////        initialFrame.size.height = defaultViewHeight + offsetY;
////        self.frame = initialFrame;
////        self.imageViewProfile.frame = initialFrame;
//        
//        CGRect frame = self.frame;
//        frame.origin.y = offsetY * 0.01 * -1;
//        self.frame = frame;
//        self.transform = CGAffineTransformMakeScale(1.0, 1.0 + offsetY * 0.01);
//        
//    }
}

@end