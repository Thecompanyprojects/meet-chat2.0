//
//  XTincentiveManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/12.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKIncentiveManager.h"
#import "KKadvideoModel.h"
#import "KKShowsubscribeModel.h"
#import "XYAdEventManager.h"

@interface KKIncentiveManager()<GADRewardBasedVideoAdDelegate>

@end

@implementation KKIncentiveManager

+ (instancetype)sharedClient {
    static KKIncentiveManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KKIncentiveManager alloc] init];
    });
    return _sharedClient;
}


-(void)loadrewardVideo
{
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    
    switch (self.type) {
        case Subactiveadlike:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_adlike];
            break;
            
        case Subactiveadalive:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_adalive];
            break;
            
        case Subactiveadshake:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_adshake];
            break;
            
        case Subactiveadbottle:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_addrifter];
            break;
            
        case Subactiveadsayhi:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_adsay_hi];
            break;
            
        case SubactiveadgetBottle:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_addrifter];
            break;
        case Subdiscoverunlook:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_discover];
            break;
        case SubactiveadSlideRecall:
            //todo
            [[XYAdBaseManager sharedInstance] loadAdWithKey:INTER_ADKEY scene:Inter_sliderecall];
            break;
        default:
            break;
    }
}

//关闭视频

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    [XYAdEventManager addAdCloseLogWithPlatform:XYAdMobPlatform adType:XYAdRewardedVideoType placementId:@"" upload:YES];
    NSNotification *notification = [NSNotification notificationWithName:AlertShakenoc object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//视频观看完成
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward
{
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
    reward.type,
    [reward.amount doubleValue]];
    
    NSLog(@"%@", rewardMessage);
    switch (self.type) {
        case Subactiveadlike:
        {
            NSString *numStr = [KKadvideoModel sharedadVideoModel].advideo_addlike_number;
            
//            int num = [numStr intValue];
//            NSString *newStr = [[NSUserDefaults standardUserDefaults] objectForKey:ADDlikedNumber];
//            int nums = [newStr intValue]+num;
//            NSString *keyNum = [NSString stringWithFormat:@"%d",nums];
            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDlikedNumber];
            
            NSString *newDay = [TimerGet getNowTimer];
            [[NSUserDefaults standardUserDefaults] setObject:newDay forKey:AddlivedDay];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[KKShowsubscribeModel sharedShowsubModel].like forKey:likedNumber];

        }
        
            break;
        case Subactiveadalive:
        {
            NSString *numStr = [KKadvideoModel sharedadVideoModel].advideo_addalive_number;
            
//            int num = [numStr intValue];
//            NSString *newStr = [[NSUserDefaults standardUserDefaults] objectForKey:ADDactiveNumber];
//            int nums = [newStr intValue]+num;
//            NSString *keyNum = [NSString stringWithFormat:@"%d",nums];
            
            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDactiveNumber];
            
            NSString *newDay = [TimerGet getNowTimer];
            [[NSUserDefaults standardUserDefaults] setObject:newDay forKey:AddactiveDay];
            
            [[NSUserDefaults standardUserDefaults] setObject:[KKShowsubscribeModel sharedShowsubModel].alive_refresh forKey:activeNumber];
        }
            
            break;
            
        case Subactiveadshake:
        {
            NSNotification *notification = [NSNotification notificationWithName:AlertShakenoc object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            NSString *numStr = [KKadvideoModel sharedadVideoModel].advideo_addshake_number;
            
//            int num = [numStr intValue];
//            NSString *newStr = [[NSUserDefaults standardUserDefaults] objectForKey:ADDshakeNumber];
//            int nums = [newStr intValue]+num;
//            NSString *keyNum = [NSString stringWithFormat:@"%d",nums];
            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDshakeNumber];
            
            NSString *newDay = [TimerGet getNowTimer];
            [[NSUserDefaults standardUserDefaults] setObject:newDay forKey:AddshakeDay];
            

            [[NSUserDefaults standardUserDefaults] setObject:[KKShowsubscribeModel sharedShowsubModel].shake forKey:shakeNumber];
        }
            break;
            
        case Subactiveadbottle:
        {
            NSString *numStr = [KKadvideoModel sharedadVideoModel].advideo_addbottle_number;
            
//            int num = [numStr intValue];
//            NSString *newStr = [[NSUserDefaults standardUserDefaults] objectForKey:ADDsetbottleNumber];
//            int nums = [newStr intValue]+num;
//            NSString *keyNum = [NSString stringWithFormat:@"%d",nums];
            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDsetbottleNumber];
            
            NSString *newDay = [TimerGet getNowTimer];
            [[NSUserDefaults standardUserDefaults] setObject:newDay forKey:AddsetbottleDay];
            
            
            
//            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDsetbottleNumber];
            [[NSUserDefaults standardUserDefaults] setObject:[KKShowsubscribeModel sharedShowsubModel].drifter_throw forKey:bottlesetNumber];
        }
         
            break;
            
        case Subactiveadsayhi:
        {
            NSString *numStr = [KKadvideoModel sharedadVideoModel].advideo_addsaihi_number;
            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDsayhiNumber];
        }
            
            break;
        case SubactiveadgetBottle:
        {
            NSString *numStr = [KKadvideoModel sharedadVideoModel].advideo_adgetbottle_number;
//            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDgetbottleNumber];
            
//            int num = [numStr intValue];
//            NSString *newStr = [[NSUserDefaults standardUserDefaults] objectForKey:ADDgetbottleNumber];
//            int nums = [newStr intValue]+num;
//            NSString *keyNum = [NSString stringWithFormat:@"%d",nums];
            [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:ADDgetbottleNumber];
            
            NSString *newDay = [TimerGet getNowTimer];
            [[NSUserDefaults standardUserDefaults] setObject:newDay forKey:AddgetbottleDay];
            
            [[NSUserDefaults standardUserDefaults] setObject:[KKShowsubscribeModel sharedShowsubModel].drifter_reply forKey:bottlegetNumber];
        }
            break;
        case Subdiscoverunlook:
        {
            if (self.returnClick) {
                self.returnClick([NSString new]);
            }
        }
            break;
        case SubactiveadSlideRecall:
        {
            [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:AddsliderRecallNumber];
        }
            break;
        default:
            break;
    }
}

/**
 收到广告内容
 
 @param rewardBasedVideoAd 收到广告内容
 */
- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
    [[XYLogManager shareManager] addLogKey1:@"video" key2:@"watch" content:@{@"type":@"0"} userInfo:[NSDictionary new] upload:YES];
    [XYAdEventManager addAdShowLogWithPlatform:XYAdMobPlatform adType:XYAdRewardedVideoType placementId:@"" upload:YES];
    [XYAdEventManager addAdRequestSuccessLogWithPlatform:XYAdMobPlatform adType:XYAdRewardedVideoType placementId:@"" upload:YES];
    if (self.sureClick) {
        self.sureClick([NSString new]);
    }
}

/**
 广告加载失败
 
 @param rewardBasedVideoAd 广告加载失败
 @param error 失败原因
 */
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
    [self loadrewardVideo];
    [XYAdEventManager addAdRequestFailedLogWithPlatform:XYAdMobPlatform adType:XYAdRewardedVideoType placementId:@"" errorCode:[NSString stringWithFormat:@"%@",error] errorMessage:error.localizedDescription.description upload:YES];
    [[XYLogManager shareManager] addLogKey1:@"video" key2:@"watch" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
}

-(void)withSurevideoClick:(surevideoBlock)block
{

    _sureClick = block;
}

-(void)withReturnvideoClick:(returndisBlock)block
{
    _returnClick = block;
}

@end
