//
//  UIFont+adapt.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/20.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIFont (adapt)
+(UIFont *)adjustFont:(CGFloat)fontSize;
@end

