//
//  discoverAlertView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/18.
//  Copyright © 2018 KK. All rights reserved.
//


#import "KKdiscoverAlertView.h"
#import "KKShakeViewController.h"
#import "XTVCchoose.h"

@interface KKdiscoverAlertView()

@end

@implementation KKdiscoverAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /*下面代码的作用让视图没关闭之前只创建一次*/
        BOOL isHas = NO;
        for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[KKdiscoverAlertView class]]) {
                isHas = YES;
                break;
            }
        }
        if (isHas) {
            return nil;
        }
        
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake(MARGIN, HEIGHT-80-93-kNavBarHeight, WIDTH-40, 93)];
        self.userInteractionEnabled = YES;
        self.alertView.backgroundColor = [UIColor colorWithHexString:@"DEDEDE"];
        self.alertView.layer.cornerRadius=5.0;
        self.alertView.layer.masksToBounds=YES;
        self.alertView.userInteractionEnabled=YES;
        [self addSubview:self.alertView];
        [self showAnimationwith];
        [self addSubview:self.coverImg];
        [self addSubview:self.nameLab];
        [self addSubview:self.ageLab];
        [self addSubview:self.contentLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.alertView).with.offset(10);
        make.centerY.equalTo(weakSelf.alertView);
        make.width.mas_offset(75);
        make.height.mas_offset(75);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.coverImg);
        make.left.equalTo(weakSelf.coverImg.mas_right).with.offset(10);
        make.height.mas_offset(17);
    }];
    [weakSelf.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab.mas_right).with.offset(10);
        make.width.mas_offset(22);
        make.height.mas_offset(11);
        make.centerY.equalTo(weakSelf.coverImg);
    }];

    [weakSelf.contentLab setHidden:YES];
}

#pragma mark - getters

-(UIView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[UIView alloc] init];

    }
    return _alertView;
}

-(UIImageView *)coverImg
{
    if(!_coverImg)
    {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.userInteractionEnabled = YES;

    }
    return _coverImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:16];
        _nameLab.userInteractionEnabled = YES;
        _nameLab.textColor = [UIColor colorWithHexString:@"000000"];
    }
    return _nameLab;
}

-(UILabel *)ageLab
{
    if(!_ageLab)
    {
        _ageLab = [[UILabel alloc] init];
        _ageLab.backgroundColor = MainColor;
        _ageLab.layer.masksToBounds = YES;
        _ageLab.layer.cornerRadius = 2;
        _ageLab.font = [UIFont systemFontOfSize:10];
        _ageLab.textColor = [UIColor whiteColor];
        _ageLab.textAlignment = NSTextAlignmentCenter;
    }
    return _ageLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.userInteractionEnabled = YES;
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _contentLab;
}

-(void)showAnimationwith{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
    if ([[XTVCchoose sharedClient].getCurrentVC isMemberOfClass:[KKShakeViewController class]]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch * touch = touches.anyObject;
    if ([touch.view isMemberOfClass:[self.alertView class]]||[touch.view isMemberOfClass:[self.coverImg class]]||[touch.view isMemberOfClass:[self.nameLab class]]) {
        if (self.sureClick) {
            self.sureClick([NSString new]);
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            [self removeFromSuperview];
        }];
        
    }
    else
    {
        if (self.dismissClick) {
            self.dismissClick([NSString new]);
        }
        [UIView animateWithDuration:0.3 animations:^{
            [self removeFromSuperview];
        }];
    }
   
}


-(void)withSureClick:(sureBlock)block{
    _sureClick = block;
}

-(void)withDismissClick:(dismissBlock)block;
{
    _dismissClick = block;
}

@end
