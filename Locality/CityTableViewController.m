//
//  CityTableViewController.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

#import "CityTableViewController.h"
#import "Constants.h"

@interface CityTableViewController ()

@property (strong, nonatomic) NSArray *cityArray;

@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityArray = @[@"Москва", @"Санкт-Петербург", @"Сыктывкар", @"Хабаровск", @"Ярославль"];
    
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
    
    cell.textLabel.text = [self.cityArray objectAtIndex:indexPath.row];

    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[self.cityArray objectAtIndex:indexPath.row] forKey:kCityKey];
    [userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityNotification object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
