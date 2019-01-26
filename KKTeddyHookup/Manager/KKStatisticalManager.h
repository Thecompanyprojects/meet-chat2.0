//
//  XTStatisticalManager.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KKStatisticalManager : NSObject

+ (instancetype)shareTools;
- (void)loadData;
- (void)loadDataWithComplete:(void(^)(NSDictionary *dict))successAction error:(void(^)(NSError *error))errorAction;


- (NSDictionary *)getLocalConfigInfoDict;
- (NSString *)getLocalTermsSeveiceUrl;
- (NSString *)getLocalPrivacyPolicyUrl;


@end


