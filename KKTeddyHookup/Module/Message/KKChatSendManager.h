//
//  ChatSendManager.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKChatSendManager : NSObject
+ (instancetype)sharedInstance;
-(void)senderMessage:(MessageItem *)message withAfterSecond:(NSInteger)second;
@end

NS_ASSUME_NONNULL_END
