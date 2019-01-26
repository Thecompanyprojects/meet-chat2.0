//
//  AppDelegate+Extension.m
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "BaseNavigationController.h"
#import "KKDramerViewController.h"
#import "UITabBar+badge.h"


@implementation AppDelegate (Extension)

- (void)setupRootViewControllerWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    
    // Window设置
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    // 主控制器视图
    self.tabBarController = [[KKTabbarController alloc] init];
    
//    // 侧边栏控制器视图
//    XTDrawerViewController *drawerController = [[XTDrawerViewController alloc] init];
//
//    // 组合
//    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:tabBarController leftDrawerViewController:drawerController];
//    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
//    self.drawerController.shouldStretchDrawer = NO;
//    self.drawerController.showsShadow = NO;
//    self.drawerController.maximumLeftDrawerWidth = kScreenWidth * 0.7;
//    [self.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:3.0]];
//
//
//    drawerController.xt_drawerViewActionBlock = ^(XTDrawerViewActionType actionType) {
//        [self.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//        XTTabBarController *tabBarVC = (XTTabBarController *)self.drawerController.centerViewController;
//        BaseNavigationController *navVC = (BaseNavigationController *)tabBarVC.selectedViewController;
//
//        switch (actionType) {
//            case XTDrawerViewAction_RateUs:{
//                NSString * url = kAppStoreRateUrl;
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//            } break;
//            case XTDrawerViewAction_Share:{
//                [self sharedWithController:navVC.topViewController];
//            } break;
//            case XTDrawerViewAction_Feedbcak:{
//                XTFeedbackViewController *feedbackVC = [XTFeedbackViewController new];
//                feedbackVC.title = NSLocalizedString(@"Feedback", nil);
//                [navVC pushViewController:feedbackVC animated:YES];
//            } break;
//            case XTDrawerViewAction_About:{
//                XTAboutViewController *aboutVC = [XTAboutViewController new];
//                aboutVC.title = NSLocalizedString(@"About", nil);
//                [navVC pushViewController:aboutVC animated:YES];
//            } break;
//            case XTDrawerViewAction_Logout:{
//                [UIAlertController showAlertTitle:NSLocalizedString(@"Tips", nil) message:NSLocalizedString(@"Are you sure to log out? \nYou will not be able to receive your feiends's messages!", nil) cancelTitle:NSLocalizedString(@"Cancel", nil) otherTitle:NSLocalizedString(@"Yes", nil) cancleBlock:^{
//
//                } otherBlock:^{
//
//                }];
//            } break;
//            default:
//                break;
//        }
//    };
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
}
- (void)sharedWithController:(UIViewController *)controller {
    //分享的标题
    NSString *textToShare = NSLocalizedString(@"Share to Friends", nil);
    //分享的图片
    UIImage *imageToShare = [UIImage appIconImage];
    //分享的url
    NSString *url = kAppStoreUrl;
    NSURL *urlToShare = [NSURL URLWithString:url];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    [controller presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"share completed");
            //分享 成功
        } else  {
            NSLog(@"share is cancled");
            //分享 取消
        }
    };
}

- (void)setupThirdSdkConfig {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    
    
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
}

@end
