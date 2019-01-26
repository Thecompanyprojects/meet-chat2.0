//
//  MessageAlertView.m
//  KKTeddyHookup
//
//  Created by 张葱 on 2018/11/14.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "KKMessageAlertView.h"
static UIView*  backgroundview;
@interface  KKMessageAlertView()
@property (nonatomic,copy)Sure sure;
@property (nonatomic,copy)Cancel cancel;
@property (nonatomic,strong)UIView*alertView;
@property (nonatomic,strong)NSString*title;

@end
@implementation KKMessageAlertView
+(instancetype)ShowTitle:(NSString*)title  Sure:(Sure)clicksure  Cancel:(Cancel)clickCancel{
    
  return  [[KKMessageAlertView alloc]initWithTitle:title  Sure:clicksure Cancel:clickCancel];

    
}

-(instancetype)initWithTitle:(NSString*)title  Sure:(Sure)clicksure  Cancel:(Cancel)clickCancel{
    
    if (self = [[super init]initWithFrame:CGRectZero]) {
     
        self.cancel = clickCancel;
        self.sure = clicksure;
        self.title = title;

        
    }
    return self;
}

-(void)show{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.3;
    UIWindow * window =  [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    
    
    CGFloat w =  [UIScreen mainScreen].bounds.size.width*330/376;
    CGFloat h = [UIScreen mainScreen].bounds.size.width*330/376*174/330;
    
    UIView* alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,w, h)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    alertView.layer.cornerRadius = 10;
    alertView.layer.masksToBounds = YES;

    
    
    UILabel * labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, w, 22)];
    labe.backgroundColor = [UIColor whiteColor];
    labe.textColor = [UIColor blackColor];
    labe.text = self.title;
    labe.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    labe.textAlignment = NSTextAlignmentCenter;
    labe.numberOfLines = 0;
    
    
    
    UIButton * cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.frame =  CGRectMake(20, CGRectGetMaxY(labe.frame) + 30, w*130/330 ,40);
    cancelbtn.backgroundColor = [UIColor whiteColor];
    cancelbtn.layer.cornerRadius = 20;
    cancelbtn.layer.masksToBounds = YES;
    cancelbtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    [cancelbtn setTitle:@"No" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor colorWithHexString:@"#F8438B"] forState:UIControlStateNormal];
    cancelbtn.layer.borderColor = [UIColor colorWithHexString:@"#F8438B"].CGColor;
    cancelbtn.layer.borderWidth =1;
    cancelbtn.tag = 100;
    [alertView addSubview:cancelbtn];
    [cancelbtn addTarget:self  action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(w-w*130/330-20, CGRectGetMaxY(labe.frame) + 30, w*130/330 ,40);
    btn.backgroundColor = [UIColor colorWithHexString:@"#F8438B"];
    [btn setTitle:@"Yes" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    btn.layer.cornerRadius =  20;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.tag = 101;
    [alertView addSubview:btn];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [alertView addSubview:labe];
    [alertView addSubview:cancelbtn];
    [alertView addSubview:btn];
    alertView.xy_height = CGRectGetMaxY(btn.frame)+ 37;
    self.alertView = alertView;
    
    [ [[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:alertView];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.calculationMode = kCAAnimationCubic;
    animation.values = @[@1.17,@1.06,@1.05,@1.03,@1.02,@1.01,@1.0];
    animation.duration = 0.4;
    [alertView.layer addAnimation:animation forKey:@"transform.scale"];
    
}

-(void)click:(UIButton*)sender{
    
    NSInteger col = sender.tag -100;
    
    if (col == 0) {//取消
        if (self.cancel) {
            self.cancel();
        }
        [self dismissClickBack];
        
    }else{
        if (self.sure) {
            self.sure();
        }
         [self dismissClickBack];
    }
    
    
    
}


-(void)dismissClickBack{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.alertView removeFromSuperview];
            [self removeFromSuperview];
            self.cancel = nil;
            self.sure = nil;
            self.alertView = nil;
        });
        
    }];

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
