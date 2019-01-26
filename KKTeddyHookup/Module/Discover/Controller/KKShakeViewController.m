//
//  shakeViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/18.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKShakeViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "KKdiscoverAlertView.h"
#import "KKRobitinfoViewController.h"
#import "XTVCchoose.h"

@interface KKShakeViewController ()<CAAnimationDelegate> {
    SystemSoundID shakingMaleSound;
    SystemSoundID shakingMatchSound;
    SystemSoundID shakingNoMatchSound;
}
@property (nonatomic, strong) UIImageView *shakeImg;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, assign) BOOL isCan;
@property (nonatomic, strong) XYAdObject *interstitialAdObj;
@property (nonatomic, strong) KKDiscoverModel *cacheModel;
@end

#define KKSHAKEMODEL @"infoDic"

@implementation KKShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self logManager];
    [self delNavLine];
    self.title = @"Shake";
    
    self.isCan = YES;
    
    [KKShowadModel sharedShowadModel].type = Showadwithshake;
    [[KKShowadModel sharedShowadModel] loadAdwithType];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.navigationController.navigationBar.translucent = NO;
    // 控制器支持摇动
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // 加载音频
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shake_sound_male.wav" ofType:@""]]), &shakingMaleSound);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shake_match.wav" ofType:@""]]), &shakingMatchSound);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shake_match.wav" ofType:@""]]), &shakingNoMatchSound);
    [self.view addSubview:self.shakeImg];
    [self.view addSubview:self.contentLab];
    [self setuplayout];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice:) name:AlertShakenoc object:nil];
}



-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.shakeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).with.offset(180*KHEIGHT);
        make.width.mas_offset(167*KWIDTH);
        make.height.mas_offset(167*KWIDTH);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.shakeImg.mas_bottom).with.offset(20*KHEIGHT);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.isCan = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"f2f2f2"];
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"f2f2f2"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [super viewDidDisappear:animated];
}

#pragma mark - getters

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.text = @"Shake your phone to be matched with \n others who are shaking too";
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.numberOfLines = 2;
        _contentLab.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _contentLab;
}

-(UIImageView *)shakeImg
{
    if(!_shakeImg)
    {
        _shakeImg = [[UIImageView alloc] init];
        _shakeImg.image = [UIImage imageNamed:@"skake1"];
        _shakeImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        [_shakeImg addGestureRecognizer:singleTap];
    }
    return _shakeImg;
}

#pragma mark - 动画效果

- (void)shaking {
   
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value_0 = [NSNumber numberWithFloat:-M_PI/180*8];
    NSValue *value_1 = [NSNumber numberWithFloat:M_PI/180*8];
    NSValue *value_3 = [NSNumber numberWithFloat:-M_PI/180*8];
    anima.values = @[value_0,value_1,value_3];
    anima.repeatCount = 5;
    [self.shakeImg.layer addAnimation:anima forKey:@"shakeAnimation"];
}

#pragma mark - Animation Delegate
- (void)animationDidStart:(CAAnimation *)anim {
//    self.shakeUpLineImageView.hidden = NO;
//    self.shakeDownLineImageView.hidden = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

#pragma mark - Event Delegate
/**
 *  摇一摇结束调用
 */
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake) {
        if (self.isCan) {
            
            // 播放声音
            AudioServicesPlaySystemSound(shakingMaleSound);
            // 震动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

            // 真实一点的摇动动画
            [self shaking];
            [self shankClick];
        }
    }
    self.isCan = NO;
}


/**
 开始摇动
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}


/**
 取消摇动
 */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{

}

- (BOOL)canBecomeFirstResponder{
    
    return YES;
}

/**
 摇一摇匹配
 */
-(void)shankClick
{
    [WJGAFCheckNetManager shareTools].type = checkNetTypeWithshake;
    [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
    NSDictionary *dic = [NSDictionary new];
    self.cacheModel = [[KKDiscoverModel alloc] init];
    [[AFNetAPIClient sharedClient] requestUrl:Shake cParameters:dic success:^(NSDictionary * _Nonnull requset) {
        if ([[requset objectForKey:@"code"] intValue]==1) {
            [self showAd];
            if ([[XTVCchoose sharedClient].getCurrentVC isMemberOfClass:[KKShakeViewController class]]){
                // 匹配成功声音
                AudioServicesPlaySystemSound(self->shakingMatchSound);
                NSDictionary *data = [requset objectForKey:@"data"];
                NSDictionary *botinfo = [data objectForKey:@"botinfo"];
               
                [[NSUserDefaults standardUserDefaults] setObject:botinfo forKey:KKSHAKEMODEL];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self.cacheModel = [KKDiscoverModel yy_modelWithJSON:botinfo];
                [self AddAlertViewtoView];
            }
            else
            {
                self.isCan = YES;
                [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(2)} userInfo:[NSDictionary new] upload:NO];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        self.isCan = YES;
        [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(2)} userInfo:[NSDictionary new] upload:NO];
    }];
}

#pragma mark - 视频广告

-(void)videoAdClick
{
    [self adVideowithshake];
}

#pragma mark - banner广告

-(void)showAd
{
    if ([KKShowadModel sharedShowadModel].shakeAdisShow) {
        XYAdObject *bannerAdObj = [[XYAdBaseManager sharedInstance] getAdWithKey:KeyShake showScene:ADshake];
        self.interstitialAdObj = bannerAdObj;
        [bannerAdObj bannerAdBlock:^(XYAdPlatform adPlatform, FBAdView *fbBannerView, GADBannerView *gadBanner, BOOL isClick, BOOL isLoadSuccess) {
            
            if (adPlatform == XYFacebookAdPlatform) {
                if (isIPhoneX_All) {
                    fbBannerView.frame = CGRectMake(0, kScreenHeight - 180, kScreenWidth, 50);
                }
                else
                {
                    fbBannerView.frame = CGRectMake(0, kScreenHeight - 140, kScreenWidth, 50);
                }
                
                fbBannerView.userInteractionEnabled = isClick;
                [self.view addSubview:fbBannerView];
                
            } else if (adPlatform == XYAdMobPlatform) { // AdMob 广告
                gadBanner.rootViewController = self;
                if (isIPhoneX_All) {
                    gadBanner.adSize = GADAdSizeFromCGSize(CGSizeMake(kScreenWidth, 50));
                    gadBanner.frame = CGRectMake(0, kScreenHeight - 140, kScreenWidth, 50);
                }
                else
                {
                    gadBanner.adSize = GADAdSizeFromCGSize(CGSizeMake(kScreenWidth, 50));
                    gadBanner.frame = CGRectMake(0, kScreenHeight - 140, kScreenWidth, 50);
                }
                gadBanner.userInteractionEnabled = isClick;
                [self.view addSubview:gadBanner];
                
            }
        }];
    }
}

-(void)handleSingleTap
{
    if (self.isCan) {
        [self shaking];
        // 播放声音
        AudioServicesPlaySystemSound(shakingMaleSound);
        // 震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        __weak typeof(self)weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf shankClick];
        });
        self.isCan = NO;
    }
}

#pragma mark - 打点上报

-(void)logManager
{
    [[XYLogManager shareManager] addLogKey1:@"shake" key2:@"show" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
}

#pragma mark - 观察者

/**
 需要支付才能查看详情的时候，重新加载一下摇一摇得到的数据

 @param sender 重新加载一下数据和alertView
 */
-(void)notice:(id)sender{
    
    [self AddAlertViewtoView];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AlertShakenoc object:nil];
}

#pragma mark - 跳转详情

-(void)pushtoRobitClick
{
    [[KKShowsubscribeModel sharedShowsubModel] shakecountClick];
    KKRobitinfoViewController *VC = [KKRobitinfoViewController new];
    VC.type = RobotinfofromShake;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [[XYLogManager shareManager] addLogKey1:@"personal_details" key2:@"show" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:YES];
    VC.model = self.cacheModel;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)AddAlertViewtoView
{
    KKdiscoverAlertView *alertView = [KKdiscoverAlertView new];
    self.isCan = NO;
    NSDictionary *infoDic = [NSDictionary new];
    infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:KKSHAKEMODEL];
    
    NSArray *photopreview = [infoDic objectForKey:@"photopreview"];
    if (photopreview.count!=0) {
        [alertView.coverImg sd_setImageWithURL:[NSURL URLWithString:[photopreview firstObject]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
    }
    alertView.nameLab.text = [infoDic objectForKey:@"name"]?:@"";
    NSString *ageStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"age"]];
    alertView.ageLab.text = ageStr?:@"0";
    alertView.contentLab.text = [infoDic objectForKey:@"signature"]?:@"";
    
    [alertView withSureClick:^(NSString *string) {
        self.isCan = YES;
        if ([KKShowsubscribeModel sharedShowsubModel].shakeCanShow) {
            [self pushtoRobitClick];
        }
        else
        {
            if ([[KKShowsubscribeModel sharedShowsubModel] isNewSub]) {
                [self videoAdClick];
            }
            else
            {
                [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(4)} userInfo:nil upload:YES];
                [self showPaymentViewController];

            }
        }
    }];
    
    [alertView withDismissClick:^(NSString * _Nonnull string) {
        self.isCan = YES;
    }];
}



@end
