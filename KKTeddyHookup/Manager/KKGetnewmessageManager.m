//
//  XTGetnewmessageManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/23.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKGetnewmessageManager.h"
#import "KKChatSendManager.h"
#import <UserNotifications/UserNotifications.h>


@implementation KKGetnewmessageManager

+ (instancetype)sharedClient {
    static KKGetnewmessageManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KKGetnewmessageManager alloc] init];
        
    });
    return _sharedClient;
}

//启动时：每隔X分钟有Y%概率推出一次提示。每隔一段时间去做随机概率，如果命中概率，则提示有人向你发送消息，反之则不显示。X分钟,Y概率可控。

-(void)getNewmessage
{

    dispatch_queue_t queue = dispatch_queue_create("kk", DISPATCH_QUEUE_SERIAL);
    // 串行队列中执行异步任务
    dispatch_async(queue, ^{
        
        NSString *interval = @"";
        NSDictionary *start_push = [[NSUserDefaults standardUserDefaults] objectForKey:@"start_push"];
        interval = [NSString stringWithFormat:@"%@",[start_push objectForKey:@"interval"]];
        NSInteger intervals = [interval integerValue];
        if (intervals>0) {
            
            NSTimer *timer = [NSTimer timerWithTimeInterval:intervals*60 target:self selector:@selector(doAnything) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
            
        }

    });
}

- (void)doAnything{
    
    NSLog(@"doAnything...");
    NSDictionary *start_push = [[NSUserDefaults standardUserDefaults] objectForKey:@"start_push"];
    NSString *rate = [NSString stringWithFormat:@"%@",[start_push objectForKey:@"rate"]];
    int rateInt = [rate intValue]*10;
    int x = arc4random()%10;
    
    if (rateInt>=5) {
        if ((x<=rateInt)) {
            [self getNewsMessage];
        }
    }
    else
    {
        if ((x>rateInt)) {
            [self getNewsMessage];
        }
    }
}

- (void)getNewsMessage{
    
    if ([KKUserModel sharedUserModel].userId) {
        [[AFNetAPIClient sharedClient] requestUrl:pushnewonemsg cParameters:@{@"id":[KKUserModel sharedUserModel].userId} success:^(NSDictionary * response) {
            NSLog(@"response----%@",response);
            if ([[response objectForKey:@"code"] isEqual:@1]) {
                NSDictionary * data = [response objectForKey:@"data"];
                NSArray * list = [data objectForKey:@"newslist"];
                for (NSDictionary * dict in list) {
                    NSDictionary * botinfo = [dict objectForKey:@"botinfo"];
                    MessageItem * item = [[MessageItem alloc]init];
                    item.userName = [botinfo safeObj:@"name"];
                    item.userId = [botinfo safeObj:@"id"];
                    if ([botinfo objectForKey:@"photo"]) {
                        item.photo = [[botinfo objectForKey:@"photo"] firstObject];
                    }
                    NSInteger type = [[dict objectForKey:@"contenttype"] integerValue];
                    item.msgType = type - 1;
                    if (type == 1) {
                        item.message = [[[dict objectForKey:@"content"] safeObj:@"msg"] filtrationSpecailCharactor];
                    }else if (type == 2){
                        item.message = [[dict objectForKey:@"content"] safeObj:@"photo"];
                    }else if (type == 3){
                        item.message = [NSString stringWithFormat:@"%@||%@",[[dict objectForKey:@"content"] safeObj:@"videopreview"],[[dict objectForKey:@"content"] safeObj:@"video"]];
                    }
                    item.sendUserId = [botinfo safeObj:@"id"];
                    [self senderLocalNotificationCenter:item];
                    [[KKChatSendManager sharedInstance] senderMessage:item withAfterSecond:0];
                }
            }
            
        } failure:^(NSError * error) {
            
        }];
    }
}
-(void)senderLocalNotificationCenter:(MessageItem*)item{
    
    
    if (@available(iOS 10.0, *)){
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        
        //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
        UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
        content.body = NSLocalizedString(@"You have a message", nil);
        content.userInfo = @{@"rate_push":@1};
        content.sound = [UNNotificationSound defaultSound];
        
        // 在 alertTime 后推送本地推送
        UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                      triggerWithTimeInterval:1 repeats:NO];
        
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:item.userId
                                                                              content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
        
    }
    
   
}
@end
