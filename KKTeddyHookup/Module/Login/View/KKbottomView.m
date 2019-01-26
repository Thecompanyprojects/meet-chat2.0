//
//  bottomView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/17.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKbottomView.h"

@interface KKbottomView()
@property (nonatomic,strong) UIView *leftLine;
@property (nonatomic,strong) UIView *rightLine;
@property (nonatomic,strong) UILabel *titleLab;
@end

@implementation KKbottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftLine];
        [self addSubview:self.rightLine];
        [self addSubview:self.titleLab];
        [self addSubview:self.facebookBtn];
        [self addSubview:self.googleBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.width.mas_offset(120);
        make.height.mas_offset(14);
    }];
    [weakSelf.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.height.mas_offset(1);
        make.right.equalTo(weakSelf.titleLab.mas_left);
        make.centerY.equalTo(weakSelf.titleLab);
    }];
    [weakSelf.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.left.equalTo(weakSelf.titleLab.mas_right);
        make.height.mas_offset(1);
        make.centerY.equalTo(weakSelf.titleLab);
    }];
    [weakSelf.facebookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(38);
        make.height.mas_offset(38);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(24);
        make.left.equalTo(weakSelf).with.offset(124*KWIDTH);
    }];
    [weakSelf.googleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-124*KWIDTH);
        make.width.mas_offset(38);
        make.height.mas_offset(38);
        make.top.equalTo(weakSelf.facebookBtn);
    }];
}

#pragma mark - getters

-(UIView *)leftLine
{
    if(!_leftLine)
    {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    return _leftLine;
}

-(UIView *)rightLine
{
    if(!_rightLine)
    {
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    return _rightLine;
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.textColor = [UIColor colorWithHexString:@"D1D1D1"];
        _titleLab.text = @"Quick Login";
        
    }
    return _titleLab;
}

-(UIButton *)facebookBtn
{
    if(!_facebookBtn)
    {
        _facebookBtn = [[UIButton alloc] init];
        [_facebookBtn setImage:[UIImage imageNamed:@"facebook"] forState:normal];
    }
    return _facebookBtn;
}

-(UIButton *)googleBtn
{
    if(!_googleBtn)
    {
        _googleBtn = [[UIButton alloc] init];
        [_googleBtn setImage:[UIImage imageNamed:@"google"] forState:normal];
       
    }
    return _googleBtn;
}



@end
