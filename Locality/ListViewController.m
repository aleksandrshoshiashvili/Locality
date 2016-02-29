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

#import "ASServerManager.h"

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
  
//  [self getPlacesByLatitude:55.751244 andLongtitude:37.618423];
  [self getPlacesById:@(1)];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Get Places

- (void)getPlacesByLatitude:(double)lat andLongtitude:(double)lon {
  
  [[ASServerManager sharedManager] getlistByLatitude:lat longtitude:lon onSuccess:^(NSArray *array) {
    
    self.placesArray = [NSArray arrayWithArray:array];
    [self.tableView reloadData];
    
  } onFailure:^(NSError *error, NSInteger statusCode) {
    NSLog(@"getlistByLatitude error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
}

- (void)getPlacesById:(NSNumber *)placeId {
  
  [[ASServerManager sharedManager] getlistByPlaceId:[placeId stringValue] onSuccess:^(ASPlace *place) {
    
    self.placesArray = @[place];
    [self.tableView reloadData];
  
  } onFailure:^(NSError *error, NSInteger statusCode) {
    NSLog(@"getlistByPlaceId error = %@, statsuCode = %ld", error.localizedDescription, (long)statusCode);
  }];
  
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.placesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *placeCellIdentifier = @"PlaceCell";
  
  PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:placeCellIdentifier];
  
  if (!cell) {
    cell = (PlaceCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:placeCellIdentifier];
  }
  
  ASPlace *place = [self.placesArray objectAtIndex:indexPath.row];
  [cell configurateCellWithPlace:place];
  
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
