//
//  ChatSendManager.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKChatSendManager.h"
#import "SqliteManager.h"
#import "KKChatManager.h"

@implementation KKChatSendManager
+ (instancetype)sharedInstance{
    static KKChatSendManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[KKChatSendManager alloc]init];
    });
    return _manager;
}
-(void)senderMessage:(MessageItem *)message withAfterSecond:(NSInteger)second{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        message.chatId = [[NSUUID UUID] UUIDString];
        NSString * sessionId = [NSString stringWithFormat:@"%@_%@",[KKUserModel sharedUserModel].userId,message.userId];
        [[SqliteManager sharedInstance] updateOneChatLogWithType:DBChatType_Private sessionID:sessionId aChatLog:message updateItems:nil complete:^(BOOL success, id obj) {
            NSLog(@"su---%d",success);
            NSLog(@"obj---%@",obj);
            if (success) {
                [self updateChatList:message];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageTab" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageDetail" object:nil userInfo:@{@"data":message}];
            }
        }];
    });
}
-(void)updateChatList:(MessageItem *)msgItem{
    NSString * sessionId = [NSString stringWithFormat:@"%@_list",[NSString stringWithFormat:@"%@",[KKUserModel sharedUserModel].userId]];
    msgItem.chatId = msgItem.userId;
    msgItem.createDate = [NSDate date].timeIntervalSince1970 * 1000;
    [[KKChatManager sharedChatManager] cornerMark:msgItem.userId];
    [[SqliteManager sharedInstance] updateOneChatLogWithType:DBChatType_Private sessionID:sessionId aChatLog:msgItem updateItems:nil complete:^(BOOL success, id obj) {
        NSLog(@"su---%d",success);
        NSLog(@"obj---%@",obj);
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageListLoad" object:nil];
            });
        }
    }];
    [self updateRecieveCount:msgItem];
}
-(void)updateRecieveCount:(MessageItem *)msgItem{
    
    NSString * key = [NSString stringWithFormat:@"%@_recievecount",msgItem.userId];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        NSInteger count = [[[NSUserDefaults standardUserDefaults] objectForKey:key] integerValue];
        count ++;
        [[NSUserDefaults standardUserDefaults] setObject:@(count) forKey:key];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:key];
    }
    
}
@end
