//
//  UIViewController+Swizzling.h
//  xk100
//
//  Created by xuyaguang on 2017/5/2.
//  Copyright © 2017年 xiaokang. All rights reserved.
//


/*该分类用于页面统计*/

#import <UIKit/UIKit.h>

@interface UIViewController (Swizzling)

 /**< 进入时间 */
@property (nonatomic, copy) NSString *timeIn;

 /**< 退出时间 */
@property (nonatomic, copy) NSString *timeOut;

@end
