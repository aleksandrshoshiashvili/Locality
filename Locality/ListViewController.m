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
#import "ASPlace.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *placesArray;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = appMainColor;
    
    [self getPlaces];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Places

- (void)getPlaces {
    
    NSMutableArray *placesMutableArray = [NSMutableArray array];
    
    for (int i = 1; i <= 30; i++) {
        
        ASPlace *place = [[ASPlace alloc] init];
        place.title = [NSString stringWithFormat:@"Place Name #%d", i];
        place.address = [NSString stringWithFormat:@"Невский проспект, %d", i];
        
        [placesMutableArray addObject:place];
    }
    
    self.placesArray = [NSArray arrayWithArray:placesMutableArray];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *placeCellIdentifier = @"PlaceCell";
    
    PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:placeCellIdentifier];
    
    if (!cell) {
        cell = (PlaceCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:placeCellIdentifier];
    }
    
    ASPlace *place = [self.placesArray objectAtIndex:indexPath.row];
    
    cell.colorDiscount = [UIColor colorWithRed:(CGFloat)(arc4random_uniform(255))/255.0 green:(CGFloat)(arc4random_uniform(255))/255.0 blue:(CGFloat)(arc4random_uniform(255))/255.0 alpha:1.0];
    
    cell.labelDicount.textColor = cell.colorDiscount;
    
    cell.labelPlaceName.text =place.title;
    cell.labelDicount.text = @"Dicount with very large name";
    cell.labelAddress.text = place.address;
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
