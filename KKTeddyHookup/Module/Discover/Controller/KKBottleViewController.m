//
//  bottleViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/18.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKBottleViewController.h"
#import "KKbottleAlertView.h"
#import "KKgetbottleAlertView.h"
#import "KKRobitinfoViewController.h"
#import "KKMessageDetailController.h"
#import "KKChatSendManager.h"

@interface KKBottleViewController ()
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UIImageView *bottleImg;
@property (nonatomic,strong) UIImageView *barreliImg;
@property (nonatomic,strong) UIImageView *shadowImg0;
@property (nonatomic,strong) UIImageView *showImg;
@property (nonatomic,strong) UIImageView *newbottleImg;
@property (nonatomic,strong) UIImageView *dropsImg;
@property (nonatomic, strong) XYAdObject *interstitialAdObj; /**< 插屏广告对象 */
@property (nonatomic,assign) BOOL iscanGet;
@end

@implementation KKBottleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delNavLine];
    // Do any additional setup after loading the view.
    [KKShowadModel sharedShowadModel].type = Showadwithdrifter;
    [[KKShowadModel sharedShowadModel] loadAdwithType];
    self.title = @"Drift bottle";
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"FFFFFF"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"30b1e9"];
    self.navigationController.navigationBar.translucent = NO;
    
    [self logManager];
    self.iscanGet = YES;
    [self.view addSubview:self.bgImg];
    [self.view addSubview:self.bottleImg];
    [self.view addSubview:self.barreliImg];
    [self.view addSubview:self.shadowImg0];
    [self.view addSubview:self.showImg];
    [self.view addSubview:self.newbottleImg];
    [self.view addSubview:self.dropsImg];
    [self setuplayout];
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
    [KKUserModel sharedUserModel].isVip = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [super viewDidDisappear:animated];
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;

    [weakSelf.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];

    [weakSelf.barreliImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(84);
        make.height.mas_offset(82);
        make.bottom.equalTo(weakSelf.view).with.offset(-35);
        make.right.equalTo(weakSelf.view).with.offset(-62*KWIDTH);
    }];
    
    [weakSelf.bottleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).with.offset(-35);
        make.left.equalTo(weakSelf.view).with.offset(62*KWIDTH);
        make.width.mas_offset(84);
        make.height.mas_offset(82);
    }];
    
    [weakSelf.shadowImg0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        
    }];
    
    [weakSelf.showImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(44);
        make.height.mas_offset(62);
        make.centerX.equalTo(weakSelf.view);
        if (self.isfromDis) {
             make.top.equalTo(weakSelf.view).with.offset(340*KHEIGHT);
        }
        else
        {
             make.top.equalTo(weakSelf.view).with.offset(320*KHEIGHT);
        }
    }];
    
    [weakSelf.newbottleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).with.offset(-140*KHEIGHT);
        make.left.equalTo(weakSelf.view).with.offset(66);
        make.width.mas_offset(44);
        make.height.mas_offset(62);
    }];

    [weakSelf.dropsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).with.offset(-180*KHEIGHT);
        make.width.mas_offset(50);
        make.height.mas_offset(32);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                  NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"30b1e9"];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                  NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [super viewWillDisappear:animated];
}

#pragma mark - getters

-(UIImageView *)bgImg
{
    if(!_bgImg)
    {
        _bgImg = [[UIImageView alloc] init];
        _bgImg.image = [UIImage imageNamed:@"hai"];
        _bgImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showclick)];
        [_bgImg addGestureRecognizer:tapGesturRecognizer];
    }
    return _bgImg;
}

-(UIImageView *)bottleImg
{
    if(!_bottleImg)
    {
        _bottleImg = [[UIImageView alloc] init];
        _bottleImg.image = [UIImage imageNamed:@"turow"];
        _bottleImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getbottle)];
        [_bottleImg addGestureRecognizer:tapGesturRecognizer];
    }
    return _bottleImg;
}

-(UIImageView *)barreliImg
{
    if(!_barreliImg)
    {
        _barreliImg = [[UIImageView alloc] init];
        _barreliImg.image = [UIImage imageNamed:@"pick"];
        _barreliImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scoopupClick)];
        [_barreliImg addGestureRecognizer:tapGesturRecognizer];
    }
    return _barreliImg;
}

-(UIImageView *)shadowImg0
{
    if(!_shadowImg0)
    {
        _shadowImg0 = [[UIImageView alloc] init];
        
        [_shadowImg0 setHidden:YES];
        _shadowImg0.image = [UIImage imageNamed:@"bottlebg1"];
    }
    return _shadowImg0;
}

-(UIImageView *)showImg
{
    if(!_showImg)
    {
        _showImg = [[UIImageView alloc] init];
        [_showImg setHidden:YES];
        _showImg.image = [UIImage imageNamed:@"newPingzi"];
        _showImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(findbottleclick)];
        [_showImg addGestureRecognizer:tapGesturRecognizer];
    }
    return _showImg;
}

-(UIImageView *)newbottleImg
{
    if(!_newbottleImg)
    {
        _newbottleImg = [[UIImageView alloc] init];
        _newbottleImg.image = [UIImage imageNamed:@"newPingzi"];
        [_newbottleImg setHidden:YES];
    }
    return _newbottleImg;
}

-(UIImageView *)dropsImg
{
    if(!_dropsImg)
    {
        _dropsImg = [[UIImageView alloc] init];
        
    }
    return _dropsImg;
}

#pragma mark - 捡瓶子

-(void)scoopupClick
{
    if ([self isshouldUpload]) {
        [self UploadthePhoto];
        return;
    }
    BOOL isShow = [KKShowsubscribeModel sharedShowsubModel].getbottleCanShow;
    if (isShow) {
        [[KKShowsubscribeModel sharedShowsubModel] addGetbottleClick];
        [self buildAnimationImageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.shadowImg0 setHidden:NO];
            [self.showImg setHidden:NO];
        });
        [self showAd];
    }
    else
    {
        if ([[KKShowsubscribeModel sharedShowsubModel] isNewSub]) {
            [self videogetbottleAdClick];
        }
        else
        {
            [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(3)} userInfo:nil upload:YES];
            [self showPaymentViewController];
        }
    }
}

#pragma mark - 隐藏不显示瓶子

-(void)showclick
{
    [self.showImg setHidden:YES];
    [self.shadowImg0 setHidden:YES];
}

#pragma mark - 打开瓶子

-(void)findbottleclick
{
    if(self.iscanGet)
    {
        [self showAd];
        [WJGAFCheckNetManager shareTools].type = checkNetTypeWithbottle;
        [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
        [[AFNetAPIClient sharedClient] requestUrl:findbottle cParameters:[NSDictionary new] success:^(NSDictionary * _Nonnull requset) {
            if ([[requset objectForKey:@"code"] intValue]==1) {
                
                KKDiscoverModel *model = [KKDiscoverModel new];
                NSDictionary *data = [requset objectForKey:@"data"];
                NSDictionary *botinfo = [data objectForKey:@"botinfo"];
                model = [KKDiscoverModel yy_modelWithDictionary:botinfo];
                
                [self logManagerwithPoptype:@{@"result":@"1"}];
                
                //显示瓶子内容
                KKgetbottleAlertView *alertView = [KKgetbottleAlertView new];
                alertView.nameLab.text = model.name?:@"";
                alertView.ageLab.text = model.age?:@"0";
                alertView.contentLab.text = model.signature?:@"";
                
                if (model.photopreview.count!=0) {
                    [alertView.coverImg sd_setImageWithURL:[NSURL URLWithString:[model.photopreview firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
                }
                
                id contentid = [data objectForKey:@"content"];
                if ([contentid isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *bottlecontent = [data objectForKey:@"content"];
                    NSString *msg = [bottlecontent objectForKey:@"msg"];
                    alertView.messageLab.text = msg?:@"";
                }

                if ([model.sex isEqualToString:@"m"]) {
                    alertView.sexImg.image = [UIImage imageNamed:@"boy"];
                }
                else
                {
                    alertView.sexImg.image = [UIImage imageNamed:@"girl"];
                }
                
                [alertView withrepylClick:^(NSString * _Nonnull string) {
                    if ([contentid isKindOfClass:[NSDictionary class]]) {
                        //跳转到聊天界面
                        MessageItem * item = [[MessageItem alloc]init];
                        item.userId = model.Newid;
                        item.userName = model.name;
                        NSInteger type = [[data objectForKey:@"contenttype"] integerValue];
                        item.msgType = type - 1;
                        if (type == 1) {
                            item.message = [[[data objectForKey:@"content"] safeObj:@"msg"]filtrationSpecailCharactor];
                        }else if (type == 2){
                            item.message = [[data objectForKey:@"content"] safeObj:@"photo"];
                        }else if (type == 3){
                            item.message = [NSString stringWithFormat:@"%@||%@",[[data objectForKey:@"content"] safeObj:@"videopreview"],[[data objectForKey:@"content"] safeObj:@"video"]];
                        }
                        item.photo = model.photopreview.firstObject;
                        item.createDate = [NSDate date].timeIntervalSince1970 * 1000;
                        item.sendUserId = model.Newid;
                        [[KKChatSendManager sharedInstance] senderMessage:item withAfterSecond:0];
                        KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
                        messageDetail.msgItem = item;
                        [self.navigationController pushViewController:messageDetail animated:YES];
                        
                    }
                    
                    [self logManagerwithPickuptype:@{@"result":@"0"}];
                    
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.shadowImg0 setHidden:YES];
                        [self.showImg setHidden:YES];
                    });
                    self.iscanGet = YES;
                }];
                [alertView withDismissClick:^(NSString * _Nonnull string) {
                    [self makedownAnimation];
                    [self logManagerwithPickuptype:@{@"pick_up":@"1"}];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showclick];
                        self.iscanGet = YES;
                    });
                    
                }];
                
            }
            else
            {
                [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(3)} userInfo:[NSDictionary new] upload:NO];
            }
            self.iscanGet = YES;
        } failure:^(NSError * _Nonnull error) {
            self.iscanGet = YES;
            [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(3)} userInfo:[NSDictionary new] upload:NO];
        }];
    }
    self.iscanGet = NO;
}

#pragma mark -扔瓶子

-(void)getbottle
{
    
    if ([self isshouldUpload]) {
        [self UploadthePhoto];
        return;
    }
    
    [self showclick];
    [self logManagerwithPoptype:@{@"result":@"0"}];
    KKbottleAlertView *alertView = [[KKbottleAlertView alloc] init];
    alertView.nameLab.text =  [KKUserModel sharedUserModel].name?:@"";
    if (![[KKUserModel sharedUserModel].signature isKindOfClass:[NSNull class]]) {
        alertView.contentLab.text = [KKUserModel sharedUserModel].signature?:@"";
    }
  
    if (![[KKUserModel sharedUserModel].age isKindOfClass:[NSNull class]]) {
        alertView.ageLab.text = [KKUserModel sharedUserModel].age?:@"";
    }
    else
    {
        alertView.ageLab.text = @"0";
    }

    if ([[KKUserModel sharedUserModel].sex isEqualToString:@"m"]) {
        alertView.sexImg.image = [UIImage imageNamed:@"boy"];
    }
    else
    {
        alertView.sexImg.image = [UIImage imageNamed:@"girl"];
    }
    NSArray *photoarr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphoto"];
    if (photoarr.count!=0) {
        [alertView.coverImg sd_setImageWithURL:[NSURL URLWithString:[photoarr firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
    }

    [alertView withrepylClick:^(NSString * _Nonnull string) {
        
        self.newbottleImg.hidden = NO;

        NSString *Newstring= [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (Newstring.length!=0) {
            [UIView animateWithDuration:0.3 animations:^{
                [alertView removeFromSuperview];
            }];
            
            NSString *content = string;
            NSString *lang = @"en";
            NSDictionary *dic = @{@"content":content?:@"",@"lang":lang};
            [self logManagerwithThrowtype:@{@"result":@"0"}];
            
            if (![KKShowsubscribeModel sharedShowsubModel].putbottleCanShow) {
                
                [self.newbottleImg setHidden:YES];

                if ([[KKShowsubscribeModel sharedShowsubModel] isNewSub]) {
                    [self videosetbottleAdClick];
                }
                else
                {
                    [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(3)} userInfo:nil upload:YES];
                    [self showPaymentViewController];
                }
                
            }
            else
            {
                [self makeGoOnAnimation];
                [[KKShowsubscribeModel sharedShowsubModel] addSetbottleClick];
                [[AFNetAPIClient sharedClient] requestUrl:throwbottle cParameters:dic success:^(NSDictionary * _Nonnull requset) {
                    if ([[requset objectForKey:@"code"] intValue]==1) {
                        [SVProgressHUD showInfoWithStatus:@"Success!"];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                }];
            }
        }
        else
        {
            
            [SVProgressHUD showInfoWithStatus:@"Input cannot be empty"];
            [self.newbottleImg setHidden:YES];
        }
    }];
}

#pragma mark - 插屏广告

-(void)showAd
{
    if ([[KKShowadModel sharedShowadModel] drifterADisshow]) {
        XYAdObject *obj = [[XYAdBaseManager sharedInstance] getAdWithKey:KeyDrifter showScene:ADdrifter];
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

-(void)makeGoOnAnimation{
    //定义一个动画开始的时间
    CFTimeInterval currentTime = CACurrentMediaTime();
    CABasicAnimation *positionAni = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAni.fromValue = [NSValue valueWithCGPoint:CGPointMake(180*KWIDTH, kScreenHeight-230*KHEIGHT)];
    positionAni.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
    positionAni.duration = 1.5f;
    positionAni.fillMode = kCAFillModeForwards;
    positionAni.removedOnCompletion = NO;
    positionAni.beginTime = currentTime;
    [self.newbottleImg.layer addAnimation:positionAni forKey:@"positionAnimation"];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.5f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = 2.0f;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = YES;
    [self.newbottleImg.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];

    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    groupAni.animations = [NSArray arrayWithObjects:positionAni,scaleAnimation,nil];
    [self.newbottleImg.layer addAnimation:groupAni forKey:@"groupAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.newbottleImg setHidden:YES];
    });

}

-(void)makedownAnimation
{
    CFTimeInterval currentTime = CACurrentMediaTime();
    
    CABasicAnimation *positionAni = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAni.fromValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
    positionAni.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenWidth/2*2.5)];
    positionAni.duration = 1.5f;
    positionAni.fillMode = kCAFillModeForwards;
    positionAni.removedOnCompletion = YES;
    positionAni.beginTime = currentTime;
    [self.showImg.layer addAnimation:positionAni forKey:@"positionAnimation"];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = 1.5f;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = YES;
    [self.showImg.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    groupAni.animations = [NSArray arrayWithObjects:positionAni,scaleAnimation,nil];
    [self.showImg.layer addAnimation:groupAni forKey:@"groupAnimation"];
}

- (void)buildAnimationImageView
{
    NSArray *array = @[[UIImage imageNamed:@"shuihua1"],
                       [UIImage imageNamed:@"shuihua2"],];
    self.dropsImg.animationImages = array;              //设置图像视图的动画图片属性
    self.dropsImg.animationDuration = 2;                //设置帧动画时长
    self.dropsImg.animationRepeatCount = 1;             //设置无限次循环
    self.dropsImg.contentMode = UIViewContentModeCenter;
    [self.dropsImg startAnimating];
}

#pragma mark - 打点上报

-(void)logManager
{
    [[XYLogManager shareManager] addLogKey1:@"drift_bottle" key2:@"show" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
    
}

//result:0/1 0：扔瓶子的弹窗  1:捡瓶子的弹窗

-(void)logManagerwithPoptype:(NSDictionary *)keyDic
{
    [[XYLogManager shareManager] addLogKey1:@"drift_bottle" key2:@"Popup" content:keyDic userInfo:[NSDictionary new] upload:YES];
    
}

//pick_up 捡  result:0/1 0:回复 1：扔回去

-(void)logManagerwithPickuptype:(NSDictionary *)keyDic
{
    [[XYLogManager shareManager] addLogKey1:@"drift_bottle" key2:@"pick_up" content:keyDic userInfo:[NSDictionary new] upload:YES];
    
}

//throw result:0/1 0:扔出去 1：取消

-(void)logManagerwithThrowtype:(NSDictionary *)keyDic
{
    [[XYLogManager shareManager] addLogKey1:@"drift_bottle" key2:@"throw" content:keyDic userInfo:[NSDictionary new] upload:YES];
    
}

#pragma mark - 激励视频广告

/**
 扔瓶子 激励视频
 */
-(void)videosetbottleAdClick
{
    [self adVideowithbottle];
}


/**
 捡瓶子 激励视频
 */
-(void)videogetbottleAdClick
{
    [self adVideowithgetbottle];
}

- (void)dealloc {
    //删除根据name和对象，如果object对象设置为nil，则删除所有叫name的，否则便删除对应的
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPaymentSuccessNotificationName object:nil];
}


@end
