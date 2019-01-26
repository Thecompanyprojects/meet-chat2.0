//
//  AppDelegate+RootViewController.m
//  XToolSocialContactIOS
//
//  Created by 许亚光 on 2018/10/16.
//  Copyright © 2018 小叶科技. All rights reserved.
//

#import "AppDelegate+RootViewController.h"
#import "XTTabBarController.h"
#import "XTDrawerViewController.h"


@implementation AppDelegate (RootViewController)

- (void)setupRootViewControllerWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    
    // Window设置
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    // 主控制器视图
    XTTabBarController *tabBarController = [[XTTabBarController alloc] init];
    
    // 侧边栏控制器视图
    XTDrawerViewController *drawerController = [[XTDrawerViewController alloc] init];
    
    // 组合
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:tabBarController leftDrawerViewController:drawerController];
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    self.drawerController.shouldStretchDrawer = NO;
    self.drawerController.showsShadow = NO;
    self.drawerController.maximumLeftDrawerWidth = kScreenWidth * 0.8;
    [self.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:3.0]];
    
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
}


@end
