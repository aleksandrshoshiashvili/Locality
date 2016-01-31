//
//  PlaceViewController.m
//  Locality
//
//  Created by MacBookPro on 28.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "PlaceViewController.h"
#import "MEExpandableHeaderView.h"

#import "BLKFlexibleHeightBar.h"
#import "BLKDelegateSplitter.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "SquareCashStyleBar.h"

#import "Constants.h"

typedef enum {
    PlaceCellTypeAddress,
    PlaceCellTypeDiscount
} PlaceCellType;


@interface PlaceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) SquareCashStyleBar *myCustomBar;
@property (nonatomic) BLKDelegateSplitter *delegateSplitter;
@property(nonatomic, strong) MEExpandableHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlaceViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self setupHeaderView];
    
    // Ломает навигейш у родителя
    self.navigationController.navigationBar.hidden = YES;
    
    // Setup the bar
    self.myCustomBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];
    
    SquareCashStyleBehaviorDefiner *behaviorDefiner = [[SquareCashStyleBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elasticMaximumHeightAtTop = NO; // Когда тянешь вниз
    self.myCustomBar.behaviorDefiner = behaviorDefiner;
    
    // Configure a separate UITableViewDelegate and UIScrollViewDelegate (optional)
    self.delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:behaviorDefiner secondDelegate:self];
    self.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.myCustomBar];
    
    // Setup the table view
    self.tableView.contentInset = UIEdgeInsetsMake(self.myCustomBar.maximumBarHeight - 15.0, 0.0, 0.0, 0.0);
    
    
    // Add close button - it's pinned to the top right corner, so it doesn't need to respond to bar height changes
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0.0 + 10.0, 25.0, 30.0, 30.0);
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"back512.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCustomBar addSubview:closeButton];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)closeViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *placeInfoCellIdentifier = @"PlaceInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:placeInfoCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:placeInfoCellIdentifier];
    }
    
    
    switch (indexPath.row) {
        case PlaceCellTypeAddress: {
            cell.textLabel.text = @"Страстной б-р, 4, стр. 3";
            cell.detailTextLabel.text = @"1.5 км";
            cell.backgroundColor = [UIColor grayColor];
            break;
        }
            
        default: {
            cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row + 1];
            cell.backgroundColor = [UIColor whiteColor];
            break;
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
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

#pragma mark - System

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
