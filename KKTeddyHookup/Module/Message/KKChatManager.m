//
//  ChatManager.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKChatManager.h"
#import "SqliteManager.h"

@implementation KKChatManager
+ (instancetype)sharedChatManager{
    static KKChatManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[KKChatManager alloc]init];
    });
    return _manager;
}
-(void)chatSayHi:(NSString *)userId withContent:(NSString *)content withUserName:(NSString *)userName withPhoto:(NSString *)photo{
    MessageItem * item = [[MessageItem alloc]init];
    item.userId = userId;
    item.chatId = item.userId;
    item.userName = userName;
    item.message = content;
    item.photo = photo;
    item.createDate = (long long)[NSDate date].timeIntervalSince1970 * 1000;
    item.sendUserId = [KKUserModel sharedUserModel].userId;
    NSString * sessionId = [NSString stringWithFormat:@"%@_list",[KKUserModel sharedUserModel].userId];
    [[SqliteManager sharedInstance] updateOneChatLogWithType:DBChatType_Private sessionID:sessionId aChatLog:item updateItems:nil complete:^(BOOL success, id obj) {
            NSLog(@"su---%d",success);
            NSLog(@"obj---%@",obj);
    }];
    
    item.userId = [KKUserModel sharedUserModel].userId;
    //消息详情数据库更新
    NSString * sessionId1 = [NSString stringWithFormat:@"%@_%@",[KKUserModel sharedUserModel].userId,userId];
    [[SqliteManager sharedInstance] updateOneChatLogWithType:DBChatType_Private sessionID:sessionId1 aChatLog:item updateItems:nil complete:^(BOOL success, id obj) {
        NSLog(@"su---%d",success);
        NSLog(@"obj---%@",obj);
        
    }];
}
-(void)cornerMark:(NSString *)chatId{
    NSDictionary * cornerMarList =  [[NSUserDefaults standardUserDefaults] objectForKey:@"cornerMarList"];
    if (cornerMarList) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:cornerMarList];
        if ([cornerMarList objectForKey:chatId]) {
            NSInteger count = [[cornerMarList objectForKey:chatId] integerValue];
            [dict setObject:@(count + 1) forKey:chatId];
        }else{
            [dict setObject:@(1) forKey:chatId];
        }
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cornerMarList"];
    }else{
        NSDictionary * dict = @{chatId:@(1)};
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cornerMarList"];
    }
}
-(void)cornerMarkZero:(NSString *)userId{
    if (userId) {
        NSDictionary * cornerMarList =  [[NSUserDefaults standardUserDefaults] objectForKey:@"cornerMarList"];
        if (cornerMarList) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:cornerMarList];
            [dict setObject:@(0) forKey:userId];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cornerMarList"];
        }else{
            NSDictionary * dict = @{userId:@0};
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cornerMarList"];
        }
    }
}
@end
