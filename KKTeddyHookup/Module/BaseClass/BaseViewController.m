//
//  BaseViewController.m
//  XToolWhiteNoiseIOS
//
//  Created by PanZhi on 2018/7/25.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "BaseViewController.h"
#import <SafariServices/SafariServices.h>
#import "KKShowadModel.h"

typedef NS_ENUM (NSInteger, SubAdwhthType)   {
    
    SubvideoAdwithlike = 0,
    SubvideoAdwithalive = 1,
    SubvideoAdwithshake = 2,
    SubvideoAdwithbottle = 3,
    SubvideoAdwithsayhi = 4,
    SubvideoAdwithgetBottle = 5,
    SubvideoAdwithLikeRecall = 6  //喜欢撤回
};


@interface BaseViewController ()
@property (nonatomic,assign) SubAdwhthType videoType;
@property (nonatomic, strong) XYAdObject *interstitialAdObj; /**< 插屏广告对象 */
@end

@implementation BaseViewController

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setBackButtonItemText:NSLocalizedString(@"Back", nil)];
   
}

#pragma mark - 设置下一页的返回按钮样式
- (void)setBackButtonItemText:(NSString *)text {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    [backButton setTitle:text];
    self.navigationItem.backBarButtonItem = backButton;
}

#pragma mark - 将控制器从导航堆栈中移除
- (void)removeFromNavigationStack {
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arrM removeObject:self];
    self.navigationController.viewControllers = arrM;
}

#pragma mark - 打开一个网页
- (void)pushWebViewController:(NSString *)url {
    SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:safariController animated:YES completion:nil];
}

#pragma mark - 是否允许侧滑返回
- (BOOL)backToPreviousByGesture {
    return YES;
}
#pragma mark 插屏广告
-(void)showAdViewControllerKey:(NSString *)getkey scene:(NSString*)getscene withloadsence:(NSString *)loadsence{
    NSString *alive = [KKShowadModel sharedShowadModel].alive;
    //MARK - 插屏广告
    [KKShowadModel sharedShowadModel].newalive = [KKShowadModel sharedShowadModel].newalive+1;
    NSInteger intalive = [alive integerValue];
    if (intalive!=0) {
        
        XYAdObject *obj = [[XYAdBaseManager sharedInstance] getAdWithKey:getkey showScene:getscene];
        
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


#pragma mark - 弹出订阅
- (void)showPaymentViewController {
    
    if (![KKUserModel sharedUserModel].isVip) {
        KKPaymentViewController *paymentController = [[KKPaymentViewController alloc] init];
        BaseNavigationController *paymentNavController = [[BaseNavigationController alloc] initWithRootViewController:paymentController];
        [self presentViewController:paymentNavController animated:YES completion:nil];
    }
}

/**
 Active部分弹出激励视频
 */
-(void)adVideowithActive
{
  
    self.videoType = SubvideoAdwithalive;
    [self videoAdwhthView];
}


/**
 Sayhi部分弹出激励视频
 */
-(void)adVideowithSayhi
{
   
    self.videoType = SubvideoAdwithsayhi;
    [self videoAdwhthView];
}

/**
 滑动喜欢 弹出激励视频
 */
-(void)adVideowithlike
{
    
    self.videoType = SubvideoAdwithlike;
    [self videoAdwhthView];
}

/**
 滑动撤回 弹出激励视频
 */
-(void)adVideowithSlideCRecall
{
    
    self.videoType = SubvideoAdwithLikeRecall;
    [self videoAdwhthView];
}

/**
 扔漂流瓶  弹出激励视频
 */
-(void)adVideowithbottle
{
    
    self.videoType = SubvideoAdwithbottle;
    [self videoAdwhthView];
}


/**
 捡漂流瓶 弹出激励视频
 */
-(void)adVideowithgetbottle
{
   
    self.videoType = SubvideoAdwithgetBottle;
    [self videoAdwhthView];
}


/**
 摇一摇 弹出激励视频
 */
-(void)adVideowithshake
{
   
    self.videoType = SubvideoAdwithshake;
    [self videoAdwhthView];
}




#pragma mark - 弹出激励视频选择项目

-(void)videoAdwhthView
{
    if (![KKUserModel sharedUserModel].isVip) {
        KKSubalertView *alert = [[KKSubalertView alloc] init];
        
        switch (self.videoType) {
            case SubvideoAdwithlike:
                alert.alertType = Alertadlike;
                break;
            case SubvideoAdwithalive:
                alert.alertType = Alertadalive;
                break;
            case SubvideoAdwithbottle:
                alert.alertType = Alertadbottle;
                break;
            case SubvideoAdwithsayhi:
                alert.alertType = Alertadsayhi;
                break;
            case SubvideoAdwithshake:
                alert.alertType = Alertadshake;
                break;
            case SubvideoAdwithgetBottle:
                alert.alertType = Alertadgetbottle;
                break;
            case SubvideoAdwithLikeRecall:
                alert.alertType = AlertwithLikeRecall;
                break;
            default:
                break;
        }
        
        [alert withSubchooseClick:^(NSString * _Nonnull string) {
            //直接购买
            [[KKPayManager sharedClient] addpay];
            [[TTPaymentManager shareInstance] paymentDirect];
            [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(7)} userInfo:[NSDictionary new] upload:YES];
        }];
        [alert withSurevideoClick:^(NSString * _Nonnull string) {
            //弹出激励视频 观看视频
            [XYLoadingHUD dismiss];
            [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
        }];
        
        [alert returnText:^(NSString * _Nonnull showText) {
            
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 是否需要上传头像

-(BOOL)isshouldUpload
{
    KKUserModel *useModel = [KKUserModel sharedUserModel];
    useModel.userphotos = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphoto"];
    if (useModel.userphotos.count==0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
}

#pragma mark - 一张照片上传

-(void)UploadthePhoto
{
    KKPhotoView *alertView = [KKPhotoView new];
    [alertView withrepylClick:^(NSString *string) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.oKButtonTitleColorNormal = [UIColor whiteColor];
        imagePickerVc.barItemTextColor = [UIColor blackColor];
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowCameraLocation = NO;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (photos.count!=0) {
                
                [[APIResult sharedClient] replyImgfrom:[photos firstObject]];
            }
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }];
}

#pragma mark - 导航栏下面的那条线消失

-(void)delNavLine
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list)
        {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view = (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }
        }
    }
}



@end
