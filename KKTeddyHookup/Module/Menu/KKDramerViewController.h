//
//  XTDrawerViewController.h
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, XTDrawerViewActionType) {
    XTDrawerViewAction_RateUs = 0,  // 评价
    XTDrawerViewAction_Share,       // 分享
    XTDrawerViewAction_About,       // 关于
    XTDrawerViewAction_Logout,      // 退出
    XTDrawerViewAction_Feedbcak,    // 反馈
    XTDrawerViewAction_Payment      // 订阅
};

@interface KKDramerViewController : BaseViewController

@property (nonatomic, copy) void (^xt_drawerViewActionBlock)(XTDrawerViewActionType actionType);

@end


