//
//  UIButton+Extension.m
//  xkshop
//
//  Created by xiaokang on 2017/7/18.
//  Copyright © 2017年 xiaokang100. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (void)setLeftIamegWithSpacing:(CGFloat)Spacing {
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   = 0,
        .bottom = 0,
        .right  = -Spacing,
    };
    
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   = -Spacing,
        .bottom = 0,
        .right  = 0,
    };
}

- (void)setRightIamegWithSpacing:(CGFloat)Spacing {
    
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font,}].width;
    
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    =  0,
        .left   = -img_W*2 - Spacing,
        .bottom =  0,
        .right  =  0,
    };
    
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    =  0,
        .left   =  0,
        .bottom =  0,
        .right  = -tit_W*2 - Spacing,
    };
}

- (void)setTopIamegWithSpacing:(CGFloat)Spacing {
    
    CGFloat img_W = self.imageView.image.size.width;
    CGFloat img_H = self.imageView.image.size.height;
    CGFloat tit_W = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font,}].width;
    CGFloat tit_H = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font,}].height;
    
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    =  img_H+Spacing,
        .left   = -img_W,
        .bottom =  0,
        .right  =  0,
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    =  0,
        .left   =  0,
        .bottom =  tit_H+Spacing,
        .right  = -tit_W,
    };
}

- (void)setBottomIamegWithSpacing:(CGFloat)Spacing {
    
    CGFloat img_W = self.imageView.image.size.width;
    CGFloat img_H = self.imageView.image.size.height;
    CGFloat tit_W = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font,}].width;
    CGFloat tit_H = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font,}].height;
    
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    =  0,
        .left   = -img_W,
        .bottom =  img_H + Spacing,
        .right  =  0,
    };
    
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    =  tit_H + Spacing,
        .left   =  0,
        .bottom =  0,
        .right  = -tit_W,
    };
}

@end
