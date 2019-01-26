//
//  XTConstellationJudge.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/24.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKConstellationJudge : NSObject
+(NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day;
@end

NS_ASSUME_NONNULL_END
