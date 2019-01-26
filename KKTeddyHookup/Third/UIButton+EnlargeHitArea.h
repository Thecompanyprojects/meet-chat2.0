//
//  UIButton+EnlargeHitArea.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/31.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeHitArea)
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;
@end

NS_ASSUME_NONNULL_END
