//
//  XTincentiveManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/12.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^surevideoBlock)(NSString *string);

typedef void (^returndisBlock)(NSString *string);

typedef NS_ENUM (NSInteger, SubactiveType)   {
    Subactiveadlike = 0,
    Subactiveadalive = 1,
    Subactiveadshake = 2,
    Subactiveadbottle = 3,
    Subactiveadsayhi = 4,
    SubactiveadgetBottle = 5,
    Subdiscoverunlook = 6,
    SubactiveadSlideRecall = 7,
};

@interface KKIncentiveManager : NSObject

@property (nonatomic,assign) SubactiveType type;

/**
 广告激励视频
 */
@property(nonatomic,copy)surevideoBlock sureClick;

@property(nonatomic,copy)returndisBlock returnClick;
+ (instancetype)sharedClient;

-(void)loadrewardVideo;

-(void)withSurevideoClick:(surevideoBlock)block;

-(void)withReturnvideoClick:(returndisBlock)block;

@end

NS_ASSUME_NONNULL_END
