//
//  SettingViewController.m
//  Locality
//
//  Created by MacBookPro on 31.12.15.
//  Copyright © 2015 OneMoreApp. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCityCell.h"
#import "Constants.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *selectedCityString;

@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self notificationCityChanged];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCityChanged) name:kCityNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)notificationCityChanged {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.selectedCityString = [userDefaults stringForKey:kCityKey];
    
    if (!self.selectedCityString) {
        self.selectedCityString = @"Санкт-Петербург";
    }
    
    [userDefaults synchronize];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        static NSString *settingCityCellIdentifier = @"SettingCityCell";
        
        SettingCityCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCityCellIdentifier];
        
        if (!cell) {
            cell = (SettingCityCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingCityCellIdentifier];
        }

        cell.titleTextLabel.text = @"Город";
        cell.cityTextLabel.text = self.selectedCityString;
        
        return cell;
        
    } else {
        
        static NSString *settingCellIdentifier = @"SettingCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCellIdentifier];
        }
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"Политика конфиденциальности";
        } else {
            cell.textLabel.text = @"Сайт разработчика";
        }
        
        return cell;
        
    }
    
    return nil;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
