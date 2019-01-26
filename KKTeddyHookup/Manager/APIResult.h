//
//  APIResult.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/24.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIResult : NSObject
+ (instancetype)sharedClient;
-(void)getUserInfo;
-(void)replyImgfrom:(UIImage *)img;
-(BOOL)isContainsEmoji:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
