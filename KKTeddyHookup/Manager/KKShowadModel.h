//
//  XTShowadModel.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, ShowadType)   {
    Showadwithlike = 0,
    Showadwithsay_hi = 1,
    Showadwithalive = 2,
    Showadwithshake = 3,
    Showadwithdrifter = 4
};

//广告
@interface KKShowadModel : NSObject

@property (nonatomic,assign) ShowadType type;

@property (nonatomic , copy) NSString              * like;// 滑动喜欢  大于等于5次
@property (nonatomic , copy) NSString              * say_hi;// sayhi
@property (nonatomic , copy) NSString              * alive;//活跃的人
@property (nonatomic , copy) NSString              * shake;//摇一摇 大于等于5次 查看详情
@property (nonatomic , copy) NSString              * drifter;//点击漂流瓶 两个操作都有 累计

@property (nonatomic , assign) NSInteger              newdrifter;
@property (nonatomic , assign) NSInteger              newshake;//摇一摇 大于等于5次 查看详情
@property (nonatomic , assign) NSInteger              newsay_hi;// sayhi
@property (nonatomic , assign) NSInteger              newalive;//活跃的人
@property (nonatomic , assign) NSInteger              newlike;

+ (instancetype)sharedShowadModel;


/**
 预加载广告
 */
-(void)loadAdwithType;

/**
 摇一摇广告内容
 
 @return 是否显示摇一摇广告内容
 */
-(BOOL)shakeAdisShow;

/**
 活跃的人广告内容
 
 @return 是否显示活跃的人广告内容
 */
-(BOOL)activeAdisShow;

/**
 漂流瓶广告部分
 
 @return 是否显示漂流瓶部分插屏广告
 */
-(BOOL)drifterADisshow;

/**
 say_hi广告内容
 
 @return 是否显示say_hi广告内容
 */
-(BOOL)sayhiADisshow;
@end

NS_ASSUME_NONNULL_END
