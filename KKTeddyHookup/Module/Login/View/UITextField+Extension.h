//
//  UITextField+Extension.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/17.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extention)
//设置密码输入框
- (void)setTextFieldWithFont:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment title:(NSString *)title placeHolder:(NSString *)placeholder;
@end


@implementation UITextField (Extention)
- (void)setTextFieldWithFont:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment title:(NSString *)title placeHolder:(NSString *)placeholder{
    
    UIButton *rightImageV = [[UIButton alloc] init];
    self.secureTextEntry = YES;
    [rightImageV setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    rightImageV.frame = CGRectMake(0, 0, 15, 10);
    rightImageV.center = self.center;
    self.rightView = rightImageV;
    self.rightViewMode = UITextFieldViewModeAlways;
    [rightImageV addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = color == nil ? [UIColor blackColor] : color;
    self.textAlignment = alignment;
    self.borderStyle = UITextBorderStyleNone;
    self.text = title == nil ? @"" : title;
    self.placeholder = placeholder == nil ? @"" : placeholder;
}
//监听右边按钮的点击,切换密码输入明暗文状态
-(void)btnClick:(UIButton *)btn{

    [self resignFirstResponder];//取消第一响应者
    btn.selected = !btn.selected;
    [btn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    if (!btn.selected) {
        self.font = [UIFont systemFontOfSize:16];
        [btn setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
        self.secureTextEntry = YES;
    }else{
        self.font = [UIFont systemFontOfSize:16];
        [btn setBackgroundImage:[UIImage imageNamed:@"eye2"] forState:UIControlStateSelected];
        self.secureTextEntry = NO;
    }
    [self becomeFirstResponder];//放弃第一响应者
}

@end


NS_ASSUME_NONNULL_END
