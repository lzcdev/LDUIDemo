//
//  LDRootViewController.m
//  LDUIDemo
//
//  Created by lzcdev on 2018/8/31.
//  Copyright © 2018年 lzcdev. All rights reserved.
//


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "LDRootViewController.h"

@interface LDRootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *classNamesArray;
@property (nonatomic, strong) UITableView *tableView;
@end

static NSString *iden = @"cell";

@implementation LDRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titlesArray = [NSMutableArray new];
    _classNamesArray = [NSMutableArray new];
    [self addTableView];
    
    [self addCell:@"跑马灯" class:@"MarqueeViewController"];

}

- (void)addTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:iden];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [_titlesArray addObject:title];
    [_classNamesArray addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden forIndexPath:indexPath];
    cell.textLabel.text = _titlesArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = _classNamesArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = [class new];
        ctrl.title = _titlesArray[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end






