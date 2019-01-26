//
//  XTRobotinfoViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/25.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKRobitinfoViewController.h"
#import "SDCycleScrollView.h"
#import "KKRboitCell0.h"
#import "KKRboitCell1.h"
#import "KKPersonalCell2.h"
#import "KKRboitCell2.h"
#import "KKChatManager.h"
#import "KKChatSendManager.h"
#import "KKVideoPlayController.h"
#import "KKLikedmedbManager.h"
#import "KKDiscoversqlManager.h"
#import "KKActivesqlManager.h"

@interface KKRobitinfoViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic, strong) XYAdObject *interstitialAdObj; /**< 插屏广告对象 */
@property (nonatomic,assign) BOOL VideoIsHi;
@end

static NSString *robitidentfity0 = @"robitidentfity0";
static NSString *robitidentfity1 = @"robitidentfity1";
static NSString *robitidentfity2 = @"robitidentfity2";
static NSString *robitidentfity3 = @"robitidentfity3";
static NSString *robitidentfity4 = @"robitidentfity4";
static NSString *robitidentfity5 = @"robitidentfity5";
static NSString *robitidentfity6 = @"robitidentfity6";

@implementation KKRobitinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[XYAdBaseManager sharedInstance] loadAdWithKey:KeySayhi scene:LOADADsay_hi];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.cycleScrollView;
    self.table.tableFooterView = self.footView;
    [self setdata];
    [self submitView];
    [self lotManagernet];
    [self notifity];
}

-(void)notifity
{
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:kPaymentSuccessNotificationName object:nil];
}

-(void)notice:(id)sender{
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)submitView
{
    if (!self.model.issayHi) {
        self.submitBtn.backgroundColor = MainColor;
        [self.submitBtn setUserInteractionEnabled:YES];
    }
    else
    {
        self.submitBtn.backgroundColor = [UIColor lightGrayColor];
        [self.submitBtn setUserInteractionEnabled:NO];
    }
}

-(void)setdata
{
    self.cycleScrollView.imageURLStringsGroup = self.model.photo;
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollView.layer.masksToBounds = YES;
    [self.table reloadData];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
        _table.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight);
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
        _footView = [[UIView alloc] init];
        if (isIPhoneX_All) {
            _footView.frame = CGRectMake(0, 0, kScreenWidth, 90);
        }
        else
        {
            _footView.frame = CGRectMake(0, 0, kScreenWidth, 70);
        }
        [_footView addSubview:self.submitBtn];
    }
    return _footView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.frame = CGRectMake(20, 20, kScreenWidth-40, 40);
        [_submitBtn setTitle:@"Hi" forState:normal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        [_submitBtn addTarget:self action:@selector(submitbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 3;
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
        KKRboitCell0 *cell = [tableView dequeueReusableCellWithIdentifier:robitidentfity0];
        cell = [[KKRboitCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:robitidentfity0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }
    if (indexPath.section==1) {
        if (self.model.videopreview.count!=0) {
            
            NSString *videoPrevideurl = [self.model.video firstObject];
            if (videoPrevideurl.length>3) {
                KKRboitCell1 *cell = [tableView dequeueReusableCellWithIdentifier:robitidentfity1];
                cell = [[KKRboitCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:robitidentfity1];
                cell.model = self.model;
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else
            {
                return [UITableViewCell new];
            }
         
        }
        else
        {
            return [UITableViewCell new];
        }
       return [UITableViewCell new];
    }
    if (indexPath.section==2) {
        KKPersonalCell2 *cell = [tableView dequeueReusableCellWithIdentifier:robitidentfity2];
        cell = [[KKPersonalCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:robitidentfity2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
        return cell;
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            if (self.model.city.length!=0) {
                KKRboitCell2 *cell = [tableView dequeueReusableCellWithIdentifier:robitidentfity3];
                cell = [[KKRboitCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:robitidentfity3];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.typeImg.image = [UIImage imageNamed:@"address"];
                cell.contentLab.text = self.model.city?:@"";
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                return cell;
            }
         else
         {
             return [UITableViewCell new];
         }
            
        }
        if (indexPath.row==1) {
            if (self.model.horoscope.length!=0) {
                KKRboitCell2 *cell = [tableView dequeueReusableCellWithIdentifier:robitidentfity4];
                cell = [[KKRboitCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:robitidentfity4];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.typeImg.image = [UIImage imageNamed:@"constellation"];
                cell.contentLab.text = self.model.horoscope?:@"";
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                return cell;
            }
            else
            {
                return [UITableViewCell new];
            }
        }
        if (indexPath.row==2) {
            if (self.model.single.length!=0) {
                KKRboitCell2 *cell = [tableView dequeueReusableCellWithIdentifier:robitidentfity5];
                cell = [[KKRboitCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:robitidentfity5];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.typeImg.image = [UIImage imageNamed:@"feelings"];
                if (self.self.model.single.length!=0) {
                    if ([self.model.single isEqualToString:@"1"]) {
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
                return cell;
            }
            else
            {
                return [UITableViewCell new];
            }
        }
        return [UITableViewCell new];
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 62;
    }
    if (indexPath.section==1) {
        if (self.model.videopreview.count!=0) {
            NSString *videoPrevideurl = [self.model.video firstObject];
            if (videoPrevideurl.length>3)
            {
                return 140;
            }
            else
            {
                return 0.01f;
            }
            
        }
        else
        {
            return 0.01f;
        }
        return 0.01f;
    }
    if (indexPath.section==2) {
        return 45;
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            if (self.model.city.length!=0) {
                return 50;
            }
            else
            {
                return 0.01f;
            }
        }
        if (indexPath.row==1) {
            if (self.model.horoscope.length!=0) {
                return 50;
            }
            else
            {
                return 0.01f;
            }
        }
        if (indexPath.row==2) {
            if (self.model.single.length!=0) {
                return 50;
            }
            else
            {
                return 0.01f;
            }
        }
        return 0.01f;
    }
    return 0.01f;
}

#pragma mark - sayHi

-(void)submitbtnClick
{
    [self logManagersayHi];

    if ([self isshouldUpload]) {
        [self UploadthePhoto];
    }
    else
    {
        if (![[KKShowsubscribeModel sharedShowsubModel] sayhinumberClick]) {
            
            [self showPaymentViewController];
            
            return;
        }
       
        self.model.issayHi = YES;
        self.VideoIsHi = YES;
        [self submitView];
        
        NSString *botid = self.model.Newid;
        
        switch (self.type) {
            case RobotinfofromActive:
                 [[KKActivesqlManager sharedClient] updateDataWithuserId:self.model.Newid];
                break;
            case RobotinfofromDis:
                [[KKDiscoversqlManager sharedClient] updateDataWithuserId:self.model.Newid];
                break;
            case RobotinfofromLiked:
                [[KKLikedmedbManager sharedClient] updateDataWithuserId:self.model.Newid];
                break;
            case RobotinfofromShake:
                
                break;
            default:
                break;
        }
        
        int botidint = [botid intValue];
        NSString *lang = @"en";
        NSString *content = [[[KKmessageModel sharedClient] showbackmessage]filtrationSpecailCharactor];
        NSDictionary *dic = @{@"botid":@(botidint),@"lang":lang?:@"",@"content":content?:@"",@"contenttype":@1};
        [[KKChatManager sharedChatManager] chatSayHi:botid withContent:content withUserName:self.model.name withPhoto:self.model.photo.firstObject];
        MessageItem * item = [[MessageItem alloc]init];
        item.userName = self.model.name;
        item.photo = self.model.photo.firstObject;
        item.message = content;
        item.createDate = [NSDate date].timeIntervalSince1970 * 1000;
        item.userId = self.model.Newid;
        KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
        item.sendUserId = [KKUserModel sharedUserModel].userId;
        messageDetail.msgItem = item;
        messageDetail.closeBlock = ^{
            
            if (self->_returnPeopleBlock) {
                self.returnPeopleBlock(self.model.issayHi);
            }
            [self showadClick];
        };
        [self.navigationController pushViewController:messageDetail animated:YES];
        UIBarButtonItem *items = [[UIBarButtonItem alloc] initWithTitle:@"Info" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = items;
        [[KKShowsubscribeModel sharedShowsubModel] addSayhiNumberClick];
        [[AFNetAPIClient sharedClient] requestUrl:Sayhi cParameters:dic success:^(NSDictionary * _Nonnull requset) {
            if ([[requset objectForKey:@"code"] intValue]==1)
            {
                [SVProgressHUD showInfoWithStatus:@"Success"];
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
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
}

#pragma mark - 跳转视频播放

-(void)myTabVClick:(NSString *)vieoUrl
{
    if ([KKUserModel sharedUserModel].isVip) {
        KKVideoPlayController *VC = [KKVideoPlayController new];
        switch (self.type) {
            case RobotinfofromActive:
                VC.type = RobotvideofromActive;
                break;
            case RobotinfofromShake:
                VC.type = RobotvideofromShake;
                break;
            case RobotinfofromDis:
                VC.type = RobotvideofromDis;
                break;
            case RobotinfofromLiked:
                VC.type = RobotvideofromLiked;
                break;
            default:
                break;
        }
        VC.isfromlikedme = YES;
        VC.disModel = self.model;
        NSString *NewUrl = [vieoUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        VC.videoUrl = NewUrl;
        VC.isfromDis = YES;
        VC.issayHi = self.model.issayHi;
        [VC returnPeopleindex:^(BOOL isSayHi) {
            if (isSayHi) {
                self.VideoIsHi = YES;
                if (self->_returnPeopleBlock) {
                    self.returnPeopleBlock(self.VideoIsHi);
                }
                if (!self.VideoIsHi) {
                    self.submitBtn.backgroundColor = MainColor;
                    [self.submitBtn setUserInteractionEnabled:YES];
                }
                else
                {
                    self.submitBtn.backgroundColor = [UIColor lightGrayColor];
                    [self.submitBtn setUserInteractionEnabled:NO];
                }
            }
        }];
        if (self.VideoIsHi) {
            VC.issayHi = YES;
        }
        [self.navigationController pushViewController:VC animated:YES];
    }
    else
    {
        [self showPaymentViewController];
    }
}

/**
   say_hi 插屏广告
 */
-(void)showadClick
{
    NSString *sayhi = [KKShowadModel sharedShowadModel].say_hi;
    [KKShowadModel sharedShowadModel].newsay_hi = [KKShowadModel sharedShowadModel].newsay_hi+1;
    NSInteger newintsayhi=  [KKShowadModel sharedShowadModel].newsay_hi;
    NSInteger intsayhi = [sayhi integerValue];
    
    if (newintsayhi%intsayhi==0&&intsayhi!=0) {
        if ([KKUserModel sharedUserModel].isVip) {
            return;
        }
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
    [[XYLogManager shareManager] addLogKey1:@"personal_details" key2:@"show" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
}

-(void)logManagersayHi
{
    [[XYLogManager shareManager] addLogKey1:@"hi" key2:@"click" content:@{@"type":@"2"} userInfo:[NSDictionary new] upload:YES];
}

-(void)lotManagernet
{
    [WJGAFCheckNetManager shareTools].type = checkNetTypeWithrobit;
    [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPaymentSuccessNotificationName object:nil];
}

@end
