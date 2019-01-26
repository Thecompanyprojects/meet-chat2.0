//
//  XTVideoListController.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKVideoListController.h"
#import "KKVideoCell.h"
#import "KKVideoPlayController.h"
#import "PlayerViewController.h"
#import "KKVideolistModel.h"

@interface KKVideoListController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,myTabVdelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *videoidendtify = @"videoidendtify";

@implementation KKVideoListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Video";
    [self logManager];
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.collectionView.mj_header beginRefreshing];
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
    [self.collectionView reloadData];
}

-(void)loadNewData
{
    [self.dataSource removeAllObjects];
    self.dataSource = [NSMutableArray array];

    [KKVideolistModel fetchDatasWithuserSuccess:^(NSDictionary * _Nonnull success) {
        if ([[success objectForKey:@"code"] intValue]==1) {
            NSMutableArray *data = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[KKVideolistModel class] json:success[@"data"][@"botlist"]]];
            [self.dataSource addObjectsFromArray:data];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        
    } failure:^(NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];

    }];
}

-(void)loadMoreData
{
    [KKVideolistModel fetchDatasWithuserSuccess:^(NSDictionary * _Nonnull success) {
        if ([[success objectForKey:@"code"] intValue]==1) {
            NSMutableArray *data = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[KKVideolistModel class] json:success[@"data"][@"botlist"]]];
            [self.dataSource addObjectsFromArray:data];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addSubscribeButton];
}

- (void)addSubscribeButton{
    if (self.isLeft) {
        self.view.backgroundColor = [UIColor colorWithHexString:@"C6C6C6"];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    }
    else
    {
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
}

- (void)subscribeButtonAction:(UIBarButtonItem *)sender {
    [self showPaymentViewController];
}


#pragma mark - getters

- (UICollectionView *)collectionView
{ 
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 20, 20);
        [_collectionView registerClass:[KKVideoCell class] forCellWithReuseIdentifier:videoidendtify];
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
    KKVideoCell *cell = (KKVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:videoidendtify forIndexPath:indexPath];
    cell.delegate = self;
    if ([KKUserModel sharedUserModel].isVip) {
        if (self.dataSource.count!=0) {
            [cell newSetmodel:self.dataSource[indexPath.item]];
        }
    }
    else
    {
        if (self.dataSource.count!=0) {
            cell.model = self.dataSource[indexPath.item];
        }
        
    }
    return cell;
}

//定义每个Cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(158*KWIDTH,192);
    return size;
}

-(void)myTabVClick:(UICollectionViewCell *)cell
{
    if ([KKUserModel sharedUserModel].isVip) {
        NSIndexPath *index =  [self.collectionView indexPathForCell:cell];
        KKVideolistModel *model = self.dataSource[index.item];
        KKVideoPlayController *VC = [KKVideoPlayController new];
        [VC returnPeopleindex:^(BOOL isSayHi) {
            if (isSayHi) {
                model.isSayHi = YES;
            }
        }];
        VC.type = RobotvideofromList;
        VC.model = model;
        VC.issayHi = model.isSayHi;
        if (model.video.count!=0) {
            NSString *VideoUrl = [[model.video firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            VC.videoUrl = VideoUrl;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    else
    {
        //订阅
        [self showPaymentViewController];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([KKUserModel sharedUserModel].isVip) {
        KKVideolistModel *model = self.dataSource[indexPath.item];
        KKVideoPlayController *VC = [KKVideoPlayController new];
        [VC returnPeopleindex:^(BOOL isSayHi) {
            if (isSayHi) {
                model.isSayHi = YES;
            }
        }];
        VC.type = RobotvideofromList;
        VC.model = model;
        VC.issayHi = model.isSayHi;
        if (model.video.count!=0) {
            NSString *VideoUrl = [[model.video firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            VC.videoUrl = VideoUrl;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    else
    {
        //订阅
        [self showPaymentViewController];
    }
}

#pragma mark - 打点上报

-(void)logManager
{
    [[XYLogManager shareManager] addLogKey1:@"video" key2:@"show" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPaymentSuccessNotificationName object:nil];
}


@end
