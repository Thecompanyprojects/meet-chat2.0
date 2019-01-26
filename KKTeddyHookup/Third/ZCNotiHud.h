//
//  ZCNotiHud.h
//  zhaopin
//
//  Created by 张葱 on 2018/11/11.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCNotiHud : NSObject
+(void)showMessag:(NSString*)str;
+(void)showStatusProgress:(NSString*)hud;
@end

NS_ASSUME_NONNULL_END
