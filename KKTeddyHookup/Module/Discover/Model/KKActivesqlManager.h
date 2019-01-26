//
//  XTactivesqlManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/13.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKActivesqlManager : NSObject
@property (nonatomic,strong) NSMutableArray *dataSource;

+ (instancetype)sharedClient;

/**
 建表
 */

-(void)firstchoose;

/**
 插入数据
 */
-(void)instrtmymodel;

/**
 清空数据库内容
 */
-(void)deletefromData;

/**
 读取数据
 
 @return 读取表中数据
 */
-(NSMutableArray *)loaddata;

/**
 sayHI
 
 @param newId 机器人id
 */
- (void)updateDataWithuserId:(NSString *)newId;
@end

NS_ASSUME_NONNULL_END
