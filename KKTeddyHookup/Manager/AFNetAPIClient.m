//
//  AFNetAPIClient.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "AFNetAPIClient.h"
#import "KKUserModel.h"
#import "DCFHttpManager.h"



@implementation AFNetAPIClient
+ (instancetype)sharedClient {
    static AFNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:ServerIP]];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/octet-stream", @"application/json", @"text/html",@"text/json",@"text/javascript",nil];
        [_sharedClient.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    });
    [_sharedClient.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[KKUserModel sharedUserModel].token ? [KKUserModel sharedUserModel].token:@""]  forHTTPHeaderField:@"Authorization"];
    
    return _sharedClient;
}

-(void)requestUrl:(NSString *)url cParameters:(NSDictionary *)parameters  success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    NSDictionary *dic = [XYNetworkTools handleParameter:@{@"data":parameters}];
    [self POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 需要先转十六进制的data
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [XYNetworkTools stringToHexData:responseString];
        // 解密需要时Base64的字符串
        NSString *base64Str = [data base64EncodedStringWithOptions:0];
        // 使用秘钥进行解密,得到的是结果字符串
        NSString *resultStr = [base64Str xy_blowFishDecodingWithKey:xy_BlowFishKey];
        // 解密完成后转成Data以便之后进行序列化
        NSData *data_dec = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
        if (data_dec) {
            NSError* serializeError;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data_dec options:0 error:&serializeError];
            NSLog(@"%@",responseDict)
            if (!serializeError) {
                NSLog(@"序列化成功");
                if (success) {
                    
                    if ([[responseDict objectForKey:@"code"] intValue]==1007) {
                        
                        [[DCFHttpManager sharedClient] refreshTokensuccess:^(NSDictionary * _Nonnull newrequset) {

                            [self requestUrl:url cParameters:dic success:^(NSDictionary * _Nonnull requset) {
                                // 需要先转十六进制的data
                                NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                NSData *data = [XYNetworkTools stringToHexData:responseString];
                                // 解密需要时Base64的字符串
                                NSString *base64Str = [data base64EncodedStringWithOptions:0];
                                // 使用秘钥进行解密,得到的是结果字符串
                                NSString *resultStr = [base64Str xy_blowFishDecodingWithKey:xy_BlowFishKey];
                                // 解密完成后转成Data以便之后进行序列化
                                NSData *data_dec = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
                                if (data_dec) {
                                    NSError* serializeError;
                                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data_dec options:0 error:&serializeError];
                                    NSLog(@"%@",responseDict)
                                    success(responseDict);
                                }
                            } failure:^(NSError * _Nonnull error) {
                                failure(error);
                            }];
                            
                            
                            
                        } failure:^(NSError * _Nonnull error) {
                            failure(error);
                            
                        }];
                        
                     
                        
                    }
                    else
                    {
                        success(responseDict);
                    }
                }
            }else{
                if (failure) {
                    failure(serializeError);
                }
            }
        }else{
            NSError* error_dec = [NSError errorWithDomain:NSCocoaErrorDomain code:-999 userInfo:@{@"reason":@"Decrypt Failed"}];
            NSLog(@"ERROR-----%@",error_dec);
            NSLog(@"解密失败")
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error----%@",error);
        failure(error);
        
    }];


}



@end
