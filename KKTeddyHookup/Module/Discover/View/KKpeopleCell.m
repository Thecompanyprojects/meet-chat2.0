//
//  peopleCell.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKpeopleCell.h"

@interface KKpeopleCell()
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) UIButton *changeBtn;
@end

@implementation KKpeopleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.coverImg];
        [self.contentView addSubview:self.changeBtn];
        [self setuplayout];
    }
    return self;
}


- (void)setModel:(KKDiscoverModel *)model {
    if (_model != model) {
        _model = model;
    }
    if (model.photopreview.count!=0) {

        [self.coverImg sd_setImageWithURL:[NSURL URLWithString:[model.photopreview firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        if (model.issayHi) {
            [self.changeBtn setImage:[UIImage imageNamed:@"hi2"] forState:normal];
        }
        else
        {
            [self.changeBtn setImage:[UIImage imageNamed:@"hi"] forState:normal];
        }
    }
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(126);
    }];
    [weakSelf.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(42);
        make.height.mas_offset(42);
        make.centerX.equalTo(weakSelf.coverImg);
        make.top.equalTo(weakSelf.coverImg.mas_bottom).with.offset(-21);
    }];
}

#pragma mark - getters

-(UIImageView *)coverImg
{
    if(!_coverImg)
    {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.layer.masksToBounds = YES;
        _coverImg.contentMode =  UIViewContentModeScaleAspectFill;
    }
    return _coverImg;
}

-(UIButton *)changeBtn
{
    if(!_changeBtn)
    {
        _changeBtn = [[UIButton alloc] init];
        [_changeBtn setImage:[UIImage imageNamed:@"hi"] forState:normal];
        [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _changeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        _changeBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    }
    return _changeBtn;
}

-(void)changeBtnClick
{
    [self.delegate myTabVClick:self];
}

@end
