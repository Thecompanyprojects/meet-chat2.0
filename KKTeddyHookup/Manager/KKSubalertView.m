//
//  XTSubalertView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/8.
//  Copyright © 2018 KK. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define MARGIN  30


#import "KKSubalertView.h"
#import "KKIncentiveManager.h"
#import "XYAdEventManager.h"

@interface KKSubalertView()
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIImageView *logoImg;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIButton *videoBtn;
@property (nonatomic,strong) UIButton *subBtn;
@end

@implementation KKSubalertView

- (instancetype)initWithFrame:(CGRect)frame
{
    /*下面代码的作用让视图没关闭之前只创建一次*/
    BOOL isHas = NO;
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[KKSubalertView class]]) {
            isHas = YES;
            break;
        }
    }
    if (isHas) {
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor greenColor];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.frame = CGRectMake(MARGIN, (HEIGHT - 282.0)/2.0, WIDTH-(MARGIN * 2.0), 282.0);
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.logoImg];
        [self.alertView addSubview:self.contentLab];
        [self.alertView addSubview:self.videoBtn];
        [self.alertView addSubview:self.subBtn];
        [self setuplayout];
        
        [self showAnimation];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    [weakSelf.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.alertView).with.offset(15);
        make.centerX.equalTo(weakSelf.alertView);
        make.width.mas_offset(198);
        make.height.mas_offset(142);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.logoImg.mas_bottom).with.offset(12);
       // make.height.mas_offset(30);
        make.left.equalTo(weakSelf.alertView).with.offset(30*KWIDTH);
    }];
    [weakSelf.videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(108*KWIDTH);
        make.height.mas_offset(36);
        make.left.equalTo(weakSelf.contentLab);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(16);
    }];
    [weakSelf.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(108*KWIDTH);
        make.height.mas_offset(36);
        make.right.equalTo(weakSelf.contentLab);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(16);
    }];
}

#pragma mark - getters

-(UIView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[UIView alloc] init];
        _alertView.layer.cornerRadius=5.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
    }
    return _alertView;
}

-(UIImageView *)logoImg
{
    if(!_logoImg)
    {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"没有权限"];
    }
    return _logoImg;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = [UIFont systemFontOfSize:12];
        _contentLab.numberOfLines = 0;
        _contentLab.backgroundColor = [UIColor whiteColor];
        _contentLab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.text = @"The authority has been used up today \n Please increase your permi";
    }
    return _contentLab;
}

-(UIButton *)videoBtn
{
    if(!_videoBtn)
    {
        _videoBtn = [[UIButton alloc] init];
        [_videoBtn setTitle:@"Video" forState:normal];
        [_videoBtn setImage:[UIImage imageNamed:@"LeftVideobtn"] forState:normal];
        [_videoBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
        _videoBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_videoBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _videoBtn.backgroundColor = MainColor;
        _videoBtn.layer.masksToBounds = YES;
        _videoBtn.layer.cornerRadius = 18;
        [_videoBtn addTarget:self action:@selector(videobtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoBtn;
}

-(UIButton *)subBtn
{
    if(!_subBtn)
    {
        _subBtn = [[UIButton alloc] init];
        [_subBtn setTitle:@"Subscrib" forState:normal];
        _subBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_subBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _subBtn.backgroundColor = MainColor;
        _subBtn.layer.masksToBounds = YES;
        _subBtn.layer.cornerRadius = 18;
        [_subBtn addTarget:self action:@selector(subbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}

#pragma mark - 实现方法

-(void)showAnimation{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.65 initialSpringVelocity:30 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        self.alertView.transform = CGAffineTransformIdentity;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - 埋点统计

-(void)logmanager
{
    switch (self.alertType) {
        case Alertadlike:
            [[XYLogManager shareManager] addLogKey1:@"win" key2:@"show_win" content:@{@"type":@"0"} userInfo:[NSDictionary new] upload:YES];
            break;
        case Alertadalive:
            [[XYLogManager shareManager] addLogKey1:@"win" key2:@"show_win" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
            break;
        case Alertadsayhi:
            [[XYLogManager shareManager] addLogKey1:@"win" key2:@"show_win" content:@{@"type":@"2"} userInfo:[NSDictionary new] upload:YES];
            break;
        case Alertadshake:
            [[XYLogManager shareManager] addLogKey1:@"win" key2:@"show_win" content:@{@"type":@"3"} userInfo:[NSDictionary new] upload:YES];
            break;
        case Alertadbottle:
            [[XYLogManager shareManager] addLogKey1:@"win" key2:@"show_win" content:@{@"type":@"4"} userInfo:[NSDictionary new] upload:YES];
            break;
        case Alertadgetbottle:
            [[XYLogManager shareManager] addLogKey1:@"win" key2:@"show_win" content:@{@"type":@"4"} userInfo:[NSDictionary new] upload:YES];
            break;
        case AlertwithLikeRecall:
            [[XYLogManager shareManager] addLogKey1:@"win" key2:@"show_win" content:@{@"type":@"5"} userInfo:[NSDictionary new] upload:YES];
            break;
        default:
            break;
    }
}

-(void)videobtnClick
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == -1) {
            [SVProgressHUD showInfoWithStatus:@"Please check your network"];
            NSLog(@"未识别网络");
        }
        if (status == 0) {
            [SVProgressHUD showInfoWithStatus:@"Please check your network"];
            NSLog(@"未连接网络");
        }
        if (status == 1) {
            
            NSLog(@"3G/4G网络");
            [self chooseVideo];
        }
        if (status == 2) {
            
            NSLog(@"Wifi网络");
            [self chooseVideo];
        }
    }];

}


-(void)chooseVideo
{
    
    [[XYLogManager shareManager] addLogKey1:@"btn" key2:@"click" content:@{@"type":@"0"} userInfo:[NSDictionary new] upload:YES];
    [XYAdEventManager addAdRequestBeganLogWithPlatform:XYAdMobPlatform adType:XYAdRewardedVideoType placementId:@"" upload:YES];
    [XYLoadingHUD show];
    switch (self.alertType) {
        case Alertadlike:
            [KKIncentiveManager sharedClient].type = Subactiveadlike;
            break;
        case Alertadshake:
            [KKIncentiveManager sharedClient].type = Subactiveadshake;
            break;
        case Alertadalive:
            [KKIncentiveManager sharedClient].type = Subactiveadalive;
            break;
        case Alertadsayhi:
            [KKIncentiveManager sharedClient].type = Subactiveadsayhi;
            break;
        case Alertadbottle:
            [KKIncentiveManager sharedClient].type = Subactiveadbottle;
            break;
        case Alertadgetbottle:
            [KKIncentiveManager sharedClient].type = SubactiveadgetBottle;
            break;
        case AlertwithRobit:
            [KKIncentiveManager sharedClient].type = Subdiscoverunlook;
            break;
        case AlertwithLikeRecall:
            [KKIncentiveManager sharedClient].type = SubactiveadSlideRecall;
            break;
        default:
            break;
    }
    
    [[KKIncentiveManager sharedClient] loadrewardVideo];
    [[KKIncentiveManager sharedClient] withSurevideoClick:^(NSString * _Nonnull string) {
        if (self.sureClick) {
            self.sureClick([NSString new]);
        }
    }];
    [[KKIncentiveManager sharedClient] withReturnvideoClick:^(NSString * _Nonnull string) {
        if (self.returnTextBlock) {
            self.returnTextBlock([NSString new]);
        }
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)subbtnClick
{
    [[XYLogManager shareManager] addLogKey1:@"btn" key2:@"click" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];

    if (self.subchooseClick) {
        self.subchooseClick([NSString new]);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)withSurevideoClick:(surevideoBlock)block
{
    _sureClick = block;
    
}

-(void)withSubchooseClick:(subchooseBlock)block
{
    _subchooseClick = block;
}

- (void)returnText:(ReturnTextBlock)block
{
    self.returnTextBlock = block;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [XYLoadingHUD dismiss];
    UITouch * touch = touches.anyObject;
    if ([touch.view isMemberOfClass:[self.alertView class]]||[touch.view isMemberOfClass:[self.logoImg class]]||[touch.view isMemberOfClass:[self.contentLab class]]||[touch.view isMemberOfClass:[self.subBtn class]]||[touch.view isMemberOfClass:[self.videoBtn class]]) {
        
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self removeFromSuperview];
        }];
    }
    [[XYLogManager shareManager] addLogKey1:@"btn" key2:@"click" content:@{@"type":@"2"} userInfo:[NSDictionary new] upload:YES];
}


@end
