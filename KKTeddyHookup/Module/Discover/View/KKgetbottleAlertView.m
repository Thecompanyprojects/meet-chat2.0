//
//  getbottleAlertView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//




#import "KKgetbottleAlertView.h"

@interface KKgetbottleAlertView()
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *replyBtn;
@end

@implementation KKgetbottleAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /*下面代码的作用让视图没关闭之前只创建一次*/
        BOOL isHas = NO;
        for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[KKgetbottleAlertView class]]) {
                isHas = YES;
                break;
            }
        }
        if (isHas) {
            return nil;
        }
        
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake(MARGIN, 204*KHEIGHT, WIDTH-40, 303)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius=5.0;
        self.alertView.layer.masksToBounds=YES;
        self.alertView.userInteractionEnabled=YES;
        [self addSubview:self.alertView];
        [self showAnimation];
        [self.alertView addSubview:self.coverImg];
        [self.alertView addSubview:self.nameLab];
        [self.alertView addSubview:self.ageLab];
        [self.alertView addSubview:self.sexImg];
        [self.alertView addSubview:self.contentLab];
        [self.alertView addSubview:self.titleLab];
        [self.alertView addSubview:self.messageLab];
        [self.alertView addSubview:self.replyBtn];
        [self.alertView addSubview:self.backBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(62);
        make.height.mas_offset(62);
        make.left.equalTo(weakSelf.alertView).with.offset(17);
        make.top.equalTo(weakSelf.alertView).with.offset(18);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coverImg.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.alertView).with.offset(30);
    }];
    [weakSelf.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab.mas_right).with.offset(3);
        make.bottom.equalTo(weakSelf.nameLab).with.offset(-4);
        make.width.mas_offset(22);
        make.height.mas_offset(11);
    }];
    [weakSelf.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.ageLab);
        make.left.equalTo(weakSelf.ageLab.mas_right).with.offset(2);
        make.width.mas_offset(10);
        make.height.mas_offset(10);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(13);
        make.height.mas_offset(14);
    }];
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coverImg);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(22);
        
    }];
    [weakSelf.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(7);
        make.left.equalTo(weakSelf.coverImg);
        make.height.mas_offset(100);
    }];
    [weakSelf.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.messageLab.mas_bottom).with.offset(18);
        make.width.mas_offset(138*KWIDTH);
        make.height.mas_offset(40);
        make.left.equalTo(weakSelf.alertView).with.offset(17);
    }];
    [weakSelf.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backBtn);
        make.width.mas_offset(138*KWIDTH);
        make.height.mas_offset(40);
        make.right.equalTo(weakSelf.alertView).with.offset(-17);
    }];
}

-(UIView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[UIView alloc] init];
        _alertView.userInteractionEnabled = YES;
    }
    return _alertView;
}

-(UIImageView *)coverImg
{
    if(!_coverImg)
    {
        _coverImg = [[UIImageView alloc] init];
        
    }
    return _coverImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        
    }
    return _nameLab;
}

-(UILabel *)ageLab
{
    if(!_ageLab)
    {
        _ageLab = [[UILabel alloc] init];
        _ageLab.font = [UIFont systemFontOfSize:10];
        _ageLab.textColor = [UIColor whiteColor];
        _ageLab.textAlignment = NSTextAlignmentCenter;
        _ageLab.backgroundColor = MainColor;
        _ageLab.layer.masksToBounds = YES;
        _ageLab.layer.cornerRadius = 3;
    }
    return _ageLab;
}

-(UIImageView *)sexImg
{
    if(!_sexImg)
    {
        _sexImg = [[UIImageView alloc] init];
        
    }
    return _sexImg;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = [UIFont systemFontOfSize:12];
        _contentLab.textColor = [UIColor colorWithHexString:@"333333"];
        //_contentLab.text = @"Just active";
    }
    return _contentLab;
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor colorWithHexString:@"333333"];
        _titleLab.text = @"Content";
    }
    return _titleLab;
}


-(UITextView *)messageLab
{
    if(!_messageLab)
    {
        _messageLab = [[UITextView alloc] init];
        _messageLab.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
//        _messageLab.numberOfLines = 0;
        _messageLab.editable = NO;
    }
    return _messageLab;
}

-(UIButton *)backBtn
{
    if(!_backBtn)
    {
        _backBtn = [[UIButton alloc] init];
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.cornerRadius = 20;
        _backBtn.backgroundColor = MainColor;
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_backBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_backBtn setTitle:@"Throw back" forState:normal];
        [_backBtn addTarget:self action:@selector(backbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UIButton *)replyBtn
{
    if(!_replyBtn)
    {
        _replyBtn = [[UIButton alloc] init];
        _replyBtn.layer.masksToBounds = YES;
        _replyBtn.layer.cornerRadius = 20;
        _replyBtn.backgroundColor = MainColor;
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_replyBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_replyBtn setTitle:@"Reply" forState:normal];
        [_replyBtn addTarget:self action:@selector(replybtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}

-(void)showAnimation{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)backbtnclick
{
    if (self.dismissClick) {
        self.dismissClick([NSString new]);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)replybtnclick
{
    if (self.replyClick) {
        self.replyClick(self.messageLab.text);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}


-(void)withrepylClick:(replyBlock)block
{
    _replyClick = block;
    
}

-(void)withDismissClick:(dismissBlock)block;
{
    _dismissClick = block;
}
@end
