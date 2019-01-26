//
//  XTLikedmedbManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/9.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKLikedmedbManager : NSObject
+ (instancetype)sharedClient;


/**
 建表
 */

-(void)firstchoose;


/**
 插入数据

 @param newArray 插入数据
 */
-(void)instrtmymodelWith:(NSMutableArray *)newArray;

/**
 获取数据库中的数据
 */
-(NSMutableArray *)loaddata;


/**
 sayHI

 @param newId 机器人id
 */
- (void)updateDataWithuserId:(NSString *)newId;


/**
 从网络上请求到喜欢我的人的数据信息
 */
-(void)loadDatefromWeb;
@end

NS_ASSUME_NONNULL_END
