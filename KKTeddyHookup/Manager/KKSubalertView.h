//
//  XTSubalertView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/8.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, AlertactiveType)   {
    Alertadlike = 0,
    Alertadalive = 1,
    Alertadshake = 2,
    Alertadbottle = 3,
    Alertadsayhi = 4,
    Alertadgetbottle = 5,
    AlertwithRobit = 6,
    AlertwithLikeRecall = 7,//喜欢撤回
};


typedef void(^surevideoBlock)(NSString *string);

typedef void(^subchooseBlock)(NSString *string);

typedef void (^ReturnTextBlock)(NSString *showText);

typedef void (^LookVideoBlock)(NSString *Video);

@interface KKSubalertView : UIView

@property(nonatomic,assign) AlertactiveType alertType;

/**
 广告激励视频
 */
@property(nonatomic,copy)surevideoBlock sureClick;


/**
 订阅界面
 */
@property(nonatomic,copy)subchooseBlock subchooseClick;


/**
 激励视频奖励会掉
 */
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
-(void)withSurevideoClick:(surevideoBlock)block;
-(void)withSubchooseClick:(subchooseBlock)block;
-(void)returnText:(ReturnTextBlock)block;

/**
 观看视频完成
 */
@property (nonatomic, copy) LookVideoBlock lookVideoBlock;
@end

NS_ASSUME_NONNULL_END
