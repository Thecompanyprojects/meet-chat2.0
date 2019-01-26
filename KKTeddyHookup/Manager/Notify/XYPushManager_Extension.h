//
//  KKPushManager+XYPushManager_Extension.h
//  XToolWhiteNoiseIOS
//
//  Created by 郭连城 on 2018/8/31.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "XYPushManager.h"

@interface XYPushManager (Extension)
+ (void)registLocalNotificationTitle:(NSString *)title
                          WithBody:(NSString *)subTitle
                          WithBody:(NSString *)body
                    WithIdentifier:(NSString *)identifier;
@end
