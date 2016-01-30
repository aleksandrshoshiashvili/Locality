//
//  ViewController.m
//  Locality
//
//  Created by NikoGenn on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

#import "ListViewController.h"
#import "PlaceViewController.h"
#import "PlaceCell.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//AIzaSyA_brn-WOjxx5j0oAToHeyf3y9kYnn2B_Q
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *settingCityCellIdentifier = @"PlaceCell";
    
    PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCityCellIdentifier];
    
    if (!cell) {
        cell = (PlaceCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingCityCellIdentifier];
    }
    
    cell.colorDiscount = [UIColor colorWithRed:(CGFloat)(arc4random_uniform(255))/255.0 green:(CGFloat)(arc4random_uniform(255))/255.0 blue:(CGFloat)(arc4random_uniform(255))/255.0 alpha:1.0];
    
    cell.labelDicount.textColor = cell.colorDiscount;
    
    cell.labelPlaceName.text = @"Place Name";
    cell.labelDicount.text = @"Dicount with very large name";
    cell.labelAddress.text = @"Невский проспект, 43 к.1";
    cell.labelDistance.text = @"1.12 км";
    cell.imageViewDiscountDot.image = [UIImage imageNamed:@"cocktail_filled512.png"];
    cell.imageViewPlace.image = [UIImage imageNamed:@"testImage.jpg"];

    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    PlaceViewController *vc = [[PlaceViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
