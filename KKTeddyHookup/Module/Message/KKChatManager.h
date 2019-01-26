//
//  ChatManager.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKChatManager : NSObject
+ (instancetype)sharedChatManager;
-(void)chatSayHi:(NSString *)userId withContent:(NSString *)content withUserName:(NSString *)userName withPhoto:(NSString *)photo;

-(void)cornerMarkZero:(NSString *)userId;
-(void)cornerMark:(NSString *)userId;
@end

NS_ASSUME_NONNULL_END
