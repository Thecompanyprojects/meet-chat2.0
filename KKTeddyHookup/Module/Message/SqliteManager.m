//
//  DataManager.m
//  FMDBDemo
//
//  Created by YHIOS002 on 16/11/2.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "SqliteManager.h"


@implementation CreatTable


@end

@interface SqliteManager()


@end


@implementation SqliteManager


//设置App数据库
- (void)setupAppDB
{
    
    //判断本地有没有数据库文件
    if ([self _isExistFileAtPath:YHChatLogDir]) {
        //如果存在,那么获取DB版本信息
        int dbVersion = [self _getDbVersion];
        if (dbVersion < 1) {
            [self setDBVersion:1];
        }
        
    }
    
}

+ (instancetype)sharedInstance{
    static SqliteManager *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[SqliteManager alloc] init];
        
    });
    return g_instance;
    
}

#pragma mark - Lazy Load

- (NSMutableArray<CreatTable *> *)chatLogArray{
    if (!_chatLogArray) {
        _chatLogArray = [NSMutableArray new];
    }
    return _chatLogArray;
}

- (NSMutableArray<CreatTable *> *)officeFileArray{
    if (!_officeFileArray) {
        _officeFileArray = [NSMutableArray new];
    }
    return _officeFileArray;
}

#pragma mark - Private 聊天
//初始化聊天FMDBQueue
- (CreatTable *)_setupDBqueueWithType:(DBChatType)type sessionID:(NSString *)sessionID{
    
    if (!sessionID) {
        return nil;
    }
    //是否已存在Queue
    for (CreatTable *model in self.chatLogArray) {
        NSString *aID = model.Id;
        if ([aID isEqualToString:sessionID]) {
            
#ifdef DEBUG
            NSString *dir = nil;
            switch (type) {
                case DBChatType_Group:
                    dir = GroupChatLogDir;
                    break;
                case DBChatType_Private:
                    dir = PriChatLogDir;
                    break;
                default:
                    break;
            }
            
            NSString *pathLog = pathLogWithDir(dir, sessionID);
            NSLog(@"-----数据库操作路径------\n%@",pathLog);
#else
            
#endif
            return model;
            break;
        }
    }
    
    //没有就创建聊天表
    return [self creatChatLogTableWithType:type sessionID:sessionID];
    
}

//第一次建聊天表
- (CreatTable *)_firstCreatChatLogQueueWithType:(DBChatType)type sessionID:(NSString *)sessionID{
    
    NSString *dir = nil;
    switch (type) {
        case DBChatType_Group:{
            dir = GroupChatLogDir;
        }
            break;
        case DBChatType_Private:{
            dir = PriChatLogDir;
        }
            
        default:
            break;
    }
    
    NSString *pathLog = pathLogWithDir(dir, sessionID);
    NSFileManager *fileM = [NSFileManager defaultManager];
    if(![fileM fileExistsAtPath:dir]){
        //如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
        if (![fileM fileExistsAtPath:YHUserDir]) {
            [fileM createDirectoryAtPath:YHUserDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![fileM fileExistsAtPath:YHChatLogDir]){
            [fileM createDirectoryAtPath:YHChatLogDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![fileM fileExistsAtPath:dir]){
            [fileM createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    NSLog(@"-----数据库操作路径------\n%@",pathLog);
    
    CreatTable *model = [[CreatTable alloc] init];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:pathLog];
    
    if (queue) {
        
        //存ID和队列
        model.Id = sessionID;
        model.queue = queue;
        
        
        //存SQL语句
        NSString *tableName = tableNameChatLog(sessionID);
        NSString *creatTableSql = [MessageItem yh_sqlForCreatTable:tableName primaryKey:@"id"];
        if (creatTableSql) {
            model.sqlCreatTable = @[creatTableSql];
        }
        
        [self.chatLogArray addObject:model];
    }
    return model;
}


//退出登录清除缓存
- (void)clearCacheWhenLogout{
   
    [self.chatLogArray removeAllObjects];
    [[NSFileManager defaultManager] removeItemAtPath:YHUserDir error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:YHVisitorsDir error:nil];
}


#pragma mark - 聊天
//建聊天表
- (CreatTable *)creatChatLogTableWithType:(DBChatType)type sessionID:(NSString *)sessionID{
    
    CreatTable *model = [self _firstCreatChatLogQueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model.queue;
    NSString *sql = model.sqlCreatTable.lastObject;
    [queue inDatabase:^(FMDatabase *db) {
        
        BOOL ok = [db executeUpdate:sql];
        if (ok == NO) {
            NSLog(@"----NO:%@---",sql);
        }
        
    }];
    return model;
}

//更新多条聊天信息
- (void)updateChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID chatLogList:(NSArray <MessageItem *>*)chatLogList complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model.queue;
    
    NSString *tableName = tableNameChatLog(sessionID);
    for (int i= 0; i< chatLogList.count; i++) {
        
        MessageItem *model = chatLogList[i];
        
        [queue inDatabase:^(FMDatabase *db) {
            /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
            [db yh_saveDataWithTable:tableName model:model userInfo:nil otherSQL:nil option:^(BOOL save) {
                if (i == chatLogList.count-1) {
                    complete(save,nil);
                }else{
                    if (!save) {
                        complete(save,@"更新某条数据失败");
                    }
                }
                
            }];
            
        }];
    }
    
    
}

//更新某条聊天信息
- (void)updateOneChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID aChatLog:(MessageItem*)aChatLog updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model.queue;
    
    NSDictionary *otherSQL = nil;
    if (updateItems) {
        otherSQL = @{YHUpdateItemKey:updateItems};
    }
    
    [queue inDatabase:^(FMDatabase *db) {
        /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
        [db yh_saveDataWithTable:tableNameChatLog(sessionID)  model:aChatLog userInfo:nil otherSQL:otherSQL option:^(BOOL save) {
            complete(save,nil);
        }];
        
    }];
}

//查询ChatLog表
- (void)queryChatLogTableWithType:(DBChatType)type sessionID:(NSString *)sessionID userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model.queue;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDatasWithTable:tableNameChatLog(sessionID) model:[MessageItem new] userInfo:userInfo fuzzyUserInfo:fuzzyUserInfo otherSQL:nil option:^(NSMutableArray *models) {
            complete(YES,models);
        }];
    }];
}


//查询多条聊天信息
- (void)queryChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID list:(NSArray<MessageItem *>*)chatLogList complete:(void (^)(BOOL, id))complete{
    
    CreatTable *model = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model.queue;
    
    __block NSMutableArray *maRet = [NSMutableArray new];
    for (MessageItem *model in chatLogList) {
        [queue inDatabase:^(FMDatabase *db) {
            [db yh_excuteDataWithTable:tableNameChatLog(sessionID) model:model userInfo:nil fuzzyUserInfo:nil otherSQL:nil option:^(id output_model) {
                if (output_model) {
                    [maRet addObject:output_model];
                }
            }];
        }];
    }
    complete(YES,maRet);
    
}

//查询一条聊天信息
- (void)queryaChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID aChatLog:(MessageItem *)aChatLog userInfo:(NSDictionary *)userInfo complete:(void (^)(BOOL, id))complete{
    
    CreatTable *model = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model.queue;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDataWithTable:tableNameChatLog(sessionID) model:aChatLog userInfo:userInfo fuzzyUserInfo:nil otherSQL:nil option:^(id output_model) {
            complete(YES,output_model);
        }];
        
    }];
}

//删除聊天信息数组
- (void)deleteChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID list:(NSArray <MessageItem *>*)chatLogList complete:(void(^)(BOOL success,id obj))complete;{
    
    CreatTable *model1 = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model1.queue;
    
    for (MessageItem *model in chatLogList) {
        [queue inDatabase:^(FMDatabase *db) {
            [db yh_deleteDataWithTable:tableNameChatLog(sessionID) model:model userInfo:nil otherSQL:nil option:^(BOOL del) {
            }];
        }];
    }
    
}

//删除某条消息记录
- (void)deleteOneChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID msgID:(NSString *)msgID complete:(void(^)(BOOL success,id obj))complete{
    
    if (!msgID) {
        complete(NO,@"msgID is nil");
        return;
    }
    
    CreatTable *cmodel     = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = cmodel.queue;
    MessageItem *model = [MessageItem new];
    model.chatId       = msgID;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_deleteDataWithTable:tableNameChatLog(sessionID) model:model userInfo:nil otherSQL:nil option:^(BOOL del) {
            complete(del,nil);
        }
         ];
    }];
}

//删除ChatLog表
- (void)deleteChatLogTableWithType:(DBChatType)type sessionID:(NSString *)sessionID complete:(void(^)(BOOL success,id obj))complete{
    
    switch (type) {
        case DBChatType_Group:{
            
            NSString *pathLog = pathLogWithDir(GroupChatLogDir, sessionID);
            BOOL success = [self _deleteFileAtPath:pathLog];
            if (success) {
                
                for (CreatTable *model in self.chatLogArray) {
                    NSString *aID = model.Id;
                    if ([aID isEqualToString:sessionID]) {
                        [self.chatLogArray removeObject:model];
                        break;
                    }
                }
                
            }
            complete(success,nil);
        }
            break;
        case DBChatType_Private:{
            
            NSString *pathLog = pathLogWithDir(PriChatLogDir, sessionID);
            BOOL success = [self _deleteFileAtPath:pathLog];
            if (success) {
                
                for (CreatTable *model in self.chatLogArray) {
                    NSString *aID = model.Id;
                    if ([aID isEqualToString:sessionID]) {
                        [self.chatLogArray removeObject:model];
                        break;
                    }
                }
            }
            complete(success,nil);
            
        }
            
        default:
            break;
    }
    
    
    
}

//删除某一聊天信息
- (void)deleteaChatLogWithType:(DBChatType)type sessionID:(NSString *)sessionID aChatLog:(MessageItem *)aChatLog userInfo:(NSDictionary *)userInfo complete:(void(^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self _setupDBqueueWithType:type sessionID:sessionID];
    FMDatabaseQueue *queue = model.queue;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_deleteDataWithTable:tableNameChatLog(sessionID) model:aChatLog userInfo:userInfo otherSQL:nil option:^(BOOL del) {
            complete(del,@(del));
        }];
    }];
}


#pragma mark - 聊天文件
//更新聊天文件

#pragma mark - filePrivate
- (BOOL)_deleteFileAtPath:(NSString *)filePath{
    if (!filePath || filePath.length == 0) {
        return NO;
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"delete file error, %@ is not exist!", filePath);
        return NO;
    }
    NSError *removeErr = nil;
    if (![[NSFileManager defaultManager] removeItemAtPath:filePath error:&removeErr] ) {
        NSLog(@"delete file failed! %@", removeErr);
        return NO;
    }
    return YES;
}

- (BOOL)_isExistFileAtPath:(NSString *)filePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@" %@ is not exist!", filePath);
        return NO;
    }
    return YES;
}

- (int)_getDbVersion {
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:kDatabaseVersionKey];
}

- (void)setDBVersion:(int)version{
    [[NSUserDefaults standardUserDefaults] setInteger:version forKey:kDatabaseVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)updateTableDField:(NSArray *)updates WithType:(DBChatType)type sessionID:(NSString *)sessionID{
    
    CreatTable *model = [self _setupDBqueueWithType:type sessionID:sessionID];
    NSString * tableName = [NSString stringWithFormat:@"yh_%@",sessionID];
    FMDatabaseQueue *queue = model.queue;
    [queue inDatabase:^(FMDatabase *db) {
    //判断表是否存在
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?",tableName];
        BOOL isExit = NO;
        while ([rs next])
        {
            // just print out what we've got in a number of formats.
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count)
            {
                isExit = NO;
            }
            else
            {
                isExit = YES;
            }
        }
    
        if (isExit) {
            for (NSString * name in updates) {
                if (![db columnExists:name inTableWithName:tableName]){
                    NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ text",tableName,name];
                    BOOL worked = [db executeUpdate:alertStr];
                    if(worked){
                        NSLog(@"插入成功");
                    }else{
                        NSLog(@"插入失败");
                    }
                }
            }
        }
        [db close];
        
    }];
}

@end
