//
//  MessageItem.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "MessageItem.h"
#import "NSObject+YHDBRuntime.h"

@implementation MessageItem
+ (NSString *)yh_primaryKey{
    return @"chatId";
}
@end
