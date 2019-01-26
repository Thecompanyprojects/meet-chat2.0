//
//  XTPhotoView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/25.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPhotoView.h"

@interface KKPhotoView()
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *logoImg;
@property (nonatomic,strong) UILabel *titleLab0;
@property (nonatomic,strong) UILabel *titleLab1;
@property (nonatomic,strong) UILabel *titleLab2;
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation KKPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    /*下面代码的作用让视图没关闭之前只创建一次*/
    BOOL isHas = NO;
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[KKPhotoView class]]) {
            isHas = YES;
            break;
        }
    }
    if (isHas) {
        return nil;
    }

    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        
        [self addSubview:self.alertView];
        [self showAnimation];
        [self addSubview:self.bgView];
        [self addSubview:self.logoImg];
        [self addSubview:self.titleLab0];
        [self addSubview:self.titleLab1];
        [self addSubview:self.titleLab2];
        [self addSubview:self.submitBtn];
        [self setuplayout];

    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(124*KHEIGHT);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(20);
        make.height.mas_offset(303);
    }];
    [weakSelf.bgView setHidden:YES];
    [weakSelf.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.alertView);
        make.left.equalTo(weakSelf.alertView);
        make.right.equalTo(weakSelf.alertView);
        make.height.mas_offset(200);
    }];
    [weakSelf.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.alertView).with.offset(25);
        make.centerX.equalTo(weakSelf);
        make.width.mas_offset(165);
        make.height.mas_offset(124);
    }];
    [weakSelf.titleLab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logoImg.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.alertView);
        make.centerX.equalTo(weakSelf);
    }];
    [weakSelf.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab0.mas_bottom).with.offset(9);
        make.left.equalTo(weakSelf.alertView);
        make.centerX.equalTo(weakSelf);
    }];
    [weakSelf.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab1.mas_bottom).with.offset(9);
        make.left.equalTo(weakSelf.alertView);
        make.centerX.equalTo(weakSelf);
    }];
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab2.mas_bottom).with.offset(10);
        make.width.mas_offset(156);
        make.height.mas_offset(40);
        make.centerX.equalTo(weakSelf.alertView);
    }];
}

#pragma mark - getters

-(UIView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
    }
    return _alertView;
}

-(UIView *)bgView
{
    if(!_bgView)
    {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
    }
    return _bgView;
}

-(UIImageView *)logoImg
{
    if(!_logoImg)
    {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"哭(1)"];
    }
    return _logoImg;
}

-(UILabel *)titleLab0
{
    if(!_titleLab0)
    {
        _titleLab0 = [[UILabel alloc] init];
        _titleLab0.textAlignment = NSTextAlignmentCenter;
        _titleLab0.font = [UIFont systemFontOfSize:10];
        _titleLab0.textColor = [UIColor colorWithHexString:@"666666"];
        _titleLab0.text = @"You haven't added personal photos yet,";
    }
    return _titleLab0;
}

-(UILabel *)titleLab1
{
    if(!_titleLab1)
    {
        _titleLab1 = [[UILabel alloc] init];
        _titleLab1.textAlignment = NSTextAlignmentCenter;
        _titleLab1.textColor = [UIColor colorWithHexString:@"666666"];
        _titleLab1.font = [UIFont systemFontOfSize:10];
        _titleLab1.text = @"and you will get a reply when you add";
    }
    return _titleLab1;
}

-(UILabel *)titleLab2
{
    if(!_titleLab2)
    {
        _titleLab2 = [[UILabel alloc] init];
        _titleLab2.textAlignment = NSTextAlignmentCenter;
        _titleLab2.textColor = [UIColor colorWithHexString:@"666666"];
        _titleLab2.font = [UIFont systemFontOfSize:10];
        _titleLab2.text = @"personal photo";
    }
    return _titleLab2;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        _submitBtn.backgroundColor = MainColor;
        [_submitBtn setTitle:@"Add" forState:normal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn addTarget:self action:@selector(submitbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(void)submitbtnClick
{
  
    if (self.replyClick) {
        self.replyClick([NSString new]);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)withrepylClick:(replyBlock)block
{
    _replyClick = block;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}


#pragma mark - 实现方法

-(void)showAnimation{
    
    self.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
  // CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2,1.2);
    self.alertView.alpha = 1;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
//        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}


@end
