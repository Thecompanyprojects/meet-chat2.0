//
//  XTIMDiscoverViewController.m
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/10/15.
//  Copyright © 2018年 KK. All rights reserved.
//®

#import "KKDiscoverViewController.h"
#import "KKPaymentViewController.h"
#import "KKDiscoverheaderView.h"
#import "KKdiscoverCell.h"
#import "KKShakeViewController.h"
#import "KKBottleViewController.h"
#import "KKPeopleViewController.h"
#import "KKDiscoverModel.h"
#import "KKReScreenView.h"
#import "KKRobitinfoViewController.h"
#import "KKChatManager.h"
#import "UIButton+PassValue.h"
#import "KKVideoListController.h"
#import "KKChatSendManager.h"
#import "KKRecommendViewController.h"
#import "KKDiscoversqlManager.h"
#import "KKIncentiveManager.h"

#define ScrrenHeight  330.0

@interface KKDiscoverViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,myTabVdelegate,myHeadVdelegate>
{
    int PageSize;
}
@property (nonatomic,strong) KKDiscoverheaderView *headerView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableDictionary *parameters;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, strong) XYAdObject *interstitialAdObj; /**< 插屏广告对象 */
@end

static NSString *discoverIdentfity = @"discoverIdentfity";

@implementation KKDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [KKShowadModel sharedShowadModel].type = Showadwithsay_hi;
    [[KKShowadModel sharedShowadModel] loadAdwithType];
  
    PageSize = 9;
    int idint = [[KKUserModel sharedUserModel].userId intValue];
    self.parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sex":@"f",
                                                                      @"age":@[@18,@40],
                                                                      @"active":@(4),
                                                                      @"size":@(PageSize),
                                                                      @"id":@(idint)}];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];
    [self loadNewData];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self notifity];
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

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addSubscribeButton];
}

- (void)setupView {
    [self.view addSubview:self.headerView];
    [self addSubscribeButton];
}

-(void)loadNewData
{
    self.dataSource = [NSMutableArray array];
    self.dataSource = [[KKDiscoversqlManager sharedClient] loaddata];
    if (self.dataSource.count!=0) {
        
        [self.collectionView reloadData];
        
    }
    else
    {
        [self.dataSource removeAllObjects];
        
        [WJGAFCheckNetManager shareTools].type = checkNetTypeWithdiscover;
        [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
        
        [[AFNetAPIClient sharedClient] requestUrl:SocicalchatFiltrate cParameters:self.parameters success:^(NSDictionary * _Nonnull requset) {
            
            if ([[requset objectForKey:@"code"] intValue]==1) {
                NSMutableArray *data = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[KKDiscoverModel class] json:requset[@"data"][@"botlist"]]];
                NSMutableArray *dataArray = [NSMutableArray new];
                [dataArray addObjectsFromArray:data];
                
                [[KKDiscoversqlManager sharedClient] firstchoose];
                [KKDiscoversqlManager sharedClient].dataSource = dataArray;
                [[KKDiscoversqlManager sharedClient] instrtmymodel];
                self.dataSource = [[KKDiscoversqlManager sharedClient] loaddata];
                
            }
            else
            {
                  [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:NO];
            }
            [self.collectionView reloadData];
        } failure:^(NSError * _Nonnull error) {
              [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:NO];
        }];
    }
}

-(void)loadMoreData
{
    [WJGAFCheckNetManager shareTools].type = checkNetTypeWithdiscover;
    [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
    [[AFNetAPIClient sharedClient] requestUrl:SocicalchatFiltrate cParameters:self.parameters success:^(NSDictionary * _Nonnull requset) {
        
        if ([[requset objectForKey:@"code"] intValue]==1) {
            NSMutableArray *data = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[KKDiscoverModel class] json:requset[@"data"][@"botlist"]]];
            NSMutableArray *dataArray = [NSMutableArray new];
            [dataArray addObjectsFromArray:data];
            [self.dataSource addObjectsFromArray:data];
        }
        else
        {
            [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:NO];
        }
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) {

        [self.collectionView.mj_footer endRefreshing];
        [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:NO];
    }];
}

#pragma mark ScrreenDelegate

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
}

- (void)subscribeButtonAction:(UIBarButtonItem *)sender {
    [self showPaymentViewController];
}

#pragma mark - getters

-(KKDiscoverheaderView *)headerView
{
    if(!_headerView)
    {
        _headerView = [[KKDiscoverheaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth,160);
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 160, kScreenWidth, kScreenHeight-kNavBarHeight) collectionViewLayout:flowLayout];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 18*KWIDTH, 30, 18*KWIDTH);
        [_collectionView registerClass:[KKdiscoverCell class] forCellWithReuseIdentifier:discoverIdentfity];
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //背景颜色
        _collectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

-(NSMutableArray *)dataSource
{
    if(!_dataSource)
    {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count?:0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    KKdiscoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:discoverIdentfity forIndexPath:indexPath];
    if ([KKUserModel sharedUserModel].isVip) {
        if (self.dataSource.count!=0) {
            [cell newsetModel:self.dataSource[indexPath.item]];
        }
    }
    else
    {
        if (self.dataSource.count!=0) {
             [cell setModel:self.dataSource[indexPath.item] withIndex:indexPath];
        }
    }
    cell.delegate = self;
    return cell;
}

//定义每个Cell的大小

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(105*KWIDTH,155);
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count==0) {
        return;
    }
    
    KKShowsubscribeModel *submodel = [KKShowsubscribeModel sharedShowsubModel];
    NSString *indexrstr = submodel.discover_user_count;
    int indexr = [indexrstr intValue];
    if ([KKUserModel sharedUserModel].isVip||indexPath.item<indexr) {
        KKDiscoverModel *model = self.dataSource[indexPath.item];
        KKRobitinfoViewController *VC = [KKRobitinfoViewController new];
        VC.type = RobotinfofromDis;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = item;
        VC.model = model;

        VC.returnPeopleBlock = ^(BOOL peopleIndex) {
            model.issayHi = peopleIndex;
            [self.collectionView reloadData];
            
        };
        [self robitPushlogManager];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else
    {
#pragma mark - 观看视频来解锁
        if ([[KKShowsubscribeModel sharedShowsubModel] isNewSub])
        {

            KKSubalertView *alertView = [KKSubalertView new];
            alertView.alertType = AlertwithRobit;
            
            [alertView withSubchooseClick:^(NSString * _Nonnull string) {
                [[KKPayManager sharedClient] addpay];
                [[TTPaymentManager shareInstance] paymentDirect];
                [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(7)} userInfo:[NSDictionary new] upload:YES];
                
            }];
            [alertView withSurevideoClick:^(NSString * _Nonnull string) {
                [XYLoadingHUD dismiss];
                [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
            }];
            [alertView returnText:^(NSString * _Nonnull showText) {
                
                KKDiscoverModel *Dmodel = self.dataSource[indexPath.row];
                KKRobitinfoViewController *VC = [KKRobitinfoViewController new];
                VC.type = RobotinfofromDis;
                UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
                self.navigationItem.backBarButtonItem = item;
                VC.model = Dmodel;
                VC.returnPeopleBlock = ^(BOOL peopleIndex) {
                    Dmodel.issayHi = peopleIndex;
                    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:0], nil]];
                };
                [self robitPushlogManager];
                [self.navigationController pushViewController:VC animated:YES];

            }];
        }
        else
        {
            [self showPaymentViewController];
        }
    }
}


/**
 SAY_HI

 @param cell SAY_HI
 */
-(void)myTabVClick:(UICollectionViewCell *)cell
{
    if (self.dataSource.count==0) {
        return;
    }
    if ([self isshouldUpload]) {
        [self UploadthePhoto];
        
    }
    else
    {
        NSIndexPath *index = [self.collectionView indexPathForCell:cell];
        KKDiscoverModel *model = self.dataSource[index.item];
        
        if (model.issayHi!=YES) {

            if (![KKUserModel sharedUserModel].isVip) {
                //say hi 统计
                if (![[KKShowsubscribeModel sharedShowsubModel] sayhinumberClick]) {
                    [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(0)} userInfo:nil upload:YES];
                    [self showPaymentViewController];
                    return;
                }
                
                
                KKShowsubscribeModel *submodel = [KKShowsubscribeModel sharedShowsubModel];
                NSString *indexrstr = submodel.discover_user_count;

                int indexr = [indexrstr intValue];
                if (index.item>=indexr) {
                    [self showPaymentViewController];
                    return;
                }

                [[KKDiscoversqlManager sharedClient] updateDataWithuserId:model.Newid];
                model.issayHi = YES;
                NSString *botid = model.Newid;
                int botidint = [botid intValue];
                NSString *lang = @"en";
                NSString *content = [[[KKmessageModel sharedClient] showbackmessage]filtrationSpecailCharactor];
                NSDictionary *dic = @{@"botid":@(botidint),@"lang":lang?:@"",@"content":content?:@"",@"contenttype":@1};
                
                [[KKChatManager sharedChatManager] chatSayHi:botid withContent:content withUserName:model.name withPhoto:model.photo.firstObject];
                
                MessageItem * item = [[MessageItem alloc]init];
                item.userName = model.name;
                item.message =content;
                item.photo = model.photo.firstObject;
                item.userId = model.Newid;
                item.createDate = [NSDate date].timeIntervalSince1970 * 1000;
                KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
                item.sendUserId = [KKUserModel sharedUserModel].userId;
                messageDetail.msgItem = item;
                messageDetail.closeBlock = ^{
                    [self.collectionView reloadData];
                    [self showadClick];
                };
                UIBarButtonItem *items = [[UIBarButtonItem alloc] initWithTitle:@"Discover" style:UIBarButtonItemStylePlain target:nil action:nil];
                self.navigationItem.backBarButtonItem = items;
                [self.navigationController pushViewController:messageDetail animated:YES];
                [[KKShowsubscribeModel sharedShowsubModel] addSayhiNumberClick];
                [[AFNetAPIClient sharedClient] requestUrl:Sayhi cParameters:dic success:^(NSDictionary * _Nonnull requset) {
                    if ([[requset objectForKey:@"code"] intValue]==1) {
                        NSDictionary * data = [requset objectForKey:@"data"];
                        if ([data isKindOfClass:[NSDictionary class]] && [[data objectForKey:@"replyflag"] isEqual:@1]) {
                            NSInteger sencond = [[data objectForKey:@"replytime"] integerValue];
                            NSInteger type = [[data objectForKey:@"contenttype"] integerValue];
                            item.msgType = type - 1;
                            if (type == 1) {
                                item.message = [[[data objectForKey:@"content"] safeObj:@"msg"]filtrationSpecailCharactor];
                            }else if (type == 2){
                                item.message = [[data objectForKey:@"content"] safeObj:@"photo"];
                            }else if (type == 3){
                                item.message = [NSString stringWithFormat:@"%@||%@",[[data objectForKey:@"content"] safeObj:@"videopreview"],[[data objectForKey:@"content"] safeObj:@"video"]];
                            }
                            [((AppDelegate *)[UIApplication sharedApplication].delegate) registerNotification:sencond withMessageItem:item];
                        }
                        model.issayHi = YES;
                        [self.collectionView reloadData];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                }];
            }
            else // VIP订阅用户 sayhi
            {
                model.issayHi = YES;
                NSString *botid = model.Newid;
                int botidint = [botid intValue];
                NSString *lang = @"en";
                NSString *content = [[[KKmessageModel sharedClient] showbackmessage]filtrationSpecailCharactor];
                NSDictionary *dic = @{@"botid":@(botidint),@"lang":lang?:@"",@"content":content?:@"",@"contenttype":@1};
                
                [[KKChatManager sharedChatManager] chatSayHi:botid withContent:content withUserName:model.name withPhoto:model.photo.firstObject];
                
                MessageItem * item = [[MessageItem alloc]init];
                item.userName = model.name;
                item.message =content;
                item.photo = model.photo.firstObject;
                item.userId = model.Newid;
                item.createDate = [NSDate date].timeIntervalSince1970 * 1000;
                KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
                item.sendUserId = [KKUserModel sharedUserModel].userId;
                messageDetail.msgItem = item;
                messageDetail.closeBlock = ^{
                    [self.collectionView reloadData];
                    [self showadClick];
                };
                UIBarButtonItem *items = [[UIBarButtonItem alloc] initWithTitle:@"Discover" style:UIBarButtonItemStylePlain target:nil action:nil];
                self.navigationItem.backBarButtonItem = items;
                [self.navigationController pushViewController:messageDetail animated:YES];

                [[AFNetAPIClient sharedClient] requestUrl:Sayhi cParameters:dic success:^(NSDictionary * _Nonnull requset) {
                    if ([[requset objectForKey:@"code"] intValue]==1) {
                        NSDictionary * data = [requset objectForKey:@"data"];
                        if ([data isKindOfClass:[NSDictionary class]] && [[data objectForKey:@"replyflag"] isEqual:@1]) {
                            NSInteger sencond = [[data objectForKey:@"replytime"] integerValue];
                            NSInteger type = [[data objectForKey:@"contenttype"] integerValue];
                            item.msgType = type - 1;
                            if (type == 1) {
                                item.message = [[[data objectForKey:@"content"] safeObj:@"msg"]filtrationSpecailCharactor];
                            }else if (type == 2){
                                item.message = [[data objectForKey:@"content"] safeObj:@"photo"];
                            }else if (type == 3){
                                item.message = [NSString stringWithFormat:@"%@||%@",[[data objectForKey:@"content"] safeObj:@"videopreview"],[[data objectForKey:@"content"] safeObj:@"video"]];
                            }
                            [((AppDelegate *)[UIApplication sharedApplication].delegate) registerNotification:sencond withMessageItem:item];
                        }
                        model.issayHi = YES;
                        [self.collectionView reloadData];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                }];
            }
        }

    }
}

-(void)showadClick
{
    if ([[KKShowadModel sharedShowadModel] sayhiADisshow]) {
        XYAdObject *obj = [[XYAdBaseManager sharedInstance] getAdWithKey:KeySayhi showScene:ADsay_hi];
        self.interstitialAdObj = obj;
        [obj interstitialAdBlock:^(XYAdPlatform adPlatform, FBInterstitialAd *fbInterstitial, GADInterstitial *gadInterstitial, BOOL isClick, BOOL isLoadSuccess) {
            if (adPlatform == XYFacebookAdPlatform) {
                [fbInterstitial showAdFromRootViewController:[UIViewController currentViewController]];
                
            } else if (adPlatform == XYAdMobPlatform) {
                [gadInterstitial presentFromRootViewController:[UIViewController currentViewController]];
                
            }
        }];
    }
}

#pragma mark - 点击事件

-(void)headshakingbtnClick
{
    KKShakeViewController *vc = [KKShakeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)headactivebtnClick
{
    KKPeopleViewController *vc = [KKPeopleViewController new];
    [[XYLogManager shareManager] addLogKey1:@"active_people" key2:@"show" content:@{@"type":@(0)} userInfo:[NSDictionary new] upload:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)headbottlebtnClick
{
    KKBottleViewController *vc = [KKBottleViewController new];
    vc.isfromDis = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)headrecommendedbtnClick
{
    KKRecommendViewController *VC = [KKRecommendViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)headactivitybtnClick
{
    //订阅
    [self showPaymentViewController];
}

-(void)headvideobtnClick
{
    KKVideoListController *VC = [KKVideoListController new];
    VC.isLeft = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)myheaderClick:(NSString *)typeStr
{
    if ([typeStr isEqualToString:@"shake"]) {
        [self headshakingbtnClick];
    }
    if ([typeStr isEqualToString:@"drifter"]) {
        [self headbottlebtnClick];
    }
    if ([typeStr isEqualToString:@"active"]) {
        [self headactivebtnClick];
    }
    if ([typeStr isEqualToString:@"video"]) {
        [self headvideobtnClick];
    }
    if ([typeStr isEqualToString:@"hot"]) {
        [self headactivitybtnClick];
    }
    if ([typeStr isEqualToString:@"recommend"]) {
        [self headrecommendedbtnClick];
    }
}
//
//-(void)chooseClick:(UIButton *)btn
//{
//    NSLog(@"%@",btn.paramDic);
//    NSString *title = [btn.paramDic objectForKey:@"title"];
//
//}

#pragma mark - 打点上传

-(void)robitPushlogManager
{
    [[XYLogManager shareManager] addLogKey1:@"personal_details" key2:@"show" content:@{@"type":@(0)} userInfo:[NSDictionary new] upload:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPaymentSuccessNotificationName object:nil];
}

@end
