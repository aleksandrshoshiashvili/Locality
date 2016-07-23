//
//  TwoLineFilterView.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 30.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwoLineFilterViewDelegate;

@interface TwoLineFilterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelDelivery;
@property (weak, nonatomic) IBOutlet UILabel *labelTakeaway;

@property (weak, nonatomic) IBOutlet UIButton *buttonDelivery;
@property (weak, nonatomic) IBOutlet UIButton *buttonTakeaway;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) id <TwoLineFilterViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withCount:(NSInteger) count;
- (void)selectAllButtons;
- (void)deselectAllButtons;
@end

@protocol TwoLineFilterViewDelegate
@required
- (void)actionFilterButtonPressed:(UIButton *)sender;

@end