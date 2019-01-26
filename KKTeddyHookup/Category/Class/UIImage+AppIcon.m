//
//  UIImage+AppIcon.m
//  xk100
//
//  Created by xiaokang on 2017/6/26.
//  Copyright © 2017年 xiaokang. All rights reserved.
//

#import "UIImage+AppIcon.h"

@implementation UIImage (AppIcon)

+ (UIImage *)appIconImage {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    NSString *iconLastName = [iconsArr lastObject];
    return [UIImage imageNamed:iconLastName];
}

@end
