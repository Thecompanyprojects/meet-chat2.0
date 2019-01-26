//
//  WJGAFCheckNetManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "WJGAFCheckNetManager.h"

@implementation WJGAFCheckNetManager

+ (instancetype)shareTools {
    static WJGAFCheckNetManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WJGAFCheckNetManager alloc] init];
    });

    return _sharedClient;
}

-(void)checkNetWithBlock{
    //监测方法
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //开启监听，记得开启，不然不走block
    [manger startMonitoring];
    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
                [self chectnotNetwithtype:@"weak_network"];
                
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                [self chectnotNetwithtype:@"no_network"];
                
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                NSLog(@"WiFi");
                break;
            default:
                break;
        }
    }];
}

-(void)chectnotNetwithtype:(NSString *)str
{
    switch (self.type) {
        case checkNetTypeWithrecommend:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(0)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithdiscover:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithshake:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(2)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithbottle:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(3)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithactive:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(4)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithlikedme:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(5)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithrobit:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(6)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithMe:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(8)} userInfo:[NSDictionary new] upload:NO];
            break;
        case checkNetTypeWithmassage:
            [[XYLogManager shareManager] addLogKey1:@"data" key2:str content:@{@"type":@(7)} userInfo:[NSDictionary new] upload:NO];
            break;
        default:
            break;
            
    }
    
}

@end
