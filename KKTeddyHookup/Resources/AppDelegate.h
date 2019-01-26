//
//  AppDelegate.h
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/10/16.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTabbarController.h"
#import "SqliteManager.h"
#import "KKChatSendManager.h"
#import "MessageItem.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic,strong)KKTabbarController *tabBarController;
-(void)registerNotification:(NSInteger )alerTime withMessageItem:(MessageItem *)item;
@end

