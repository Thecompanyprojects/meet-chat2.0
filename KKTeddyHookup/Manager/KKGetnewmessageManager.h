//
//  XTGetnewmessageManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/23.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKGetnewmessageManager : NSObject
+ (instancetype)sharedClient;
-(void)getNewmessage;
@end

NS_ASSUME_NONNULL_END
