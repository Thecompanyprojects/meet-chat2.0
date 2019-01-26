//
//  XTlikedViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKLikedViewController.h"
#import "KKdiscoverCell.h"
#import "KKDiscoverModel.h"
#import "KKRobitinfoViewController.h"
#import "KKChatManager.h"
#import "KKChatSendManager.h"
#import "KKLikedmedbManager.h"

@interface KKLikedViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,myTabVdelegate>
{
    int size;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) XYAdObject *interstitialAdObj; /**< 插屏广告对象 */
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

static NSString *likedidentfity = @"likedidentfity";

@implementation KKLikedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    
    [self.view addSubview:self.collectionView];
    [self loadNewData];
    if (self.isFromApns) {
        [self isFromApnsClick];
    }
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice:) name:LikedmeNoc object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)notice:(id)sender{
    NSLog(@"%@",sender);
    
    [[KKLikedmedbManager sharedClient] firstchoose];
    [WJGAFCheckNetManager shareTools].type = checkNetTypeWithlikedme;
    [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
    self.dataArray = [NSMutableArray array];
    NSString *Newid = [KKUserModel sharedUserModel].userId;
    NSInteger intid = [Newid intValue];
    NSDictionary *para = @{@"id":@(intid)};
    [[AFNetAPIClient sharedClient] requestUrl:pushlikeme cParameters:para success:^(NSDictionary * _Nonnull requset) {
        if ([[requset objectForKey:@"code"] intValue]==1) {
            NSMutableArray *data = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[KKDiscoverModel class] json:requset[@"data"][@"botlist"]]];
            [self.dataArray addObjectsFromArray:data];
           
            [[KKLikedmedbManager sharedClient] instrtmymodelWith:self.dataArray];
        }
        else
        {
             [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(5)} userInfo:[NSDictionary new] upload:NO];
        }
        [self loadNewData];
    } failure:^(NSError * _Nonnull error) {
        [self loadNewData];
         [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(5)} userInfo:[NSDictionary new] upload:NO];
    }];
    
}

-(void)loadNewData
{
    [self.dataSource removeAllObjects];
    self.dataSource =  [[KKLikedmedbManager sharedClient] loaddata];
    [self.collectionView reloadData];
    
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStateBarHeight) collectionViewLayout:flowLayout];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 18*KWIDTH, 30, 18*KWIDTH);
        [_collectionView registerClass:[KKdiscoverCell class] forCellWithReuseIdentifier:likedidentfity];
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
    KKdiscoverCell *cell = (KKdiscoverCell *)[collectionView dequeueReusableCellWithReuseIdentifier:likedidentfity forIndexPath:indexPath];
    [cell newsetModel:self.dataSource[indexPath.item]];
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
    KKDiscoverModel *model = self.dataSource[indexPath.item];
    KKRobitinfoViewController *VC = [KKRobitinfoViewController new];
    VC.type = RobotinfofromLiked;
    [[XYLogManager shareManager] addLogKey1:@"personal_details" key2:@"show" content:@{@"type":@(4)} userInfo:[NSDictionary new] upload:YES];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    VC.model = model;
    VC.returnPeopleBlock = ^(BOOL peopleIndex) {
        
        [self.collectionView reloadData];
    };
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)myTabVClick:(UICollectionViewCell *)cell
{
    if ([self isshouldUpload]) {
        [self UploadthePhoto];
    }
    else
    {
        NSIndexPath *index = [self.collectionView indexPathForCell:cell];
        KKDiscoverModel *model = self.dataSource[index.item];
        if (model.issayHi!=YES) {
            NSString *botid = model.Newid;
            
            [self logManagersayHi];
            
            [[KKLikedmedbManager sharedClient] updateDataWithuserId:model.Newid];
            [self loadNewData];
            
            int botidint = [botid intValue];
            NSString *lang = @"en";
            NSString *content = [[[KKmessageModel sharedClient] showbackmessage]filtrationSpecailCharactor];
            NSDictionary *dic = @{@"botid":@(botidint),@"lang":lang?:@"",@"content":content?:@"",@"contenttype":@1};
            [[KKChatManager sharedChatManager] chatSayHi:botid withContent:content withUserName:model.name withPhoto:model.photo.firstObject];
            MessageItem * item = [[MessageItem alloc]init];
            item.userId = botid;
            item.userName = model.name;
            item.message = content;
            item.photo = model.photo.firstObject;
            item.createDate = [NSDate date].timeIntervalSince1970 * 1000;
            item.sendUserId = [KKUserModel sharedUserModel].userId;
            KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
            messageDetail.msgItem = item;
            messageDetail.closeBlock = ^{
                [self showadClick];
            };
            UIBarButtonItem *items = [[UIBarButtonItem alloc] initWithTitle:@"Liked me" style:UIBarButtonItemStylePlain target:nil action:nil];
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

-(void)showadClick
{
    NSString *sayhi = [KKShowadModel sharedShowadModel].say_hi;
    //MARK - 插屏广告
    [KKShowadModel sharedShowadModel].newsay_hi = [KKShowadModel sharedShowadModel].newsay_hi+1;
    NSInteger newintsayhi=  [KKShowadModel sharedShowadModel].newsay_hi;
    NSInteger intsayhi = [sayhi integerValue];
    
    if (newintsayhi%intsayhi==0&&intsayhi!=0) {
        
          if (![KKUserModel sharedUserModel].isVip) {
              [[XYAdBaseManager sharedInstance] loadAdWithKey:KeySayhi scene:LOADADsay_hi];
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
}


#pragma mark - 埋点

-(void)logManagersayHi
{
    [[XYLogManager shareManager] addLogKey1:@"hi" key2:@"click" content:@{@"type":@"5"} userInfo:[NSDictionary new] upload:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LikedmeNoc object:nil];
}

@end
