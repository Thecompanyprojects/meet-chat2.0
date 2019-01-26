//
//  XTPaymentViewController.m
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//
#import <SafariServices/SafariServices.h>
#import "KKPaymentViewController.h"
#import "KKStatisticalManager.h"

#import "KKPaymentHeaderView.h"
#import "KKPaymentPriceModel.h"

#import "KKPaymentCardCell.h"
#import "KKPaymentNormalCell.h"
#import "KKPaymentinfoCell.h"

@interface KKPaymentViewController () <UITableViewDelegate, UITableViewDataSource, TTPaymentManageDelegate>
@property (nonatomic, strong) UIBarButtonItem *closeBtnItem;
@property (nonatomic, strong) UIBarButtonItem *restoreBtnItem;
@property (nonatomic, strong) KKPaymentHeaderView *tableHeaderView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <KKPaymentPriceModel *>*vipPriceArray;
@end

@implementation KKPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - 关闭
- (void)closeButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    NSNotification *notification = [NSNotification notificationWithName:AlertShakenoc object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}



#pragma mark - 恢复
- (void)restorenButtonAction:(UIBarButtonItem *)sender {
    [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"restore" content:nil userInfo:nil upload:YES];
    [TTPaymentManager shareInstance].delegate = self;
    [SVProgressHUD show];
    [[TTPaymentManager shareInstance] refreshReceipt];
}

#pragma mark - 订阅
- (void)payWithPaymentId:(NSString *)paymentId {
    
    [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"button" content:nil userInfo:nil upload:YES];
    
    [TTPaymentManager shareInstance].delegate = self;
    [SVProgressHUD show];
    [[TTPaymentManager shareInstance] paymentWithProductID:paymentId];
}

#pragma mark - XYPaymentManageDelegate
- (void)tt_paymentTransactionSucceedType:(TTPaymentStatus)SucceedType {
    [self showWithState:SucceedType isSuccess:YES];
}

- (void)tt_paymentTransactionFailureType:(TTPaymentStatus)failtype {
    [self showWithState:failtype isSuccess:NO];
}

- (void)showWithState:(TTPaymentStatus)state isSuccess:(BOOL)success {
    NSString *logString = @"";
    switch (state) {
        case pay_success:{
            logString = NSLocalizedString(@"Payment success",nil);
        } break;
        case verify_timeout:{
            logString = NSLocalizedString(@"Verification timeout",nil);
        } break;
        case verify_fail:{
            logString = NSLocalizedString(@"Verification failed",nil);
        } break;
        case payment_fail:{
            logString = NSLocalizedString(@"Payment timeout",nil);
        } break;
        case no_product:{
            logString = NSLocalizedString(@"Unavailable",nil);
        } break;
        case bought_status:{
            logString = NSLocalizedString(@"Purchased",nil);
        } break;
        case pay_fail:{
            logString = NSLocalizedString(@"Payment failed",nil);
        } break;
        case expires:{
            logString = NSLocalizedString(@"Subscription has expired",nil);
        } break;
        case app_store_connect_fail:{
            logString = NSLocalizedString(@"iTunes Store connect failed",nil);
        } break;
        case not_allowed:{
            logString = NSLocalizedString(@"No purchase allowed",nil);
        } break;
        case user_cancel:{
            logString = NSLocalizedString(@"Purchase cancelled",nil);
        } break;
        default:
            break;
    }
    
    
    if (success) {
        [TTPaymentManager shareInstance].isVip = YES;
        [[TTPaymentManager shareInstance] checkSubscriptionStatusComplete:nil];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        @weakify(self);
        [UIAlertController showAlertTitle:@"Successful Verification" message:@"congratulations on your successful subscription, now you can enjoy it!" cancelTitle:@"Sure" otherTitle:nil cancleBlock:^{
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
        } otherBlock:nil];
        
        [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"success" content:@{@"state":logString} userInfo:nil upload:YES];
    } else {
        [SVProgressHUD showErrorWithStatus:logString];
        [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"failed" content:@{@"state":logString} userInfo:nil upload:YES];
    }
    
}



#pragma mark - 设置UI
- (void)setupView {
    [[TTPaymentManager shareInstance] addPayTransactionObserver];
    
    self.title = NSLocalizedString(@"Premium", nil);
    
    [self addCloseButton];

    if ([TTPaymentManager shareInstance].isVip) {
        [UIAlertController showAlertTitle:@"Tips" message:@"You are already a subscriber" cancelTitle:@"Sure" otherTitle:nil cancleBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } otherBlock:nil];
        return;
    }
    
    [self addRestoreButtonItem];
    
    if ([self getConfigInfo]) {
        self.vipPriceArray = [NSArray yy_modelArrayWithClass:[KKPaymentPriceModel class] json:[self getConfigInfo][@"subscribe_ids"]];
        if (!self.vipPriceArray) {
            [self loadConfig];
        } else {
            [self addMainView];
        }
        
    } else {
        [self loadConfig];
    }
}

#pragma mark - 添加主视图
- (void)addMainView {
    [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"show" content:nil userInfo:nil upload:YES];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - loadData
- (void)loadConfig {
    @weakify(self);
    [SVProgressHUD show];
    [[KKStatisticalManager shareTools] loadDataWithComplete:^(NSDictionary *dict) {
        @strongify(self);
        self.vipPriceArray = [NSArray yy_modelArrayWithClass:[KKPaymentPriceModel class] json:dict[@"data"][@"cloud"][@"subscribe"][@"subscribe_ids"]];
        if (!self.vipPriceArray) {
            [SVProgressHUD showErrorWithStatus:@"data error"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            return;
        }
        [self addMainView];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } error:^(NSError *error) {
        @strongify(self);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)dealloc {
    [[TTPaymentManager shareInstance] removePayTransactionObserver];
    [SVProgressHUD dismiss];
}

#pragma mark - 获取配置信息
- (NSDictionary *)getConfigInfo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName][@"data"][@"cloud"][@"subscribe"];
}



- (void)addCloseButton {
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"payment_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonAction:)];
    self.navigationItem.leftBarButtonItem = closeBtn;
}

- (void)addRestoreButtonItem {
    UIBarButtonItem *restoreBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Restore", nil) style:UIBarButtonItemStylePlain target:self action:@selector(restorenButtonAction:)];
    self.navigationItem.rightBarButtonItem = restoreBtn;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.vipPriceArray) {
            return self.vipPriceArray.count;
        }
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    if (indexPath.section == 0) {
        if ([self shouldShowSubcribeList]) {
            
            KKPaymentNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KKPaymentNormalCell class]) forIndexPath:indexPath];
            KKPaymentPriceModel *model = self.vipPriceArray[indexPath.row];
            model.index = indexPath.row + 1;
            cell.model = model;
            cell.payButtonAction = ^(KKPaymentPriceModel *model) {
                @strongify(self);
                [self payWithPaymentId:model.payment_id];
            };
            return cell;
        }
        
        KKPaymentCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KKPaymentCardCell class]) forIndexPath:indexPath];
        [cell refreshUI];
        cell.payButtonAction = ^(NSString *payment_id) {
            @strongify(self);
            [self payWithPaymentId:payment_id];
        };
        
        return cell;
        
    } else {
        KKPaymentinfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KKPaymentinfoCell class]) forIndexPath:indexPath];
        cell.textTapAction = ^(NSString *url) {
            @strongify(self);
            SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
            [self presentViewController:controller animated:YES completion:nil];
        };
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = ({
            KKPaymentHeaderView *headerView = [KKPaymentHeaderView yg_loadViewFromNib];
            self.tableHeaderView = headerView;
            headerView.autoresizingMask = UIViewAutoresizingNone;
            headerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * (210.0 / 375.0));
            headerView;
        });
        
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKPaymentNormalCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([KKPaymentNormalCell class])];
        [_tableView registerClass:[KKPaymentCardCell class] forCellReuseIdentifier:NSStringFromClass([KKPaymentCardCell class])];
        [_tableView registerClass:[KKPaymentinfoCell class] forCellReuseIdentifier:NSStringFromClass([KKPaymentinfoCell class])];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}


#pragma mark - 判断是否展示列表
- (BOOL)shouldShowSubcribeList {
    /*
     条件:
     1.配置接口返回参数标识是否在黑名单内,如果在黑名单内展示列表,返回错误或者不在黑名单按照下面逻辑展示:1.命中;0.未命中;-1.错误(按照未命中计算)
     2.配置接口subscribe_list_show字段标识是否展示列表:1.展示列表;0.不展示列表
     */
    
    BOOL showListView = NO;
    
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName];
    NSNumber *blackip = config[@"data"][@"blackip"];
    if (blackip && blackip.integerValue == 1) {
        showListView = YES;
    } else {
        NSNumber *show_list_config = config[@"data"][@"cloud"][@"subscribe"][@"subscribe_list_show"];
        if (show_list_config && show_list_config.integerValue == 1) {
            showListView = YES;
        } else {
            showListView = NO;
        }
    }
    
    return showListView;
}


@end
