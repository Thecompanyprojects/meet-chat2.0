//
//  UITabBar+badge.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/31.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(NSInteger)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index; //隐藏小红点
@end

NS_ASSUME_NONNULL_END
