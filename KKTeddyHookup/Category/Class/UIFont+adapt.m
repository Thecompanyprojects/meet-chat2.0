//
//  UIFont+adapt.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/20.
//  Copyright © 2018 KK. All rights reserved.
//

#import "UIFont+adapt.h"

@implementation UIFont (adapt)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
        Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
        method_exchangeImplementations(newMethod, method);
        
        Method newBoldMethod = class_getClassMethod([self class], @selector(adjustBoldFont:));
        Method boldMethod = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
        method_exchangeImplementations(newBoldMethod, boldMethod);
        
    });
}

+ (UIFont *)adjustFont:(CGFloat)fontSize
{
    [self adjustFont:fontSize];
    
    UIFont *newFont = nil;
    
    if (IS_IPHONE_6 || isIPhoneX)
    {
        //iPhone 6|6S|7|7S|8
        newFont = [UIFont adjustFont:fontSize];
    }
    else if (IS_IPHONE_6P)
    {
        //iPhone 6P|7P|8P
        newFont = [UIFont adjustFont:fontSize];
    }
    else
    {
        //iPhone 5|5S|5C|4|4S
        newFont = [UIFont adjustFont:fontSize-2];
    }
    
    //    newFont = [UIFont adjustFont:fontSize * SizeScale];
    return newFont;
    
}

+ (UIFont *)adjustBoldFont:(CGFloat)fontSize {
    
    [self adjustBoldFont:fontSize];
    
    UIFont *newFont = nil;
    if (IS_IPHONE_6 || isIPhoneX)
    {
        //iPhone 6|6S|7|7S|8
        newFont = [UIFont adjustBoldFont:fontSize];
    }
    else if (IS_IPHONE_6P)
    {
        //iPhone 6P|7P|8P
        newFont = [UIFont adjustBoldFont:fontSize];
    }
    else
    {
        //iPhone 5|5S|5C|4|4S
        newFont = [UIFont adjustBoldFont:fontSize-2];
    }
    return newFont;
    
}
@end
