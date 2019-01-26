//
//  DataManager.h
//  FMDBDemo
//
//  Created by YHIOS002 on 16/11/2.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageItem.h"
#import "FMDB.h"
#import "NSObject+YHDBRuntime.h"
#import "FMDatabase+YHDatabase.h"
#import "YHSqilteConfig.h"

//建表
@interface CreatTable : NSObject

@property (nonatomic,copy) NSString *Id;
@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,copy) NSArray <NSString *> *sqlCreatTable;
@property (nonatomic,assign) int type;

@end

@interface SqliteManager : NSObject


typedef NS_ENUM(int,DBChatType){
    DBChatType_Group = 101, //群聊
    DBChatType_Private      //单聊
};


@property(nonatomic,strong) NSMutableArray < CreatTable *>*chatLogArray; //聊天Array
@property(nonatomic,strong) NSMutableArray <CreatTable *>*officeFileArray;//聊天文件表（暂时只有一个Sql表）

+ (instancetype)sharedInstance;

#pragma mark - 退出登录
/*
 *  退出登录清除缓存
 */
- (void)clearCacheWhenLogout;


#pragma mark - 聊天

/*
 *  更新ChatLog表多条信息
 */
- (void)updateChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID chatLogList:(NSArray <MessageItem *>*)chatLogList complete:(void (^)(BOOL success,id obj))complete;

/*
 *  更新某条聊天信息
 */
- (void)updateOneChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID aChatLog:(MessageItem*)aChatLog updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete;

/*
 *  查询ChatLog表
 *  @param userInfo       条件查询Dict
 *  @param fuzzyUserInfo  模糊查询Dict
 *  @param complete       成功失败回调
 *  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
 */
- (void)queryChatLogTableWithType:(DBChatType)type sessionID:(NSString *)sessionID userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo complete:(void (^)(BOOL success,id obj))complete;

- (void)queryChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID list:(NSArray<MessageItem *>*)chatLogList complete:(void (^)(BOOL, id))complete;

//删除某条消息记录
- (void)deleteOneChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID msgID:(NSString *)msgID complete:(void(^)(BOOL success,id obj))complete;


/*
 *  删除ChatLog表
 */
- (void)deleteChatLogTableWithType:(DBChatType)type sessionID:(NSString *)sessionID complete:(void(^)(BOOL success,id obj))complete;



#pragma mark - filePrivate
/*
 *  删除指定路径文件
 */
- (BOOL)_deleteFileAtPath:(NSString *)filePath;



/*
更新表字段
 */
-(void)updateTableDField:(NSArray *)updates WithType:(DBChatType)type sessionID:(NSString *)sessionID;
@end
