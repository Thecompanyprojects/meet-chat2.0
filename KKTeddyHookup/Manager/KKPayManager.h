//
//  XTPayManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKPayManager : NSObject
+ (instancetype)sharedClient;
-(void)addpay;
@end

NS_ASSUME_NONNULL_END
