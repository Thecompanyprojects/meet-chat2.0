//
//  MessageAlertView.h
//  KKTeddyHookup
//
//  Created by 张葱 on 2018/11/14.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^Sure)(void);
typedef void(^Cancel)(void);
@interface KKMessageAlertView : UIView
+(instancetype)ShowTitle:(NSString*)title  Sure:(Sure)clicksure  Cancel:(Cancel)clickCancel;
-(void)show;
@end

NS_ASSUME_NONNULL_END
