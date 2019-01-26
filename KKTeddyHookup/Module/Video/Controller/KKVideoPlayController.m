//
//  VideoPlayController.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKVideoPlayController.h"
#import "KKChatManager.h"
#import "XBVideoPlayer.h"
#import "Masonry.h"
#import "XBDataTaskManager.h"
#import "NSURL+XBLoader.h"
#import "KKChatSendManager.h"
#import "KKLikedmedbManager.h"
#import "KKDiscoversqlManager.h"
#import "KKActivesqlManager.h"
#import "KKIsLodingManager.h"

@interface KKVideoPlayController ()
@property (nonatomic,strong) XBVideoPlayer *videoplayer;
@property (nonatomic,assign) BOOL isPause;
@property (nonatomic, strong)UIImageView *maskImg;
@property (nonatomic, strong)UIImageView *typeImg;
@property (nonatomic, strong)UIButton *sayhiBtn;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *ageLab;
@property (nonatomic, strong)UIImageView *sexImg;
@property (nonatomic, strong)UIButton *cityLab;
@property (nonatomic, strong)UIButton *constellationLab;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UIView *sexbgView;
@property (nonatomic, strong) XYAdObject *interstitialAdObj; /**< 插屏广告对象 */
@property (nonatomic, assign) BOOL isTouch;
@end

@implementation KKVideoPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTouch = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.videoplayer];
    [self.view addSubview:self.maskImg];
    [self.view addSubview:self.typeImg];
    [self.view addSubview:self.sayhiBtn];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.ageLab];
    [self.view addSubview:self.sexbgView];
    [self.view addSubview:self.sexImg];
    [self.view addSubview:self.cityLab];
    [self.view addSubview:self.constellationLab];
    [self setuplayout];
    if (self.isfromDis) {
        [self setNetDict];
    }
    else
    {
        [self setData];
    }
}

-(void)setNetDict
{
    self.nameLab.text = self.disModel.name?:@"";
    self.ageLab.text = self.disModel.age?:@"0";
    if ([self.disModel.sex isEqualToString:@"m"]) {
        self.sexImg.image = [UIImage imageNamed:@"nan2"];
        self.sexbgView.backgroundColor = [UIColor colorWithHexString:@"FE5283"];
    }
    else
    {
        self.sexImg.image = [UIImage imageNamed:@"nv2"];
        self.sexbgView.backgroundColor = [UIColor colorWithHexString:@"FE5283"];
    }
    [self.cityLab setTitle:self.disModel.city?:@"" forState:normal];
    [self.constellationLab setTitle:self.disModel.horoscope?:@"" forState:normal];
    if (self.issayHi) {
        [self.sayhiBtn setImage:[UIImage imageNamed:@"hi2"] forState:normal];
    }
    else
    {
        [self.sayhiBtn setImage:[UIImage imageNamed:@"hi"] forState:normal];
    }
    NSString *path = self.videoUrl;
    self.videoplayer.arr_urlStrs = @[path];
}

-(void)setData
{
    self.nameLab.text = self.model.name?:@"";
    self.ageLab.text = self.model.age?:@"0";
    if ([self.model.sex isEqualToString:@"m"]) {
        self.sexImg.image = [UIImage imageNamed:@"nan2"];
        self.sexbgView.backgroundColor = [UIColor colorWithHexString:@"FE5283"];
    }
    else
    {
        self.sexImg.image = [UIImage imageNamed:@"nv2"];
        self.sexbgView.backgroundColor = [UIColor colorWithHexString:@"FE5283"];
    }
    [self.cityLab setTitle:self.model.city?:@"" forState:normal];
    [self.constellationLab setTitle:self.model.horoscope?:@"" forState:normal];
    if (self.issayHi) {
        [self.sayhiBtn setImage:[UIImage imageNamed:@"hi2"] forState:normal];
    }
    else
    {
        [self.sayhiBtn setImage:[UIImage imageNamed:@"hi"] forState:normal];
    }
    //NSString *path = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    
    NSString *path = self.videoUrl;
    self.videoplayer.arr_urlStrs = @[path];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.videoplayer playWithErrorBlock:^(XBAVPlayer *player, XBAVPlayerError xbError) {
        
    }];
}

- (void)changeProgress:(UISlider *)slider
{
    [self.videoplayer seekToTime:self.videoplayer.f_playingItemDuration * slider.value];
}

- (void)playVideo:(UIButton *)button
{
    [self.videoplayer playWithErrorBlock:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    

    [super viewDidDisappear:animated];
    [self.videoplayer freePlayer];
    
    if (self.returnPeopleBlock != nil) {
        self.returnPeopleBlock(self.issayHi);
    }
}

-(void)returnPeopleindex:(ReturnPeopleBlock)block
{
    self.returnPeopleBlock = block;
    
}

-(void)dealloc
{
    NSLog(@"XBVideoViewController销毁");
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.maskImg);
        make.centerY.equalTo(weakSelf.maskImg);
        make.width.mas_offset(60);
        make.height.mas_offset(60);
    }];
    
    [weakSelf.sayhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(48);
        make.height.mas_offset(48);
        make.right.equalTo(weakSelf.view).with.offset(-20);
        make.bottom.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    [weakSelf.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(20);
        if (isIPhoneX_All) {
            make.top.equalTo(weakSelf.view).with.offset(44);
        }
        else
        {
            make.top.equalTo(weakSelf.view).with.offset(24);
        }
        make.width.mas_offset(12);
        make.height.mas_offset(20);
    }];
    CGFloat wid0 = 0.01f;
    if (self.isfromDis) {
        wid0 = [self calculateRowWidth:self.disModel.city];
    }
    else
    {
        wid0 = [self calculateRowWidth:self.model.city];
    }
    
    
    [weakSelf.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.bottom.equalTo(weakSelf.sayhiBtn).with.offset(-12);
        make.height.mas_offset(25);
        make.width.mas_offset(wid0+10);
    }];
    CGFloat wid1 = 0.01f;
    if (self.isfromDis) {
        wid1 = [self calculateRowWidth:self.disModel.horoscope];
        
    }
    else
    {
        wid1 = [self calculateRowWidth:self.model.horoscope];
        
    }
    
    [weakSelf.constellationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.cityLab.mas_right).with.offset(10);
        make.bottom.equalTo(weakSelf.sayhiBtn).with.offset(-12);
        make.width.mas_offset(wid1+10);
        make.height.mas_offset(25);
    }];
    
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.cityLab.mas_top).with.offset(-20);
        make.left.equalTo(weakSelf.cityLab);
        make.height.mas_offset(23);
    }];
    [weakSelf.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(13);
        make.left.equalTo(weakSelf.nameLab.mas_right).with.offset(7);
        make.width.mas_offset(22);
        make.centerY.equalTo(weakSelf.nameLab);
    }];
    [weakSelf.sexbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(22);
        make.height.mas_offset(13);
        make.left.equalTo(weakSelf.ageLab.mas_right).with.offset(7);
        make.centerY.equalTo(weakSelf.nameLab);
    }];
    [weakSelf.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.sexbgView);
        make.height.mas_offset(10);
        make.width.mas_offset(10);
        make.top.equalTo(weakSelf.sexbgView).with.offset(1);
    }];
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

#pragma mark - getters

-(XBVideoPlayer *)videoplayer
{
    if (_videoplayer == nil)
    {
        _videoplayer = [XBVideoPlayer new];
        [self.view addSubview:_videoplayer];
        _videoplayer.backgroundColor = [UIColor blackColor];

        WEAK_SELF
        _videoplayer.bl_playProgress = ^(XBAVPlayer *player, CGFloat progress, CGFloat current, CGFloat total) {
            NSLog(@"当前进度：%f, 播放了：%f, 总共：%f",progress,current,total);

        };
        _videoplayer.bl_bufferBlock = ^(XBAVPlayer *player, CGFloat totalBuffer) {
            NSLog(@"已经缓冲了：%f",totalBuffer);

        };
       
        //竖屏时的布局
        _videoplayer.bl_layout_vertical = ^(XBAVPlayer *player) {
            [player mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view);
                make.left.equalTo(weakSelf.view);
                make.right.equalTo(weakSelf.view);
            }];
        };
      
    }
    return _videoplayer;
}


-(UIImageView *)maskImg
{
    if(!_maskImg)
    {
        _maskImg = [[UIImageView alloc] init];
        _maskImg.frame = [UIScreen mainScreen].bounds;
        _maskImg.image = [UIImage imageNamed:@"maskview"];
        
        _maskImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [_maskImg addGestureRecognizer:singleTap];
        
    }
    return _maskImg;
}

-(UIImageView *)typeImg
{
    if(!_typeImg)
    {
        _typeImg = [[UIImageView alloc] init];
        _typeImg.image = [UIImage imageNamed:@"play"];
        _typeImg.hidden = YES;
    }
    return _typeImg;
}

-(UIButton *)sayhiBtn
{
    if(!_sayhiBtn)
    {
        _sayhiBtn = [[UIButton alloc] init];
        [_sayhiBtn setImage:[UIImage imageNamed:@"hi"] forState:normal];
        [_sayhiBtn addTarget:self action:@selector(sayhibtnClick) forControlEvents:UIControlEventTouchUpInside];
        _sayhiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        _sayhiBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    }
    return _sayhiBtn;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor whiteColor];
        _nameLab.font = [UIFont systemFontOfSize:20];
        //_nameLab.text = @"NameAMD";
    }
    return _nameLab;
}

-(UILabel *)ageLab
{
    if(!_ageLab)
    {
        _ageLab = [[UILabel alloc] init];
        _ageLab.textAlignment = NSTextAlignmentCenter;
        _ageLab.backgroundColor = MainColor;
        _ageLab.font = [UIFont systemFontOfSize:10];
        _ageLab.textColor = [UIColor whiteColor];
        _ageLab.layer.masksToBounds = YES;
        _ageLab.layer.cornerRadius = 3;
    }
    return _ageLab;
}

-(UIView *)sexbgView
{
    if(!_sexbgView)
    {
        _sexbgView = [[UIView alloc] init];
        _sexbgView.backgroundColor = [UIColor colorWithHexString:@"FE5283"];
        _sexbgView.layer.masksToBounds = YES;
        _sexbgView.layer.cornerRadius = 3;
    }
    return _sexbgView;
}

-(UIImageView *)sexImg
{
    if(!_sexImg)
    {
        _sexImg = [[UIImageView alloc] init];
        
    }
    return _sexImg;
}

-(UIButton *)cityLab
{
    if(!_cityLab)
    {
        _cityLab = [[UIButton alloc] init];
        [_cityLab setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _cityLab.titleLabel.font = [UIFont systemFontOfSize:10];
        _cityLab.backgroundColor = [UIColor colorWithHexString:@"333333"];
        _cityLab.layer.masksToBounds = YES;
        _cityLab.layer.cornerRadius = 8;
        _cityLab.alpha = 0.8;
        _cityLab.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, -10);
    }
    return _cityLab;
}

-(UIButton *)constellationLab
{
    if(!_constellationLab)
    {
        _constellationLab = [[UIButton alloc] init];
        [_constellationLab setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _constellationLab.titleLabel.font = [UIFont systemFontOfSize:10];
        _constellationLab.backgroundColor = [UIColor colorWithHexString:@"333333"];
        _constellationLab.layer.masksToBounds = YES;
        _constellationLab.layer.cornerRadius = 8;
        _constellationLab.alpha = 0.8;
        _constellationLab.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -20);
    }
    return _constellationLab;
}

-(UIButton *)backBtn
{
    if(!_backBtn)
    {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:normal];
        [_backBtn addTarget:self action:@selector(backbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    }
    return _backBtn;
}

#pragma mark -YWMediaControlDelegate

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if ([KKIsLodingManager sharedClient].isTouch) {
        self.isPause = !self.isPause;
        if (self.isPause) {
            [self.videoplayer pause];
            self.typeImg.hidden = NO;
        }
        else
        {
            [self.videoplayer startPlayClick];
            self.typeImg.hidden = YES;
        }
    }
}

#pragma mark - 实现方法

-(void)stopbtnClick
{
    
}

-(void)backbtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sayhibtnClick
{
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
        if (self.issayHi!=YES) {
            NSString *botid = [NSString new];
            
            if (self.isfromDis) {
                 botid= self.disModel.Newid;
            }
            else
            {
                 botid= self.model.Newid;
            }
            
            switch (self.type) {
                case RobotvideofromList:
                    
                    break;
                case RobotvideofromDis:
                    [[KKDiscoversqlManager sharedClient] updateDataWithuserId:self.disModel.Newid];
                    break;
                case RobotvideofromLiked:
                     [[KKLikedmedbManager sharedClient] updateDataWithuserId:self.model.Newid];
                    break;
                case RobotvideofromActive:
                    [[KKActivesqlManager sharedClient] updateDataWithuserId:self.model.Newid];
                    break;
                case RobotvideofromShake:
                    
                    break;
                default:
                    break;
            }
            
            
            int botidint = [botid intValue];
            NSString *lang = @"en";
            NSString *content = [[[KKmessageModel sharedClient] showbackmessage]filtrationSpecailCharactor];
            NSDictionary *dic = @{@"botid":@(botidint),@"lang":lang?:@"",@"content":content?:@"",@"contenttype":@1};
            
            [self logManagersayHi];
            if (self.isfromDis) {
                  [[KKChatManager sharedChatManager] chatSayHi:botid withContent:content withUserName:self.disModel.name withPhoto:self.disModel.photo.firstObject];
            }
            else
            {
                  [[KKChatManager sharedChatManager] chatSayHi:botid withContent:content withUserName:self.model.name withPhoto:self.model.photo.firstObject];
            }
          
            MessageItem * item = [[MessageItem alloc]init];
            if (self.isfromDis) {
                item.userName = self.disModel.name;
                item.photo = self.disModel.photo.firstObject;
                item.userId = self.disModel.Newid;
            }
            else
            {
                item.userName = self.model.name;
                item.photo = self.model.photo.firstObject;
                item.userId = self.model.Newid;
            }
            item.createDate = [NSDate date].timeIntervalSince1970 * 1000;
            item.message = content;
            KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
            item.sendUserId = [KKUserModel sharedUserModel].userId;
            messageDetail.msgItem = item;
            messageDetail.closeBlock = ^{
                [self showadClick];
            };
            UIBarButtonItem *items = [[UIBarButtonItem alloc] initWithTitle:@"Video" style:UIBarButtonItemStylePlain target:nil action:nil];
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
                    self.issayHi = YES;
                    if (self.isfromDis) {
                        [self setNetDict];
                    }
                    else
                    {
                        [self setData];
                    }
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
            self.issayHi = YES;
            if (self.isfromDis) {
                [self setNetDict];
            }
            else
            {
                [self setData];
            }
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

-(void)logManagersayHi
{
    [[XYLogManager shareManager] addLogKey1:@"hi" key2:@"click" content:@{@"type":@"3"} userInfo:[NSDictionary new] upload:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
