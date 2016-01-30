//
//  TwoLineFilterView.h
//  Locality
//
//  Created by MacBookPro on 30.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoLineFilterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelDelivery;
@property (weak, nonatomic) IBOutlet UILabel *labelTakeaway;

@property (weak, nonatomic) IBOutlet UIButton *buttonDelivery;
@property (weak, nonatomic) IBOutlet UIButton *buttonTakeaway;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (id)initWithFrame:(CGRect)frame withCount:(NSInteger) count;

@end
