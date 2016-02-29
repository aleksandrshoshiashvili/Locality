//
//  TwoLineFilterView.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 30.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "TwoLineFilterView.h"
#import "FilterCollectionViewCell.h"
#import "Constants.h"

@interface TwoLineFilterView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (assign, nonatomic) NSInteger countOfCells;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation TwoLineFilterView

- (id)initWithFrame:(CGRect)frame withCount:(NSInteger) count {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        TwoLineFilterView *xibView = (TwoLineFilterView *)[[[NSBundle mainBundle] loadNibNamed:className
                                                                                         owner:self
                                                                                       options:nil] objectAtIndex:0];
        
        xibView.frame = frame;
        
        self.countOfCells = count;
        
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FilterCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"FilterCell"];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        [self addSubview:xibView];
        
        if (count <= 6) {
            [self setupPageControl:1];
        } else {
            [self setupPageControl:2];
        }
        
    }
    return self;
    
}

- (void)setupPageControl:(NSUInteger) pagesCount {
    
    if (pagesCount > 1) {
        static CGFloat const kPageControlPadding = 5.0;
        static CGRect const kPageControlDefaultFrame = {0, 0, 10, 10};
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:kPageControlDefaultFrame];
        
        [pageControl setNumberOfPages:pagesCount];
        [pageControl setCurrentPage:0];
        
//        UIColor *backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
//        [pageControl setBackgroundColor:backgroundColor];
        
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:pagesCount];
        
        pageControl.frame = CGRectMake((self.collectionView.frame.size.width-pageControlSize.width)/2.0,
                                       self.frame.size.height-(pageControl.frame.size.height+kPageControlPadding),
                                       pageControlSize.width+kPageControlPadding*2,
                                       pageControl.frame.size.height);
        
        //        pageControl.layer.cornerRadius = pageControl.frame.size.height/2.0;
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
}

- (void)actionTapOnFilterButton:(UIButton *)sender {
    [self.delegate actionFilterButtonPressed:sender];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.countOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"FilterCell";
    
    FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[FilterCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.buttonFilter.tag = indexPath.row + 1;
    cell.buttonFilter.userInteractionEnabled = YES;
    [cell.buttonFilter addTarget:self action:@selector(actionTapOnFilterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pageControl.currentPage = (NSInteger)(self.collectionView.contentOffset.x / self.collectionView.frame.size.width + 0.5);
    
    switch (indexPath.row) {
        case 0: {
            cell.labelFilterName.text = @"роллы";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
        }
        case 1: {
            cell.labelFilterName.text = @"пицца";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"pizza512.png"] forState:UIControlStateNormal];
            break;
        }
        case 2: {
            cell.labelFilterName.text = @"fast food";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"f-food512.png"] forState:UIControlStateNormal];
            break;
        }
        case 3: {
            cell.labelFilterName.text = @"вторые блюда";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"hot512.png"] forState:UIControlStateNormal];
            break;
        }
        case 4: {
            cell.labelFilterName.text = @"супы";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"soups512.png"] forState:UIControlStateNormal];
            break;
        }
        case 5: {
            cell.labelFilterName.text = @"завтрак";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"breakfast512.png"] forState:UIControlStateNormal];
            break;
        }
        case 6: {
            cell.labelFilterName.text = @"вегетарианство";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
        }
        case 7: {
            cell.labelFilterName.text = @"экзотика";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
        }
        case 8: {
            cell.labelFilterName.text = @"десерты";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
        }
        case 9: {
            cell.labelFilterName.text = @"выпечка";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
        }
        case 10: {
            cell.labelFilterName.text = @"???";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
        }
        case 11: {
            cell.labelFilterName.text = @"???";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
        }
            
        default:
            cell.labelFilterName.text = @"???";
            [cell.buttonFilter setImage:[UIImage imageNamed:@"rolls512.png"] forState:UIControlStateNormal];
            break;
    }
    
    return (UICollectionViewCell *)cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(70, 70);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
