//
//  AppDelegate.m
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/10/16.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "AppDelegate.h"
#import "KKLoginViewController.h"
#import "AppDelegate+Extension.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "KKloginnavController.h"
#import <UserNotifications/UserNotifications.h>
#import <XTOOLAPP_LIBRARY/XYDeepLinkTools.h>
#import <Firebase.h>
#import "XYPushManager.h"
#import <XTOOLAPP_LIBRARY/XYAdEventManager.h>
#import "Interface.h"
#import "KKChatSendManager.h"
#import "KKPeopleViewController.h"
#import "KKLikedViewController.h"
#import "KKLikedmedbManager.h"
#import "KKMessageListViewController.h"
#import "KKGetnewmessageManager.h"

@interface AppDelegate ()<GIDSignInDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[KKShowsubscribeModel sharedShowsubModel] firstchoose];
    [[KKLikedmedbManager sharedClient] firstchoose];
    [Bugly startWithAppId:BuglyAppID];
    CGSize size = [@"What you name is Gaga wohh heh heh edge hheheheheh" contentSizeWithWidth:202 font:[UIFont systemFontOfSize:14] lineSpacing:0];
    NSLog(@"size---%f",size.height);
    [[XYLogManager shareManager]configurationStatisticsUrl:[ServerIP stringByAppendingString:statistics_log_url] crashUrl:[ServerIP stringByAppendingString:crash_log_url]];
    [[XYLogManager shareManager] uploadAllLog];
    
    [[XYDeepLinkTools sharedInstance] aliveLogOptions:launchOptions];
    [[XYDeepLinkTools sharedInstance] deepLinkFacebookSettingUrlBlock:^(NSString * _Nonnull url) {
        
    }];
    [[XYAdEventManager shareManager]addObserverForAdEvent];
    [[TTPaymentManager shareInstance] checkSubscriptionStatusComplete:nil];
    [self loadAdmanager];
    
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *str = [userdefat objectForKey:@"isLogin"];
  
    if ([str isEqualToString:@"1"]) {
        [self setupRootViewControllerWithApplication:application launchOptions:launchOptions];
        
        KKUserModel *model = [KKUserModel sharedUserModel];
        model.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        model.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        model.refreshtoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"refreshtoken"];
        model.sex = [[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
       
        [[APIResult sharedClient] getUserInfo];
        
    }
    else
    {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        KKLoginViewController *baseView = [[KKLoginViewController alloc]init];
        KKloginnavController *nav = [[KKloginnavController alloc] initWithRootViewController:baseView];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    
    [[KKStatisticalManager shareTools] loadData];
    [self setupThirdSdkConfig];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                            didFinishLaunchingWithOptions:launchOptions];
    [FBSDKSettings setAppID:@"1964630693829578"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [GIDSignIn sharedInstance].clientID = @"691173424333-iloghr46dc3q2jcgjbdku3q4s9poinhf.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].delegate = self;
    
    [FIRApp configure];
    [FIRDynamicLinks performDiagnosticsWithCompletion:nil];
    
    [self requestNotificationCenter];


    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[KKGetnewmessageManager sharedClient] getNewmessage];
    
    return YES;
}

-(void)requestNotificationCenter{
    
    if (@available(iOS 10.0, *)){
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //监听回调事件
        center.delegate = self;
        
        //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                              }];
        
        //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
        }];
        
        //注册远程通知
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }else{
        // ios8后，需要添加这个注册，才能得到授权
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                     categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
        }
    }
}
//使用 UNNotification 本地通知
-(void)registerNotification:(NSInteger )alerTime withMessageItem:(MessageItem *)item{
    NSDictionary *  message =  [[NSUserDefaults standardUserDefaults] objectForKey:@"message"];
    long long createTime = [NSDate date].timeIntervalSince1970 * 1000 + alerTime* 1000;
    NSDictionary * userDict = @{@"content":item.message,
                            @"id":item.userId,
                            @"name":item.userName,
                            @"photo":item.photo,
                            @"creatTime":[NSString stringWithFormat:@"%lld",createTime],
                            @"updateDate":[NSString stringWithFormat:@"%lld",item.updateDate],
                            @"type":@(item.msgType)
                            };
    if (message == nil) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        [dict setValue:userDict forKey:[NSString stringWithFormat:@"%lld",createTime]];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"message"];
    }else{
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:message];
        [dict setValue:userDict forKey:[NSString stringWithFormat:@"%lld",createTime]];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"message"];
    }
    if (@available(iOS 10.0, *)){
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        
        //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
        UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
        content.title = item.userName;
        if ([KKUserModel sharedUserModel].isVip) {
            content.body = item.message;
        }else{
            content.body = NSLocalizedString(@"You have a message", nil);
        }
        content.userInfo = userDict;
        content.sound = [UNNotificationSound defaultSound];
        
        // 在 alertTime 后推送本地推送
        UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                      triggerWithTimeInterval:alerTime repeats:NO];
        
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"%lld",createTime]
                                                                              content:content trigger:trigger];
        
        //添加推送成功后的处理！
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            [alert addAction:cancelAction];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }];
        
    }else{
        // ios8后，需要添加这个注册，才能得到授
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        // 设置触发通知的时间
        NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alerTime];
        NSLog(@"fireDate=%@",fireDate);
        
        notification.fireDate = fireDate;
        // 时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复的间隔
        notification.repeatInterval = kCFCalendarUnitSecond;
        
        // 通知内容
        notification.alertTitle = item.userName;
        if ([KKUserModel sharedUserModel].isVip) {
            notification.alertBody = item.message;
        }else{
            notification.alertBody = NSLocalizedString(@"You have a message", nil);
        }
        // 通知被触发时播放的声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 通知参数
        notification.userInfo = userDict;
        
        // ios8后，需要添加这个注册，才能得到授权
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            // 通知重复提示的单位，可以是天、周、月
            notification.repeatInterval = NSCalendarUnitSecond;
        } else {
            // 通知重复提示的单位，可以是天、周、月
            notification.repeatInterval = NSCalendarUnitSecond;
        }
        
        // 执行通知注册
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    }
    
}
#pragma mark - UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    //1. 处理通知
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"消息回调userInfo----%@",userInfo);
    
    //远程推送
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
       // NSDictionary *aps = [userInfo objectForKey:@"aps"];
        NSInteger type = [[userInfo objectForKey:@"type"] integerValue];
        if (type == 1) { //喜欢
            
            [[XYLogManager shareManager] addLogKey1:@"push" key2:@"receive" content:@{@"type":@"0"} userInfo:[NSDictionary new] upload:YES];
            
            //获取推送到的喜欢我的人的数据
            [[KKLikedmedbManager sharedClient] loadDatefromWeb];
            
        }else if (type == 2){ //用户推送消息
            [self getNewsMessage];
             [[XYLogManager shareManager] addLogKey1:@"push" key2:@"receive" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
        }else if (type == 3){ //活跃的人推送
            [[XYLogManager shareManager] addLogKey1:@"push" key2:@"receive" content:@{@"type":@"2"} userInfo:[NSDictionary new] upload:YES];
            if (@available(iOS 10.0, *)) {
                completionHandler(UNNotificationPresentationOptionAlert);
            } else {
                // Fallback on earlier versions
            }
        }
        else{
            [[XYLogManager shareManager] addLogKey1:@"push" key2:@"receive" content:@{@"type":@"3"} userInfo:[NSDictionary new] upload:YES];
        }
        
    }else{
        
        if([userInfo objectForKey:@"rate_push"]){
             completionHandler(UNNotificationPresentationOptionAlert);
        }else{
            //本地推送
            NSString * creatime = [userInfo objectForKey:@"creatTime"];
            NSDictionary * message = [[NSUserDefaults standardUserDefaults] objectForKey:@"message"];
            if ([[message objectForKey:creatime] isKindOfClass:[NSDictionary class]]) {
                
                MessageItem * item = [[MessageItem alloc]init];
                item.msgType = [[userInfo objectForKey:@"type"] integerValue];
                item.userId = [userInfo objectForKey:@"id"];
                item.photo = [userInfo objectForKey:@"photo"];
                item.userName = [userInfo objectForKey:@"name"];
                item.message = [userInfo objectForKey:@"content"];
                item.sendUserId = item.userId;
                item.createDate = [[userInfo objectForKey:@"creatTime"] longLongValue];
                item.updateDate = [[userInfo objectForKey:@"updateDate"] longLongValue];
                [[KKChatSendManager sharedInstance] senderMessage:item withAfterSecond:0];
                
                NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:message];
                [dict removeObjectForKey:creatime];
                [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"message"];
            }
        }
        
    }
    
   
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
       // NSDictionary *aps = [userInfo objectForKey:@"aps"];
//        [UIApplication sharedApplication].applicationIconBadgeNumber = [[aps objectForKey:@"badge"] integerValue];
        
        NSInteger type = [[userInfo objectForKey:@"type"] integerValue];
        if (type == 1) { //喜欢
            
            [[XYLogManager shareManager] addLogKey1:@"push" key2:@"click_push" content:@{@"type":@"0"} userInfo:[NSDictionary new] upload:YES];
            
            if([KKUserModel sharedUserModel].isVip)
            {
                KKLikedViewController *likedVC = [KKLikedViewController new];
                likedVC.isFromApns = YES;
                
                UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:likedVC];
                [self.window.rootViewController presentViewController:Nav animated:YES completion:^{
                    NSNotification *notification = [NSNotification notificationWithName:LikedmeNoc object:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }];
            }
            else
            {
                KKPaymentViewController *paymentController = [[KKPaymentViewController alloc] init];
                BaseNavigationController *paymentNavController = [[BaseNavigationController alloc] initWithRootViewController:paymentController];
                //获取推送到的喜欢我的人的数据
                [[KKLikedmedbManager sharedClient] loadDatefromWeb];
                [self.window.rootViewController presentViewController:paymentNavController animated:YES completion:^{
                
                }];
            }
          
    
        }else if (type == 2){ //用户推送消息
//            XTMessageListViewController * messageList = [[XTMessageListViewController alloc]init];
//            UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:messageList];
//            [self.window.rootViewController presentViewController:Nav animated:YES completion:^{
//            }];
            [[XYLogManager shareManager] addLogKey1:@"push" key2:@"click_push" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
            [[XYLogManager shareManager] addLogKey1:@"message" key2:@"show" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
            
        }else if (type == 3){ //活跃的人推送
            [[XYLogManager shareManager] addLogKey1:@"push" key2:@"click_push" content:@{@"type":@"2"} userInfo:[NSDictionary new] upload:YES];
            [[XYLogManager shareManager] addLogKey1:@"active_people" key2:@"show" content:@{@"type":@"1"} userInfo:[NSDictionary new] upload:YES];
            KKPeopleViewController *peopleVC = [KKPeopleViewController new];
            peopleVC.isFromApns = YES;
            UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:peopleVC];
            [self.window.rootViewController presentViewController:Nav animated:YES completion:^{
                
            }];
        }
        else
        {
            [[XYLogManager shareManager] addLogKey1:@"push" key2:@"click_push" content:@{@"type":@"3"} userInfo:[NSDictionary new] upload:YES];
        }
        
    }
    else {
        
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
    
}




//iOS10以前
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
     NSLog(@"%@", notification.alertBody);
}
#pragma mark - GIDSignDelegate

//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary *)options {
////    return [[GIDSignIn sharedInstance] handleURL:url
////                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
////                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//
//}
//

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL googleDeepLink = [[XYDeepLinkTools sharedInstance]deepLinkGoogleSettingWithUrl:url urlBlock:^(NSString * _Nonnull url) {
        
    }];
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled || googleDeepLink;
    
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL googleDeepLink = [[XYDeepLinkTools sharedInstance]deepLinkGoogleSettingWithUrl:url urlBlock:^(NSString * _Nonnull url) {
        
    }];
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];
    return handled || googleDeepLink;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
   
    [XYPushManager registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error----%@",error);
}
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self getNewsMessage];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSDictionary * message = [[NSUserDefaults standardUserDefaults] objectForKey:@"message"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:message];
    [message enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        long long dateStamp = [NSDate date].timeIntervalSince1970 * 1000;
        long long keyDateStamp = [key longLongValue];
        if (dateStamp > keyDateStamp) {
            MessageItem * item = [[MessageItem alloc]init];
            item.userId = [obj objectForKey:@"id"];
            item.photo = [obj objectForKey:@"photo"];
            item.userName = [obj objectForKey:@"name"];
            item.message = [obj objectForKey:@"content"];
            item.createDate = [[obj objectForKey:@"creatTime"] longLongValue];
            item.updateDate = [[obj objectForKey:@"updateDate"] longLongValue];
            item.msgType = [[obj objectForKey:@"type"] integerValue];
            item.sendUserId = item.userId;
            [[KKChatSendManager sharedInstance] senderMessage:item withAfterSecond:0];
            [dict removeObjectForKey:key];
        }
        
    }];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"message"];
}

- (void)getNewsMessage{
    
    if ([KKUserModel sharedUserModel].userId) {
        [[AFNetAPIClient sharedClient] requestUrl:pushnewmsg cParameters:@{@"id":[KKUserModel sharedUserModel].userId} success:^(NSDictionary * response) {
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
                    [[KKChatSendManager sharedInstance] senderMessage:item withAfterSecond:0];
                }
            }
            
        } failure:^(NSError * error) {
            NSLog(@"error---%@",error);
        }];
    }
   
    
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 广告注册
-(void)loadAdmanager
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString * time = [formatter stringFromDate:date];
    
    NSString * bundleVersion =  (NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countrycode = [locale localeIdentifier];
    NSString * country_code = [countrycode substringFromIndex:countrycode.length - 2];
    NSDictionary *dic = @{@"time":time,@"app_version":bundleVersion,@"country_code":country_code};
    [[XYAdBaseManager sharedInstance] initializeAdconfigDataWithUrl:[ServerIP stringByAppendingString:POST_CONGIG] params:dic];
}

@end
