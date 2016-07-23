//
//  FilterCollectionViewCell.h
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 30.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCollectionViewCell : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *buttonFilter;
@property (weak, nonatomic) IBOutlet UILabel *labelFilterName;
@property (assign, nonatomic) BOOL isSelectedCell;

@end
