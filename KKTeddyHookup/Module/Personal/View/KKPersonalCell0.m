//
//  XTPersonalCell0.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPersonalCell0.h"

@interface KKPersonalCell0()
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *ageLab;
@property (nonatomic,strong) UILabel *contentLab;
@end

@implementation KKPersonalCell0

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

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(15);
        make.height.mas_offset(19);
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

- (void)setModel:(KKPersonModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.nameLab.text = model.name?:@"";
    self.ageLab.text = model.age?:@"0";
    if (model.signature.length==0) {
        self.contentLab.text = @"Edit personalized signature";
        self.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
    }
    else
    {
        self.contentLab.text = model.signature;
        self.contentLab.textColor = [UIColor colorWithHexString:@"999999"];
    }
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
        _contentLab.font = [UIFont systemFontOfSize:12];
    }
    return _contentLab;
}





@end
