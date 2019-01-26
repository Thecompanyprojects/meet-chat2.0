//
//  UIViewController+Swizzling.m
//  xk100
//
//  Created by xuyaguang on 2017/5/2.
//  Copyright © 2017年 xiaokang. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "NSObject+Swizzling.h"

#import "KKPaymentViewController.h"
#import "KKVideoPlayController.h"
#import "KKPersonalViewController.h"
#import "KKDiscoverViewController.h"
#import "KKShakeViewController.h"
#import "KKPeopleViewController.h"
#import "KKBottleViewController.h"
#import "KKRecommendViewController.h"
#import "KKMessageListViewController.h"
#import "KKRobitinfoViewController.h"

static char kTimeInKey;
static char kTimeOutKey;

@implementation UIViewController (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self yg_swizzlingInstanceMethod:@selector(viewWillAppear:) withMethod:@selector(swiz_viewWillAppear:)];
        [self yg_swizzlingInstanceMethod:@selector(viewWillDisappear:) withMethod:@selector(swiz_viewWillDisappear:)];
        [self yg_swizzlingInstanceMethod:@selector(viewDidAppear:) withMethod:@selector(swiz_viewDidAppear:)];
    });
}

- (void)swiz_viewWillAppear:(BOOL)animated {
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    if(![str containsString:@"UI"] && ![str containsString:@"Navigation"] && ![str containsString:@"TabBar"]){
        
        // 进入页面时间
        self.timeIn = [self currentTimeInterval];

    }
    [self swiz_viewWillAppear:animated];
}

- (void)swiz_viewWillDisappear:(BOOL)animated {
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    if(![str containsString:@"UI"] && ![str containsString:@"Navigation"] && ![str containsString:@"TabBar"]){
        self.timeOut = [self currentTimeInterval];
       
        // 页面时长统计
        // 时间差
        NSTimeInterval timeDif = self.timeOut.doubleValue - self.timeIn.doubleValue;
        
        // 需要统计的页面
        if ([str isEqualToString:NSStringFromClass([KKPaymentViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKVideoPlayController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"video" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKPersonalViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"mine" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKDiscoverViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"found" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKShakeViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"shake" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKPeopleViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"active_people" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKBottleViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"drift_bottle" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKRecommendViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"recommend" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
            
        } else if ([str isEqualToString:NSStringFromClass([KKMessageListViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"message" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
        } else if ([str isEqualToString:NSStringFromClass([KKRobitinfoViewController class])]) {
            [[XYLogManager shareManager] addLogKey1:@"personal_details" key2:@"duration" content:@{@"millisecond":@(timeDif)} userInfo:nil upload:YES];
        }
        
    }
    [self swiz_viewWillDisappear:animated];
}


- (void)swiz_viewDidAppear:(BOOL)animated {
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    if(![str containsString:@"UI"] && ![str containsString:@"Navigation"] && ![str containsString:@"TabBar"]){
        
    }
    [self swiz_viewDidAppear:animated];
}









- (NSString *)timeIn {
    return objc_getAssociatedObject(self, &kTimeInKey);
}

- (void)setTimeIn:(NSString *)timeIn {
    objc_setAssociatedObject(self, &kTimeInKey, timeIn, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)timeOut {
    return objc_getAssociatedObject(self, &kTimeOutKey);
}

- (void)setTimeOut:(NSString *)timeOut {
    objc_setAssociatedObject(self, &kTimeOutKey, timeOut, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)currentTimeInterval {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f", time];
}

@end

