//
//  DCFHttpManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/27.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCFHttpManager : XYNetworkRequest
+ (instancetype)sharedClient;
-(void)refreshTokensuccess:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;
@end

NS_ASSUME_NONNULL_END
