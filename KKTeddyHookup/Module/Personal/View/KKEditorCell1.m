//
//  XTEditorCell1.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKEditorCell1.h"

@interface KKEditorCell1()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIImageView *iconImg;

@end

@implementation KKEditorCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.addImg];
        [self.contentView addSubview:self.contentLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(19);
        make.height.mas_offset(22);
        make.right.equalTo(weakSelf).with.offset(-20);
    }];
    [weakSelf.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.height.mas_offset(1);
        make.width.mas_offset(20);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(5);
    }];
    [weakSelf.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(17);
        make.height.mas_offset(17);
        make.top.equalTo(weakSelf.line.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.titleLab);
    }];
    [weakSelf.addImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(4);
        make.height.mas_offset(4);
        make.left.equalTo(weakSelf.iconImg.mas_right).with.offset(20);
        make.centerY.equalTo(weakSelf.iconImg);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iconImg);
        make.left.equalTo(weakSelf.addImg.mas_right).with.offset(3);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.height.mas_offset(16);
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor colorWithHexString:@"000000"];
        _titleLab.text = @"Signature";
    }
    return _titleLab;
}

-(UIView *)line
{
    if(!_line)
    {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MainColor;
    }
    return _line;
}

-(UIImageView *)iconImg
{
    if(!_iconImg)
    {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"signature"];
    }
    return _iconImg;
}

-(UIImageView *)addImg
{
    if(!_addImg)
    {
        _addImg = [[UIImageView alloc] init];
        _addImg.image = [UIImage imageNamed:@"add"];
    }
    return _addImg;
}


-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.textColor = [UIColor colorWithHexString:@"D6D6D6"];
    }
    return _contentLab;
}

@end
