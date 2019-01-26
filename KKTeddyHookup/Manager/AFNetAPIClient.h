//
//  AFNetAPIClient.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "XYNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFNetAPIClient : XYNetworkRequest
+ (instancetype)sharedClient;
-(void)requestUrl:(NSString *)url cParameters:(NSDictionary *)parameters  success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;
@end

NS_ASSUME_NONNULL_END
