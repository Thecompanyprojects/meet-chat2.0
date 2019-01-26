//
//  XTPersonModel.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/24.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPersonModel.h"

@implementation KKPersonModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{@"Newid" : @"id"};
}

+(void)getUser:(void(^)(NSDictionary *))Success
{
    NSString *newId = [KKUserModel sharedUserModel].userId;
    NSDictionary *dic = @{@"id":newId?:@""};
    [[AFNetAPIClient sharedClient] requestUrl:GETUserInfo cParameters:dic success:^(NSDictionary * _Nonnull requset) {
        Success(requset);
    } failure:^(NSError * _Nonnull error) {
        [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(7)} userInfo:[NSDictionary new] upload:NO];
    }];
}

@end
