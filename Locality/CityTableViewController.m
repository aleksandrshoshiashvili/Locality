//
//  CityTableViewController.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

#import "CityTableViewController.h"
#import "Constants.h"
#import "ASServerManager.h"
#import "ASCity.h"
#import "PQFCustomLoaders.h"

@interface CityTableViewController ()

@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) PQFCirclesInTriangle *loader;

@end

@implementation CityTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self startLoader];
  [[ASServerManager sharedManager] getCitiesOnSuccess:^(NSArray *array) {
    self.cityArray = [NSArray arrayWithArray:array];
    [self.tableView reloadData];
    [self stopLoader];
  } onFailure:^(NSError *error, NSInteger statusCode) {
    [self stopLoader];
    NSLog(@"getCitiesOnSuccess fail");
  }];
  
//  self.cityArray = @[@"Москва", @"Санкт-Петербург", @"Сыктывкар", @"Хабаровск", @"Ярославль"];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.cityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *settingCityCellIdentifier = @"CityCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCityCellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingCityCellIdentifier];
  }
  
  ASCity *city = [self.cityArray objectAtIndex:indexPath.row];
  
  cell.textLabel.text = city.name;
  
  return cell;
  
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:[[self.cityArray objectAtIndex:indexPath.row] name] forKey:kCityKey];
  [userDefaults synchronize];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kCityNotification object:nil];
  
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - LoaderView Func

- (void)createAndConfigurateLoader {
  self.loader = [PQFCirclesInTriangle createModalLoader];
  self.loader.loaderColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
  self.loader.maxDiam = 100;
}

- (void)startLoader {
  [self createAndConfigurateLoader];
  [self.loader showLoader];
}

- (void)stopLoader {
  [self.loader removeLoader];
}

@end
