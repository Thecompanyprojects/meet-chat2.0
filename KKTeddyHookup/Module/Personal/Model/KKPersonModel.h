//
//  XTPersonModel.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/24.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKPersonModel : NSObject
@property (nonatomic , copy) NSString              * single;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , strong) NSMutableArray              * photos;
@property (nonatomic , assign) NSInteger              Newid;
@property (nonatomic , copy) NSString              * age;
@property (nonatomic , copy) NSString              * signature;
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * horoscope;
@property (nonatomic , copy) NSString              * getuserinfo;
@property (nonatomic , copy) NSString              * wholikeme;

/**
 获取用户的数据

 @param Success 用户的个人数据信息
 */
+(void)getUser:(void(^)(NSDictionary *))Success;

@end

NS_ASSUME_NONNULL_END
 
