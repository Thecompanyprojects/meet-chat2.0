//
//  KKLoadingHUD.h
//  VPN
//
//  Created by PanZhi on 2018/3/8.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYLoadingHUD : UIView

+(void)show;

+(void)dismiss;

+(UIView *)CreateLoadingViewWithFrame:(CGRect)frame;
+(UIView *)CreateTarotLoadingViewWithFrame:(CGRect)frame;

@end
