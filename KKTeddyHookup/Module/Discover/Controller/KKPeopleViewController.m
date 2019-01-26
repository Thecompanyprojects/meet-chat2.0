//
//  peopleViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/18.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPeopleViewController.h"
#import "KKpeopleCell.h"
#import "KKDiscoverModel.h"
#import "KKRobitinfoViewController.h"
#import "KKChatManager.h"
#import "KKChatSendManager.h"
#import "KKActivesqlManager.h"

@interface KKPeopleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,myTabVdelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, strong) XYAdObject *interstitialAdObj; /**< 插屏广告对象 */
@property (nonatomic,assign) BOOL isshowFooter;
@end

static NSString *peopleidentfity = @"peopleidentfity";

@implementation KKPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [KKShowadModel sharedShowadModel].type = Showadwithalive;
    [[KKShowadModel sharedShowadModel] loadAdwithType];

    self.title = @"Active people";
    [self logManager];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    [self.view addSubview:self.collectionView];
    [self getInfo];
    if (self.isFromApns) {
        [self isFromApnsClick];
    }
    [self logManagerWithenter];
}

-(void)isFromApnsClick
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_black"]style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
}

-(void)rebackToRootViewAction
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)getInfo
{
    [self getloadlogManager];
    [self.dataSource removeAllObjects];
    
    self.dataSource = [[KKActivesqlManager sharedClient] loaddata];
    if (self.dataSource.count!=0) {
        [self.collectionView reloadData];
        self.isshowFooter = YES;
    }
    else
    {
        [self.dataSource removeAllObjects];
        NSDictionary *dic = @{@"size":@9};
        [XYLoadingHUD show];
        [WJGAFCheckNetManager shareTools].type = checkNetTypeWithactive;
        [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
        [[AFNetAPIClient sharedClient] requestUrl:ActivePeople cParameters:dic success:^(NSDictionary * _Nonnull requset) {
            [XYLoadingHUD dismiss];
            if ([[requset objectForKey:@"code"] intValue]==1) {
                NSMutableArray *data = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[KKDiscoverModel class] json:requset[@"data"][@"botlist"]]];
                
                NSMutableArray *Array = [NSMutableArray new];
                [Array addObjectsFromArray:data];
                [[KKActivesqlManager sharedClient] firstchoose];
                [KKActivesqlManager sharedClient].dataSource = Array;
                [[KKActivesqlManager sharedClient] deletefromData];
                [[KKActivesqlManager sharedClient] instrtmymodel];
                self.dataSource = [[KKActivesqlManager sharedClient] loaddata];
                
                self.isshowFooter = YES;
            }
            else
            {
                [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(4)} userInfo:[NSDictionary new] upload:NO];
            }
            [self.collectionView reloadData];
        } failure:^(NSError * _Nonnull error) {
            [XYLoadingHUD dismiss];
            [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(4)} userInfo:[NSDictionary new] upload:NO];
        }];
    }
}

-(void)refreshData
{
    [self getloadlogManager];
    [[KKShowsubscribeModel sharedShowsubModel] addrefreshActivePeopleClick];
    [self.dataSource removeAllObjects];
    NSDictionary *dic = @{@"size":@9};
    [XYLoadingHUD show];
    [[AFNetAPIClient sharedClient] requestUrl:ActivePeople cParameters:dic success:^(NSDictionary * _Nonnull requset) {
        [XYLoadingHUD dismiss];
        if ([[requset objectForKey:@"code"] intValue]==1) {
            NSMutableArray *data = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[KKDiscoverModel class] json:requset[@"data"][@"botlist"]]];
            NSMutableArray *Array = [NSMutableArray new];
            [Array addObjectsFromArray:data];
            [[KKActivesqlManager sharedClient] firstchoose];
            [KKActivesqlManager sharedClient].dataSource = Array;
            [[KKActivesqlManager sharedClient] deletefromData];
            [[KKActivesqlManager sharedClient] instrtmymodel];
            self.dataSource = [[KKActivesqlManager sharedClient] loaddata];
            self.isshowFooter = YES;
        }
        [self.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [XYLoadingHUD dismiss];
    }];
}

#pragma mark - getters

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) collectionViewLayout:flowLayout];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 18*KWIDTH, 30, 18*KWIDTH);
        flowLayout.footerReferenceSize = CGSizeMake(kScreenWidth, 150.0f);
        [_collectionView registerClass:[KKpeopleCell class] forCellWithReuseIdentifier:peopleidentfity];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
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


#pragma mark -UICollectionViewDataSource&&UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count?:0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KKpeopleCell *cell = (KKpeopleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:peopleidentfity forIndexPath:indexPath];
    if (self.dataSource.count!=0) {
        cell.model = self.dataSource[indexPath.item];
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
    
    KKDiscoverModel *model = self.dataSource[indexPath.item];
    KKRobitinfoViewController *VC = [KKRobitinfoViewController new];
    VC.type = RobotinfofromActive;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    VC.model = model;
    VC.returnPeopleBlock = ^(BOOL peopleIndex) {
        model.issayHi = peopleIndex;
        [self.collectionView reloadData];
    };
    [[XYLogManager shareManager] addLogKey1:@"personal_details" key2:@"show" content:@{@"type":@(2)} userInfo:[NSDictionary new] upload:YES];
    [self.navigationController pushViewController:VC animated:YES];
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
    UIButton *refreshBtn = [[UIButton alloc] init];
    [refreshBtn addTarget:self action:@selector(footersubmitClick) forControlEvents:UIControlEventTouchUpInside];
    [refreshBtn setTitle:@"More" forState:normal];
    [refreshBtn setTitleColor:[UIColor whiteColor] forState:normal];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    refreshBtn.backgroundColor = MainColor;
    refreshBtn.frame = CGRectMake(20, 1, kScreenWidth-40, 40);
    refreshBtn.layer.masksToBounds = YES;
    refreshBtn.layer.cornerRadius = 20;
    [footerView addSubview:refreshBtn];
    if (self.isshowFooter) {
        [refreshBtn setHidden:NO];
    }
    else
    {
        [refreshBtn setHidden:YES];
    }
    return footerView;
}

-(void)footersubmitClick
{
    if ([KKUserModel sharedUserModel].isVip) {
         [self refreshData];
    }
    else
    {
        if([[KKShowsubscribeModel sharedShowsubModel] activepeopleCanShow])
        {
            [self refreshData];
        }
        else
        {
            
            if ([[KKShowsubscribeModel sharedShowsubModel] isNewSub]) {
                 [self videoAdClick];
            }
            else
            {
                [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(1)} userInfo:nil upload:YES];
                [self showPaymentViewController];
            }
           
        }
        [self showAdwithActivePeople];
        
    }

}

#pragma mark - 视频广告

-(void)videoAdClick
{
    [self adVideowithActive];
}

-(void)sayhiVideoadClick
{
    [self adVideowithSayhi];
}

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
        
        if (![[KKShowsubscribeModel sharedShowsubModel] sayhinumberClick]) {
            [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(0)} userInfo:nil upload:YES];
            [self showPaymentViewController];
       
            return;
        }
        
        NSIndexPath *index = [self.collectionView indexPathForCell:cell];
        KKDiscoverModel *model = self.dataSource[index.item];
        if (model.issayHi!=YES) {
            model.issayHi = YES;
            NSString *botid = model.Newid;
            
            [[KKActivesqlManager sharedClient] updateDataWithuserId:model.Newid];
            
            int botidint = [botid intValue];
            NSString *lang = @"en";
            NSString *content = [[[KKmessageModel sharedClient] showbackmessage]filtrationSpecailCharactor];
            NSDictionary *dic = @{@"botid":@(botidint),@"lang":lang?:@"",@"content":content?:@"",@"contenttype":@1};
            [self logManagersayHi];
            [[KKChatManager sharedChatManager] chatSayHi:botid withContent:content withUserName:model.name withPhoto:model.photo.firstObject];
            MessageItem * item = [[MessageItem alloc]init];
            item.userName = model.name;
            item.photo = model.photo.firstObject;
            item.message = content;
            item.userId = model.Newid;
            item.createDate = [NSDate date].timeIntervalSince1970*1000;
            KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
            item.sendUserId = [KKUserModel sharedUserModel].userId;
            messageDetail.msgItem = item;
            messageDetail.closeBlock = ^{
                [self showadClick];
                [self.collectionView reloadData];
            };
            UIBarButtonItem *items = [[UIBarButtonItem alloc] initWithTitle:@"Active" style:UIBarButtonItemStylePlain target:nil action:nil];
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
                    [self.collectionView reloadData];
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
    }
}

#pragma mark - 插屏广告

-(void)showAdwithActivePeople
{
    if([KKShowadModel sharedShowadModel].activeAdisShow)
    {
        XYAdObject *obj = [[XYAdBaseManager sharedInstance] getAdWithKey:KeyAlive showScene:ADalive];
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

-(void)showadClick
{
    [KKShowadModel sharedShowadModel].type = Showadwithsay_hi;
    [[KKShowadModel sharedShowadModel] loadAdwithType];
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

#pragma mark - 打点上报

-(void)logManager
{
    [[XYLogManager shareManager] addLogKey1:@"found" key2:@"show" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
}

-(void)getloadlogManager
{
    [[XYLogManager shareManager] addLogKey1:@"active_people" key2:@"click_refresh" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
}

-(void)logManagersayHi
{
    [[XYLogManager shareManager] addLogKey1:@"hi" key2:@"click" content:@{@"type":@"4"} userInfo:[NSDictionary new] upload:YES];
}

-(void)logManagerWithenter
{
    if (self.isFromApns) {
        [[XYLogManager shareManager] addLogKey1:@"active_people" key2:@"show" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
    }
    else
    {
        [[XYLogManager shareManager] addLogKey1:@"active_people" key2:@"show" content:@{@"type":@"0"} userInfo:[NSDictionary new] upload:YES];
    }
}

@end
