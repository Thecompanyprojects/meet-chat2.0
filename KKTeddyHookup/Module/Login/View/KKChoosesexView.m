//
//  XTChoosesexView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/23.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKChoosesexView.h"

@interface KKChoosesexView()
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLab0;
@property (nonatomic,strong) UILabel *titleLab1;
@property (nonatomic,strong) UIButton *chooseboyBtn;
@property (nonatomic,strong) UIButton *choosegirlBtn;
@property (nonatomic,strong) UILabel *leftLab;
@property (nonatomic,strong) UILabel *rightLab;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,copy) NSString *sex;
@end

@implementation KKChoosesexView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [SVProgressHUD showInfoWithStatus:@"Sex selection cannot be changed"];
        [self addSubview:self.alertView];
        [self addSubview:self.bgView];
        [self addSubview:self.titleLab0];
        [self addSubview:self.titleLab1];
        [self addSubview:self.chooseboyBtn];
        [self addSubview:self.choosegirlBtn];
        [self addSubview:self.leftLab];
        [self addSubview:self.rightLab];
        [self addSubview:self.submitBtn];
        [self showAnimation];
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
        make.height.mas_offset(280);
    }];
    [weakSelf.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.alertView);
        make.left.equalTo(weakSelf.alertView);
        make.right.equalTo(weakSelf.alertView);
        make.height.mas_offset(200);
    }];
    [weakSelf.titleLab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.alertView).with.offset(29);
        make.left.equalTo(weakSelf.alertView);
        make.centerX.equalTo(weakSelf.alertView);
    }];
    [weakSelf.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab0.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.alertView);
        make.centerX.equalTo(weakSelf.alertView);
    }];
    [weakSelf.chooseboyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab1.mas_bottom).with.offset(32);
        make.width.mas_offset(64);
        make.height.mas_offset(64);
        make.left.equalTo(weakSelf.alertView).with.offset(56*KWIDTH);
    }];
    [weakSelf.choosegirlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.chooseboyBtn);
        make.width.mas_offset(64);
        make.height.mas_offset(64);
        make.right.equalTo(weakSelf.alertView).with.offset(-56*KWIDTH);
    }];
    [weakSelf.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chooseboyBtn);
        make.right.equalTo(weakSelf.chooseboyBtn);
        make.top.equalTo(weakSelf.chooseboyBtn.mas_bottom).with.offset(9);
    }];
    [weakSelf.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.choosegirlBtn);
        make.right.equalTo(weakSelf.choosegirlBtn);
        make.top.equalTo(weakSelf.leftLab);
    }];
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView.mas_bottom).with.offset(20);
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
        _alertView.layer.cornerRadius=3.0;
        _alertView.layer.masksToBounds=YES;
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


-(UILabel *)titleLab0
{
    if(!_titleLab0)
    {
        _titleLab0 = [[UILabel alloc] init];
        _titleLab0.textAlignment = NSTextAlignmentCenter;
        _titleLab0.text = @"Please select your gender, which cannot be changed";
        _titleLab0.font = [UIFont systemFontOfSize:10];
        _titleLab0.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _titleLab0;
}

-(UILabel *)titleLab1
{
    if(!_titleLab1)
    {
        _titleLab1 = [[UILabel alloc] init];
        _titleLab1.textAlignment = NSTextAlignmentCenter;
        _titleLab1.font = [UIFont systemFontOfSize:10];
        _titleLab1.textColor = [UIColor colorWithHexString:@"666666"];
        _titleLab1.text = @"after select";
    }
    return _titleLab1;
}

-(UIButton *)chooseboyBtn
{
    if(!_chooseboyBtn)
    {
        _chooseboyBtn = [[UIButton alloc] init];
        [_chooseboyBtn setImage:[UIImage imageNamed:@"nan-1"] forState:normal];
        [_chooseboyBtn addTarget:self action:@selector(chooseboyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseboyBtn;
}

-(UIButton *)choosegirlBtn
{
    if(!_choosegirlBtn)
    {
        _choosegirlBtn = [[UIButton alloc] init];
        [_choosegirlBtn setImage:[UIImage imageNamed:@"nv"] forState:normal];
        [_choosegirlBtn addTarget:self action:@selector(choosegirlClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choosegirlBtn;
}

-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
        _leftLab.textAlignment = NSTextAlignmentCenter;
        _leftLab.textColor = [UIColor colorWithHexString:@"999999"];
        _leftLab.font = [UIFont systemFontOfSize:14];
        _leftLab.text = @"Male";
    }
    return _leftLab;
}

-(UILabel *)rightLab
{
    if(!_rightLab)
    {
        _rightLab = [[UILabel alloc] init];
        _rightLab.textAlignment = NSTextAlignmentCenter;
        _rightLab.textColor = [UIColor colorWithHexString:@"999999"];
        _rightLab.font = [UIFont systemFontOfSize:14];
        _rightLab.text = @"Female";
    }
    return _rightLab;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"Complete" forState:normal];
        _submitBtn.backgroundColor = MainColor;
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}







#pragma mark - 实现方法

-(void)showAnimation{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    //    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        // self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}


-(void)chooseboyClick
{
    [[XYLogManager shareManager] addLogKey1:@"sex" key2:@"click" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
    self.sex = @"f";
    [self.chooseboyBtn setImage:[UIImage imageNamed:@"nan"] forState:normal];
    [self.choosegirlBtn setImage:[UIImage imageNamed:@"nv"] forState:normal];
    [self.chooseboyBtn setTitleColor:MainColor forState:normal];
    [self.choosegirlBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:normal];
}

-(void)choosegirlClick
{
    [[XYLogManager shareManager] addLogKey1:@"sex" key2:@"click" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
    self.sex = @"m";
    [self.chooseboyBtn setImage:[UIImage imageNamed:@"nan-1"] forState:normal];
    [self.choosegirlBtn setImage:[UIImage imageNamed:@"nv-1"] forState:normal];
    [self.chooseboyBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:normal];
    [self.choosegirlBtn setTitleColor:MainColor forState:normal];
}

-(void)submitClick
{
    [[XYLogManager shareManager] addLogKey1:@"sex" key2:@"click" content:@{@"result":@(2)} userInfo:[NSDictionary new] upload:YES];
    if (self.sex.length==0) {
         [SVProgressHUD showInfoWithStatus:@"Please select gender"];
        return;
    }
    if (self.replyClick) {
        self.replyClick(self.sex);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)withrepylClick:(replyBlock)block
{
    _replyClick = block;
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [UIView animateWithDuration:0.3 animations:^{
//        [self removeFromSuperview];
//    }];
//}


@end
