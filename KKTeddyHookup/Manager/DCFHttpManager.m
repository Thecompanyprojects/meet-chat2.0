//
//  DCFHttpManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/27.
//  Copyright © 2018 KK. All rights reserved.
//

#import "DCFHttpManager.h"

@implementation DCFHttpManager

+ (instancetype)sharedClient {
    static DCFHttpManager *_dcfManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dcfManager = [[DCFHttpManager alloc] initWithBaseURL:[NSURL URLWithString:ServerIP]];
        _dcfManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _dcfManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_dcfManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    });
   // [UserModel sharedUserModel].refreshtoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"refreshtoken"];
    NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"refreshtoken"];
    [_dcfManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",refreshToken]  forHTTPHeaderField:@"Authorization"];
    return _dcfManager;
}

-(void)refreshTokensuccess:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *parameters = @{@"id":@([[KKUserModel sharedUserModel].userId intValue])};
    NSDictionary *dic = [XYNetworkTools handleParameter:@{@"data":parameters}];
    NSString *url = RefreshToken;
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

                    NSDictionary *data = [responseDict objectForKey:@"data"];
                    NSString *token = [data objectForKey:@"token"];
                    NSString *refreshtoken = [data objectForKey:@"refreshtoken"];
                    [KKUserModel sharedUserModel].token = token;
                    [KKUserModel sharedUserModel].refreshtoken = refreshtoken;
                    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] setObject:refreshtoken forKey:@"refreshtoken"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    success(responseDict);
                    
                }
            }else{
         
                success(responseDict);
            }
        }else{
            NSError* error_dec = [NSError errorWithDomain:NSCocoaErrorDomain code:-999 userInfo:@{@"reason":@"Decrypt Failed"}];
            NSLog(@"ERROR-----%@",error_dec);
            NSLog(@"解密失败")
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:error_dec, nil];
            success(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error----%@",error);
        failure(error);
        
    }];
}


@end
