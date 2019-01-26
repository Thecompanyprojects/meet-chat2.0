//
//  WJGAFCheckNetManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

//type：0/1/2/3/4/5/6/7/8  0:推荐 1:发现 2:摇一摇 3:漂流瓶 4:活跃的人 5:喜欢我的人 6:个人详情页 7:聊天页面 8:我的

typedef NS_ENUM (NSInteger, checkNetType)   {

    checkNetTypeWithrecommend = 0,
    checkNetTypeWithdiscover = 1,
    checkNetTypeWithshake = 2,
    checkNetTypeWithbottle = 3,
    checkNetTypeWithactive = 4,
    checkNetTypeWithlikedme = 5,
    checkNetTypeWithrobit = 6,
    checkNetTypeWithmassage = 7,
    checkNetTypeWithMe = 8
};

@interface WJGAFCheckNetManager : NSObject
+ (instancetype)shareTools;
-(void)checkNetWithBlock;
@property (nonatomic,assign) checkNetType type;
@end

NS_ASSUME_NONNULL_END
