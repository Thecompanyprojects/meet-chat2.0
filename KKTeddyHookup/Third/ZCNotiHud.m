//
//  ZCNotiHud.m
//  zhaopin
//
//  Created by 张葱 on 2018/11/11.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import "ZCNotiHud.h"

@implementation ZCNotiHud
+(void)showMessag:(NSString *)str{
    
    
    UILabel * labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    labe.backgroundColor = [UIColor blackColor];
    labe.textColor = [UIColor whiteColor];
    labe.text = str;
    labe.font = [UIFont systemFontOfSize:14];
    labe.textAlignment = 1;
    labe.numberOfLines = 0;
    CGSize size = [labe.text boundingRectWithSize:CGSizeMake(300, labe.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:labe.font} context:nil].size;
    
    labe.xy_width= size.width +20;
    labe.xy_height = size.height +20;
    labe.layer.cornerRadius = 3;
    labe.layer.masksToBounds = YES;
    labe.center = CGPointMake(kScreenWidth/2, kScreenHeight/5*2);
    [[UIApplication sharedApplication].keyWindow addSubview:labe];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray* values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [labe.layer addAnimation:animation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [labe removeFromSuperview];
    });

    
}


+(void)showStatusProgress:(NSString*)hud{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@...",hud]];
    
}
@end
