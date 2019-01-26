//
//  UIButton+PassValue.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/29.
//  Copyright © 2018 KK. All rights reserved.
//

#import "UIButton+PassValue.h"

@implementation UIButton (PassValue)

-(NSDictionary *)paramDic{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setParamDic:(NSDictionary *)paramDic{
    objc_setAssociatedObject(self, @selector(paramDic), paramDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
