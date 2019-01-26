//
//  XTVideolistModel.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/25.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKVideolistModel.h"

@implementation KKVideolistModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{@"Newid" : @"id"};
}

+(void)fetchDatasWithuserSuccess:(void(^)(NSDictionary *))Success failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"size":@(8)};
    [[AFNetAPIClient sharedClient] requestUrl:filtratevideo cParameters:dic success:^(NSDictionary * _Nonnull responseObject) {
        Success(responseObject);
      
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
