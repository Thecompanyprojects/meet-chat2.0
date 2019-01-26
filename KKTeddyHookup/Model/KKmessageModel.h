//
//  XTmessageModel.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/2.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKmessageModel : NSObject
+ (instancetype)sharedClient;
-(NSString *)showbackmessage;
@end

NS_ASSUME_NONNULL_END
