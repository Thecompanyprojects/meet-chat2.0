//
//  XTDrawerViewController.m
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKDramerViewController.h"

@interface KKDramerViewController () <UITableViewDelegate, UITableViewDataSource>

/* 功能列表 */
@property (nonatomic, strong) UITableView *tableView;

/* 订阅视图 */
@property (nonatomic, strong) UIView *subscribeView;

/* 资源 */
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation KKDramerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.dataSource.count * 50.0);
        make.centerY.mas_equalTo(0);
    }];

}

#pragma mark - Button Actions
- (void)logoutButtonAction:(UIButton *)sender {
    if (self.xt_drawerViewActionBlock) {
        self.xt_drawerViewActionBlock(XTDrawerViewAction_Logout);
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = NSLocalizedString(self.dataSource[indexPath.row], nil);
    cell.imageView.image = [UIImage imageWithColor:[UIColor orangeColor] size:CGSizeMake(32, 32)].roundImage;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.xt_drawerViewActionBlock) {
        self.xt_drawerViewActionBlock(indexPath.row);
    }
}


#pragma mark - Lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"Rate Us", @"Share to Friends", @"About", @"Logout"];
    }
    return _dataSource;
}

@end
