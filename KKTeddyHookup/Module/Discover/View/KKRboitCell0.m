//
//  XTRobitCell0.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKRboitCell0.h"

@interface KKRboitCell0()
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *ageLab;
@property (nonatomic,strong) UILabel *contentLab;
@end

@implementation KKRboitCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.ageLab];
        [self.contentView addSubview:self.contentLab];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(KKDiscoverModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.nameLab.text = model.name?:@"";
    self.ageLab.text = model.age?:@"0";
    self.contentLab.text = model.signature?:@"";
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(17);
        make.height.mas_offset(14);
    }];
    [weakSelf.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.nameLab.mas_bottom);
        make.width.mas_offset(22);
        make.height.mas_offset(11);
        make.left.equalTo(weakSelf.nameLab.mas_right).with.offset(3);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(11);
    }];
}

#pragma mark - getters

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:18];
        _nameLab.textColor = [UIColor colorWithHexString:@"000000"];
        _nameLab.text = @"Heanr";
    }
    return _nameLab;
}

-(UILabel *)ageLab
{
    if(!_ageLab)
    {
        _ageLab = [[UILabel alloc] init];
        _ageLab.textAlignment = NSTextAlignmentCenter;
        _ageLab.textColor = [UIColor whiteColor];
        _ageLab.font = [UIFont systemFontOfSize:10];
        _ageLab.text = @"26";
        _ageLab.backgroundColor = MainColor;
        _ageLab.layer.masksToBounds = YES;
        _ageLab.layer.cornerRadius = 3;
    }
    return _ageLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.text = @"Too cheap sugar,after all,is not so sweet";
        _contentLab.textColor = [UIColor colorWithHexString:@"999999"];
        _contentLab.font = [UIFont systemFontOfSize:11];
    }
    return _contentLab;
}


@end
