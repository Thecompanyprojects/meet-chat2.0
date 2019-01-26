//
//  AppDelegate+Extension.h
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Extension)
/** 根视图设置 */
- (void)setupRootViewControllerWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;
/** 第三方Sdks初始化设置 */
- (void)setupThirdSdkConfig;
@end

NS_ASSUME_NONNULL_END
