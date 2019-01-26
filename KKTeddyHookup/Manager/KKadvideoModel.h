//
//  XTadvideoModel.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/14.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKadvideoModel : NSObject

+ (instancetype)sharedadVideoModel;

@property (nonatomic,copy) NSString *advideo_addalive_number;
@property (nonatomic,copy) NSString *advideo_addbottle_number;
@property (nonatomic,copy) NSString *advideo_addlike_number;
@property (nonatomic,copy) NSString *advideo_addsaihi_number;
@property (nonatomic,copy) NSString *advideo_addshake_number;
@property (nonatomic,copy) NSString *advideo_adgetbottle_number;

@end

NS_ASSUME_NONNULL_END
