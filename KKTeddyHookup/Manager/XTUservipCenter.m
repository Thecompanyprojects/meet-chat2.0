//
//  XTUservipCenter.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/2.
//  Copyright © 2018 KK. All rights reserved.
//

#import "XTUservipCenter.h"

@implementation XTUservipCenter

+ (instancetype)sharedClient {
    static XTUservipCenter *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XTUservipCenter alloc] init];
    });
    return _sharedClient;
}

-(void)notifity
{
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:kPaymentSuccessNotificationName object:nil];
    
}

-(void)notice:(id)sender{
    NSLog(@"%@",sender);
}

@end
