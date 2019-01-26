//
//  XTSettingViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/20.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKSettingViewController.h"
#import "KKSettingCell.h"
#import "KKloginnavController.h"
#import "KKLoginViewController.h"
#import "KKAboutViewController.h"

@interface KKSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *logoutBtn;
@end

static NSString *settingIdentfity = @"settingIdentfity";

@implementation KKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
        _table.frame = [UIScreen mainScreen].bounds;
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _table;
}

-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] init];
        _footView.frame = CGRectMake(0, 0, kScreenWidth, 200);
        [_footView addSubview:self.logoutBtn];
    }
    return _footView;
}

-(UIButton *)logoutBtn
{
    if(!_logoutBtn)
    {
        _logoutBtn = [[UIButton alloc] init];
        _logoutBtn.frame = CGRectMake(21, 80, kScreenWidth-42, 40);
        _logoutBtn.layer.masksToBounds = YES;
        _logoutBtn.layer.cornerRadius = 20;
        _logoutBtn.backgroundColor = MainColor;
        [_logoutBtn setTitle:@"Log Out" forState:normal];
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_logoutBtn addTarget:self action:@selector(logoutbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentfity];
    cell = [[KKSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingIdentfity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.typeImg.image = [UIImage imageNamed:@"evaluation"];
            cell.nameLab.text = @"Rate us";
            break;
        case 1:
            cell.typeImg.image = [UIImage imageNamed:@"share"];
            cell.nameLab.text = @"Share to Friends";
            break;
        case 2:
            cell.typeImg.image = [UIImage imageNamed:@"about"];
            cell.nameLab.text = @"About";
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //type：0/1/2/3: 0：rete 1:share_to_friends 2:about 3:logout
    switch (indexPath.row) {
        case 0:
        {
            [self logManagerwithtype:@{@"type":@"rete"}];
            NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",kAppStoreID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
            break;
        case 1:
        {
            [self logManagerwithtype:@{@"type":@"share_to_friends"}];
            [self shareClick];
        }
            break;
        case 2:
        {
            [self logManagerwithtype:@{@"type":@"about"}];
            KKAboutViewController *VC = [KKAboutViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)shareClick
{
    NSString *textToShare = @"TeddyHookup";
    NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",kAppStoreID];
    UIImage *imageToShare = [UIImage imageNamed:@"LOGO"];
    NSURL *urlToShare = [NSURL URLWithString:url];
    NSArray *activityItems = @[textToShare?:@"",imageToShare?:@"", urlToShare?:@""];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}

#pragma mark - 实现方法

-(void)logoutbtnClick
{
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"Remind" message:@"Do you want to log out" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
        [userdefat setObject:@"type" forKey:@"isLogin"];
        [userdefat removeObjectForKey:@"token"];
        [userdefat removeObjectForKey:@"refreshtoken"];
        [userdefat removeObjectForKey:@"userId"];
        [userdefat removeObjectForKey:@"shakegetNumber"];
        [userdefat removeObjectForKey:@"shakeSetNumber"];
        [self logManagerwithtype:@{@"3":@"logout"}];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        KKLoginViewController *main = [[KKLoginViewController alloc]init];
        KKloginnavController *nav = [[KKloginnavController alloc] initWithRootViewController:main];
        appDelegate.window.rootViewController = nav;
        
    }];
    [control addAction:action0];
    [control addAction:action1];
    [self presentViewController:control animated:YES completion:nil];
}



#pragma mark - 打点上报

-(void)logManagerwithtype:(NSDictionary *)keyDic
{
    [[XYLogManager shareManager] addLogKey1:@"profile" key2:@"set" content:keyDic userInfo:[NSDictionary new] upload:YES];
    
}


@end
