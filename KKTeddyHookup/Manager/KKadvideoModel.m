//
//  XTadvideoModel.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/14.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKadvideoModel.h"

@implementation KKadvideoModel

+ (instancetype)sharedadVideoModel{
    
    static KKadvideoModel *_advideoModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _advideoModel = [[KKadvideoModel alloc]init];
    });
    return _advideoModel;
}

@end
