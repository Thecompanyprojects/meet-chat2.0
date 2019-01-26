//
//  UINavigationBar+Margins.m
//  xkshop
//
//  Created by xiaokang100 on 2018/1/11.
//  Copyright © 2018年 xiaokang100. All rights reserved.
//

#import <objc/runtime.h>
#import "UINavigationBar+Margins.h"

@implementation UINavigationBar (Margins)

void swizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    if (class_addMethod(cls, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
//    if (@available(iOS 11.0, *)) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            swizzleInstanceMethod(self, @selector(layoutSubviews), @selector(yg_layoutSubviews));
//        });
//    }
}

- (void)yg_layoutSubviews {
    [self yg_layoutSubviews];
    for (UIView *view in self.subviews) {
        for (UIView *stackView in view.subviews) {
            if (@available(iOS 9.0, *)) {
//                NSLog(@"------%@",NSStringFromClass(stackView.class));
                if ([stackView isKindOfClass:[UIStackView class]]) {
                    stackView.superview.layoutMargins = UIEdgeInsetsMake(0, 8, 0, 8);
                    break;
                }
            }
        }
    }
}
@end
