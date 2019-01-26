//
//  XTVCchoose.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/5.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTVCchoose : NSObject
+ (instancetype)sharedClient;
-(UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
