//
//  UserModel.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKUserModel.h"

@implementation KKUserModel

+ (instancetype)sharedUserModel{
    static KKUserModel *_userModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userModel = [[KKUserModel alloc]init];
    });
    return _userModel;
}

- (BOOL)isVip {
    [[TTPaymentManager shareInstance] checkSubscriptionStatusComplete:nil];
    BOOL vip =  [TTPaymentManager shareInstance].isVip;
    NSLog(@"isVip-----%d",vip);
    return vip;
}

@end
