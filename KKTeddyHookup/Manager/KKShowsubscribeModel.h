//
//  XTShowsubscribeModel.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKShowsubscribeModel : NSObject
@property (nonatomic , copy) NSString              * chat_robot_reply;//机器人回复  第一条消息不可见
@property (nonatomic , copy) NSString              * drifter_throw;//漂流瓶 扔出去瓶子次数 5次
@property (nonatomic , copy) NSString              * shake;//摇一摇 大于等于5次 查看详情
@property (nonatomic , copy) NSString              * chat_send;//发送消息超过5条
@property (nonatomic , copy) NSString              * like;// 滑动喜欢  大于等于5次
@property (nonatomic , copy) NSString              * drifter_reply;// 捡起来瓶子  5次
@property (nonatomic , copy) NSString              * alive_refresh;//刷新活跃的人
@property (nonatomic , copy) NSString              * video;//观看视频
@property (nonatomic , copy) NSString              * like_me;// 喜欢我的人
@property (nonatomic , copy) NSString              * discover_user_count;// 用户显示数量
@property (nonatomic , copy) NSString              * say_hi;// sayhi

@property (nonatomic , copy) NSString              * subscribe_day; //天数  

@property (nonatomic , assign) NSInteger              newchat_robot_reply;//机器人回复  第一条消息不可见
@property (nonatomic , assign) NSInteger              newdrifter_throw;//漂流瓶 扔出去瓶子次数 5次
@property (nonatomic , assign) NSInteger              newshake;//摇一摇 大于等于5次 查看详情
@property (nonatomic , assign) NSInteger              newchat_send;//发送消息超过5条
@property (nonatomic , assign) NSInteger              newlike;// 滑动喜欢  大于等于5次
@property (nonatomic , assign) NSInteger              newdrifter_reply;// 捡起来瓶子  5次
@property (nonatomic , assign) NSInteger              newalive_refresh;//刷新活跃的人
@property (nonatomic , assign) NSInteger              newvideo;//观看视频
@property (nonatomic , assign) NSInteger              newlike_me;// 喜欢我的人
@property (nonatomic , assign) NSInteger              newdiscover_user_count;// 用户显示数量
@property (nonatomic , assign) NSInteger              newsay_hi;// sayhi

+ (instancetype)sharedShowsubModel;


/**
 喜欢
 
 @return 喜欢 滑动判断
 */
-(BOOL)likedCanShow;


/**
 判断sayhi次数

 @return 判断sayhi次数
 */
-(BOOL)sayhinumberClick;



/**
 捡瓶子
 
 @return 捡瓶子次数判断
 */
-(BOOL)getbottleCanShow;


/**
 扔瓶子
 
 @return 扔瓶子次数判断
 */
-(BOOL)putbottleCanShow;



/**
 活跃的人
 
 @return 刷新次数判断
 */
-(BOOL)activepeopleCanShow;



/**
 摇一摇
 
 @return 摇一摇次数判断
 */
-(BOOL)shakeCanShow;


/**
 Say_hi number
 */
-(void)addSayhiNumberClick;


/**
 Active refresh number
 */
-(void)addrefreshActivePeopleClick;


/**
 摇一摇 Number
 */
-(void)shakecountClick;

/**
 捞瓶子 Number
 */
-(void)addGetbottleClick;

/**
 扔瓶子 Number
 */
-(void)addSetbottleClick;


/**
 新的订阅界面
 
 @return 是否选择新的订阅界面
 */
-(BOOL)isNewSub;



/**
 第一次启动
 */
-(void)firstchoose;

/**
 滑动撤回
 */
-(BOOL)slideRecallCanShow;

@end

NS_ASSUME_NONNULL_END

