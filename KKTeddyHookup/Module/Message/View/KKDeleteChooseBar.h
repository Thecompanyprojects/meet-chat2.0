//
//  DeleteChooseBar.h
//  KKTeddyHookup
//
//  Created by 张葱 on 2018/11/13.
//  Copyright © 2018年 KK. All rights reserved.
//  消息列表的删除选择


#import <UIKit/UIKit.h>
@class KKDeleteChooseBar;
NS_ASSUME_NONNULL_BEGIN
typedef void(^Clicked)(NSInteger col,KKDeleteChooseBar* bar);
@interface KKDeleteChooseBar : UIView
@property (nonatomic,copy)Clicked click;
+(instancetype)ChooseBArWithchoose:(Clicked)clicked;
@property (nonatomic,assign)BOOL ishasdelete;//是都有删除
@property (nonatomic,assign)BOOL ishasSelectedAll;//是都全选
-(void)Clean;
@end

NS_ASSUME_NONNULL_END
