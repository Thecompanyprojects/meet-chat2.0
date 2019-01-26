//
//  UIColor+Extension.h
//  AdDemo
//
//  Created by KevinXu on 2018/9/14.
//  Copyright © 2018年 xuyagung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GradientDirection) {
    GradientDirection_Horizontal = 0,   // 横向
    GradientDirection_Vertical,         // 竖向
    GradientDirection_UpwardDiagonal,   // 斜向下
    GradientDirection_DownDiagonal      // 斜向上
};

@interface UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (NSString *)hexFromUIColor:(UIColor*) color;
+ (UIColor *)randomColor;


+ (UIColor *)colorGradientWithSize:(CGSize)size direction:(GradientDirection)direction startColor:(UIColor *)startcolor endColor:(UIColor *)endColor;

@end
