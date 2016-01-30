//
//  PlaceViewController.m
//  Locality
//
//  Created by MacBookPro on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "PlaceViewController.h"
#import "MEExpandableHeaderView.h"

@interface PlaceViewController ()

@property(nonatomic, strong) MEExpandableHeaderView *headerView;

@end

@implementation PlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupHeaderView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupHeaderView {
    CGSize headerViewSize = CGSizeMake(320, 200);
//    UIImage *backgroundImage = [UIImage imageNamed:@"testImage.jpg"];
    NSArray *images = @[@"http://www.topograph.ru/upload/iblock/46d/1.jpg", @"http://1.bp.blogspot.com/-q1Zuyf37-sc/UH_8Rv7NGOI/AAAAAAAACXI/_SyMJ2Du2Fk/s1600/sixty_resto2.jpg", @"http://family.ru/data/photo/1348127246.jpg", @"http://maybe-you.ru/wp-content/uploads/2013/08/image_3.jpg"];
    NSArray *pages = @[[self createPageViewWithText:@"First page"],
                       [self createPageViewWithText:@"Second page"],
                       [self createPageViewWithText:@"Third page"],
                       [self createPageViewWithText:@"Fourth page"]];
//    MEExpandableHeaderView *headerView = [[MEExpandableHeaderView alloc] initWithSize:headerViewSize
//                                                                      backgroundImage:backgroundImage
//                                                                         contentPages:pages];
    MEExpandableHeaderView *headerView = [[MEExpandableHeaderView alloc] initWithSize:headerViewSize
                                                                               images:images
                                                                         contentPages:pages];
    
    headerView.frame = CGRectMake(0, 0, headerViewSize.width, headerViewSize.height);
    self.headerView = headerView;
    
    [self.view addSubview:self.headerView];
    
}

- (UIView*)createPageViewWithText:(NSString*)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
    
    label.font = [UIFont boldSystemFontOfSize:27.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.text = text;
    
    return label;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        [self.headerView offsetDidUpdate:scrollView.contentOffset];
//    }
}

@end
