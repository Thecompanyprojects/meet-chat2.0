//
//  XTPersonalViewController.m
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/10/15.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "KKPersonalViewController.h"
#import "SDCycleScrollView.h"
#import "KKPersonalCell0.h"
#import "KKPersonalCell1.h"
#import "KKPersonalCell2.h"
#import "KKPersonalCell3.h"
#import "KKEditorViewController.h"
#import "KKSettingViewController.h"
#import "APIResult.h"
#import "KKPersonModel.h"
#import "KKLikedViewController.h"
#import "KKLikedmedbManager.h"

@interface KKPersonalViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) KKPersonModel *personModel;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,assign) BOOL isPush;
@end

static NSString *personalidentfity0 = @"personalidentfity0";
static NSString *personalidentfity1 = @"personalidentfity1";
static NSString *personalidentfity2 = @"personalidentfity2";
static NSString *personalidentfity3 = @"personalidentfity3";
static NSString *personalidentfity4 = @"personalidentfity4";

@implementation KKPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Mine";

    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
    self.table.tableHeaderView = self.cycleScrollView;
    [self getUserInfo];
    [self notifity];
    [self logManager];
}

-(void)notifity
{
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:kPaymentSuccessNotificationName object:nil];
}

-(void)notice:(id)sender{
    NSLog(@"%@",sender);
    [self addSubscribeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addSubscribeButton{
    if (![KKUserModel sharedUserModel].isVip) {
        UIBarButtonItem *subscribeBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"dingyue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(subscribeButtonAction:)];
        self.navigationItem.leftBarButtonItem = subscribeBtn;
    }
    else
    {
        UIBarButtonItem *subscribeBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(subscribeButtonAction:)];
        self.navigationItem.leftBarButtonItem = subscribeBtn;
    }
    UIBarButtonItem *editorBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Editor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(editorClick:)];
    
    self.navigationItem.rightBarButtonItem = editorBtn;
}

- (void)subscribeButtonAction:(UIBarButtonItem *)sender {
    [self showPaymentViewController];
}

-(void)editorClick:(UIBarButtonItem *)sender
{
    if (self.isPush) {
        KKEditorViewController *vc = [KKEditorViewController new];
        vc.personModel = self.personModel;
        [vc returnText:^(NSString *showText) {
            [self getUserInfo];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self getUserInfo];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addSubscribeButton];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

-(void)getUserInfo
{
    [WJGAFCheckNetManager shareTools].type = checkNetTypeWithMe;
    [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
    self.isPush = NO;
    [self logManagersayHi];
    self.personModel = [[KKPersonModel alloc] init];
    [KKPersonModel getUser:^(NSDictionary * _Nonnull requset) {
        if ([[requset objectForKey:@"code"] intValue]==1) {
            NSDictionary *data = [requset objectForKey:@"data"];
            self.personModel = [KKPersonModel yy_modelWithDictionary:data];
            self.cycleScrollView.imageURLStringsGroup = self.personModel.photos;
            self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            self.cycleScrollView.layer.masksToBounds = YES;
            [self.table reloadData];
            [[NSUserDefaults standardUserDefaults] setObject:self.personModel.photos forKey:@"userphoto"];
            [self.table reloadData];
            self.isPush = YES;
        }
        else
        {
            [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(7)} userInfo:[NSDictionary new] upload:NO];
        }
    }];
}


#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
        _table.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kNavBarHeight);
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

-(SDCycleScrollView *)cycleScrollView
{
    if(!_cycleScrollView)
    {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) delegate:self placeholderImage:[UIImage imageNamed:@"backImg2"]];
        _cycleScrollView.autoScrollTimeInterval = 5;
    }
    return _cycleScrollView;
}

-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        
    }
    return _footView;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 4;
    }
    else
    {
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        KKPersonalCell0 *cell = [tableView dequeueReusableCellWithIdentifier:personalidentfity0];
        cell = [[KKPersonalCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalidentfity0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.personModel;
        return cell;
    }
    if (indexPath.section==1) {
        KKPersonalCell1 *cell = [tableView dequeueReusableCellWithIdentifier:personalidentfity1];
        cell = [[KKPersonalCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalidentfity1];
        cell.model = self.personModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        KKPersonalCell2 *cell = [tableView dequeueReusableCellWithIdentifier:personalidentfity2];
        cell = [[KKPersonalCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalidentfity2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
        return cell;
    }
    if (indexPath.section==3) {
        KKPersonalCell3 *cell = [tableView dequeueReusableCellWithIdentifier:personalidentfity3];
        cell = [[KKPersonalCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalidentfity3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                cell.typeImg.image = [UIImage imageNamed:@"address"];
                if (self.personModel.city.length==0) {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                else
                {
                    cell.contentLab.text = self.personModel.city?:@"";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                }
               
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                break;
            case 1:
                cell.typeImg.image = [UIImage imageNamed:@"constellation"];
                if (self.personModel.horoscope.length==0) {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                else
                {
                    cell.contentLab.text = self.personModel.horoscope?:@"";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                }
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                break;
            case 2:
                cell.typeImg.image = [UIImage imageNamed:@"feelings"];
                if (self.personModel.single.length!=0) {
                    if ([self.personModel.single isEqualToString:@"1"]) {
                        cell.contentLab.text = @"Single";
                         cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                    }
                    else
                    {
                        cell.contentLab.text = @"Live alone";
                        cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                    }
                }
                else
                {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                break;
            case 3:
                cell.typeImg.image = [UIImage imageNamed:@"barthday"];
                if (self.personModel.birthday.length==0) {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                else
                {
                    cell.contentLab.text = self.personModel.birthday?:@"";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                }
                break;
            default:
                break;
        }
        return cell;
    }
    if (indexPath.section==4) {
        KKPersonalCell3 *cell = [tableView dequeueReusableCellWithIdentifier:personalidentfity4];
        cell = [[KKPersonalCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalidentfity4];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeImg.image = [UIImage imageNamed:@"setting"];
        cell.contentLab.text = @"Set up";
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 65;
    }
    if (indexPath.section==1) {
        NSMutableArray *arr =  [[KKLikedmedbManager sharedClient] loaddata];
        arr = (NSMutableArray *)[[arr reverseObjectEnumerator] allObjects];
        if (arr.count==0) {
            return 50;
        }
        else
        {
            return 103;
        }
        return 103;
    }
    if (indexPath.section==2) {
        return 45;
    }
    if (indexPath.section==3) {
        return 50;
    }
    if (indexPath.section==4) {
        return 45;
    }
    return 0.01f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if ([KKUserModel sharedUserModel].isVip) {
            [[XYLogManager shareManager] addLogKey1:@"profile" key2:@"like" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
            KKLikedViewController *VC = [KKLikedViewController new];
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Who liked me" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:VC animated:YES];
        }
        else
        {
            //订阅
            [self showPaymentViewController];
            [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(6)} userInfo:nil upload:YES];
        }
    }
    if (indexPath.section==4) {
        KKSettingViewController *vc = [KKSettingViewController new];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = item;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 打点上传

-(void)logManager
{
    [[XYLogManager shareManager] addLogKey1:@"profile" key2:@"show" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
    
}

-(void)logManagersayHi
{
    [[XYLogManager shareManager] addLogKey1:@"hi" key2:@"click" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
}

@end
