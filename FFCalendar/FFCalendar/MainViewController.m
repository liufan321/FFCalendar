//
//  MainViewController.m
//  FFCalendar
//
//  Created by 刘凡 on 2016/7/25.
//  Copyright © 2016年 joyios. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray <NSDictionary *> *dataList;
@end

@implementation MainViewController

- (NSArray<NSDictionary *> *)dataList {
    if (_dataList == nil) {
        _dataList = @[
                      @{@"name": @"简单日历选择", @"clsName": @"SimpleCalendarSelectViewController"}
                      ];
    }
    return _dataList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataList[indexPath.row][@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *clsName = self.dataList[indexPath.row][@"clsName"];
    Class cls = NSClassFromString(clsName);
    
    UIViewController *vc = [cls new];
    
    if (![vc isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
