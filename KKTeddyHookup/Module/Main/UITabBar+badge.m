//
//  UITabBar+badge.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/31.
//  Copyright © 2018 KK. All rights reserved.
//

#import "UITabBar+badge.h"

@implementation UITabBar (badge)
- (void)showBadgeOnItemIndex:(NSInteger)index{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / (index + 2);
    CGFloat x = ceilf(percentX * tabFrame.size.width);
//    CGFloat y = ceilf(0.08 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, 0, 10, 10);
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(NSInteger)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}
@end
