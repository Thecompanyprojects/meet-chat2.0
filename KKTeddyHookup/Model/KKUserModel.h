//
//  UserModel.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKUserModel : NSObject
+ (instancetype)sharedUserModel;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * token;
@property(nonatomic,copy)NSString * refreshtoken;
@property(nonatomic,copy)NSString * userId;
@property(nonatomic,copy)NSArray *  userphotos;

@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * single;
@property (nonatomic , copy) NSString              * age;
@property (nonatomic , copy) NSString              * signature;
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * horoscope;

@property (nonatomic , assign) BOOL                 isVip;
@end

NS_ASSUME_NONNULL_END
