//
//  XTPersonalCell2.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPersonalCell2.h"

@interface KKPersonalCell2()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *line;
@end

@implementation KKPersonalCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.line];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(20);
        make.height.mas_offset(12);
    }];
    [weakSelf.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(4);
        make.height.mas_offset(1);
        make.width.mas_offset(20);
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"Information";
        _titleLab.textColor = [UIColor colorWithHexString:@"000000"];
        _titleLab.font = [UIFont systemFontOfSize:16];
        
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



@end
