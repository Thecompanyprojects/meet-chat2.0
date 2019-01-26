//
//  XTSettingCell.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/20.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKSettingCell.h"

@interface KKSettingCell()

@end

@implementation KKSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typeImg];
        [self.contentView addSubview:self.nameLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(17);
        make.height.mas_offset(17);
        make.left.equalTo(weakSelf).with.offset(28);
        make.centerY.equalTo(weakSelf);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.typeImg.mas_right).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-28);
    }];
}

#pragma mark - getters

-(UIImageView *)typeImg
{
    if(!_typeImg)
    {
        _typeImg = [[UIImageView alloc] init];
        _typeImg.image = [UIImage imageNamed:@"add"];
    }
    return _typeImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _nameLab;
}


@end
