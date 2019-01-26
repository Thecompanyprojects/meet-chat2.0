//
//  XTIsLodingManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/23.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKIsLodingManager.h"

@implementation KKIsLodingManager

+ (instancetype)sharedClient {
    static KKIsLodingManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KKIsLodingManager alloc] init];
        
    });
    return _sharedClient;
}

@end
