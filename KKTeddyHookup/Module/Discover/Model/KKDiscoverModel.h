//
//  XTDiscoverModel.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/25.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKDiscoverModel : NSObject
@property (nonatomic , copy) NSString              * single;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSArray<NSString *>              * video;
@property (nonatomic , copy) NSString              * Newid;
@property (nonatomic , copy) NSString              * age;
@property (nonatomic , copy) NSString              * signature;
@property (nonatomic , copy) NSArray<NSString *>              * photo;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * horoscope;
@property (nonatomic , copy) NSArray<NSString *>              * videopreview;
@property (nonatomic , copy) NSArray<NSString *>              * photopreview;//照片预览图
@property (nonatomic , assign) BOOL issayHi;
@end

NS_ASSUME_NONNULL_END
