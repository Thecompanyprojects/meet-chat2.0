//
//  XTPersonalCell1.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPersonalCell1.h"
#import "KKLikedmedbManager.h"
#import "KKDiscoverModel.h"

@interface KKPersonalCell1()
@property (nonatomic,strong) UILabel *personLab;
@property (nonatomic,strong) UILabel *numberLab;
@property (nonatomic,strong) UIImageView *infoImg0;
@property (nonatomic,strong) UIImageView *infoImg1;
@property (nonatomic,strong) UIImageView *infoImg2;
@property (nonatomic,strong) UIImageView *infoImg3;
@property (nonatomic,strong) UIImageView *infoImg4;
@end

@implementation KKPersonalCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.personLab];
        [self.contentView addSubview:self.numberLab];
        [self.contentView addSubview:self.infoImg0];
        [self.contentView addSubview:self.infoImg1];
        [self.contentView addSubview:self.infoImg2];
        [self.contentView addSubview:self.infoImg3];
        [self.contentView addSubview:self.infoImg4];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(KKPersonModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    NSMutableArray *arr = [[KKLikedmedbManager sharedClient] loaddata];
    
    if (arr.count==0) {
        [self.infoImg0 setHidden:YES];
        [self.infoImg1 setHidden:YES];
        [self.infoImg2 setHidden:YES];
        [self.infoImg3 setHidden:YES];
        [self.infoImg4 setHidden:YES];
    }
    if (arr.count==1) {
        [self.infoImg0 setHidden:NO];
        [self.infoImg1 setHidden:YES];
        [self.infoImg2 setHidden:YES];
        [self.infoImg3 setHidden:YES];
        [self.infoImg4 setHidden:NO];
        KKDiscoverModel *model0 = [arr firstObject];
        NSArray *photopreview = model0.photopreview;
        if (photopreview.count!=0) {
            [self.infoImg0 sd_setImageWithURL:[NSURL URLWithString:[photopreview firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        [self.infoImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.infoImg0.mas_right).with.offset(-10);
            make.top.equalTo(self.infoImg0);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
        }];
    }
    if (arr.count==2) {
        [self.infoImg0 setHidden:NO];
        [self.infoImg1 setHidden:NO];
        [self.infoImg2 setHidden:YES];
        [self.infoImg3 setHidden:YES];
        [self.infoImg4 setHidden:NO];
        KKDiscoverModel *model0 = [arr firstObject];
        NSArray *photopreview0 = model0.photopreview;
        if (photopreview0.count!=0) {
            [self.infoImg0 sd_setImageWithURL:[NSURL URLWithString:[photopreview0 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        
        KKDiscoverModel *model1 = [arr objectAtIndex:1];
        NSArray *photopreview1 = model1.photopreview;
        if (photopreview1.count!=0) {
            [self.infoImg1 sd_setImageWithURL:[NSURL URLWithString:[photopreview1 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        [self.infoImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.infoImg1.mas_right).with.offset(-10);
            make.top.equalTo(self.infoImg0);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
        }];
        
    }
    if (arr.count==3) {
        [self.infoImg0 setHidden:NO];
        [self.infoImg1 setHidden:NO];
        [self.infoImg2 setHidden:NO];
        [self.infoImg3 setHidden:YES];
        [self.infoImg4 setHidden:NO];
        KKDiscoverModel *model0 = [arr firstObject];
        NSArray *photopreview0 = model0.photopreview;
        if (photopreview0.count!=0) {
            [self.infoImg0 sd_setImageWithURL:[NSURL URLWithString:[photopreview0 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        
        KKDiscoverModel *model1 = [arr objectAtIndex:1];
        NSArray *photopreview1 = model1.photopreview;
        if (photopreview1.count!=0) {
            [self.infoImg1 sd_setImageWithURL:[NSURL URLWithString:[photopreview1 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        
        KKDiscoverModel *model2 = [arr objectAtIndex:2];
        NSArray *photopreview2 = model2.photopreview;
        if (photopreview2.count!=0) {
            [self.infoImg2 sd_setImageWithURL:[NSURL URLWithString:[photopreview2 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        [self.infoImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.infoImg2.mas_right).with.offset(-10);
            make.top.equalTo(self.infoImg0);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
        }];
        
    }
    if (arr.count>=4) {
        [self.infoImg0 setHidden:NO];
        [self.infoImg1 setHidden:NO];
        [self.infoImg2 setHidden:NO];
        [self.infoImg3 setHidden:NO];
        [self.infoImg4 setHidden:NO];
        KKDiscoverModel *model0 = [arr firstObject];
        NSArray *photopreview0 = model0.photopreview;
        if (photopreview0.count!=0) {
            [self.infoImg0 sd_setImageWithURL:[NSURL URLWithString:[photopreview0 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        
        KKDiscoverModel *model1 = [arr objectAtIndex:1];
        NSArray *photopreview1 = model1.photopreview;
        if (photopreview1.count!=0) {
            [self.infoImg1 sd_setImageWithURL:[NSURL URLWithString:[photopreview1 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        
        KKDiscoverModel *model2 = [arr objectAtIndex:2];
        NSArray *photopreview2 = model2.photopreview;
        if (photopreview2.count!=0) {
            [self.infoImg2 sd_setImageWithURL:[NSURL URLWithString:[photopreview2 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        
        KKDiscoverModel *model3 = [arr objectAtIndex:3];
        NSArray *photopreview3 = model3.photopreview;
        if (photopreview3.count!=0) {
            [self.infoImg3 sd_setImageWithURL:[NSURL URLWithString:[photopreview3 firstObject]] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
    }
    
    self.numberLab.text = [NSString stringWithFormat:@"%lu%@%@",(unsigned long)arr.count,@" ",@"people"];
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.personLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(19);
        make.top.equalTo(weakSelf).with.offset(16);
    }];

    [weakSelf.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf).with.offset(16);
    }];
    [weakSelf.infoImg0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf.personLab.mas_bottom).with.offset(14);
    }];
    [weakSelf.infoImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.infoImg0);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.left.equalTo(weakSelf.infoImg0.mas_right).with.offset(-10);
    }];
    [weakSelf.infoImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.infoImg1.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.infoImg0);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    [weakSelf.infoImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.infoImg2.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.infoImg0);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    [weakSelf.infoImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.infoImg3.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.infoImg0);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
}

#pragma mark - getters

-(UILabel *)personLab
{
    if(!_personLab)
    {
        _personLab = [[UILabel alloc] init];
        _personLab.text = @"People who like me";
        _personLab.textColor = [UIColor colorWithHexString:@"333333"];
        _personLab.font = [UIFont systemFontOfSize:14];
    }
    return _personLab;
}

-(UILabel *)numberLab
{
    if(!_numberLab)
    {
        _numberLab = [[UILabel alloc] init];
        _numberLab.font = [UIFont systemFontOfSize:14];
        _numberLab.textColor = MainColor;
    }
    return _numberLab;
}

-(UIImageView *)infoImg0
{
    if(!_infoImg0)
    {
        _infoImg0 = [[UIImageView alloc] init];
        _infoImg0.layer.masksToBounds = YES;
        _infoImg0.layer.borderWidth = 1;
        _infoImg0.layer.borderColor = [UIColor whiteColor].CGColor;
        _infoImg0.layer.cornerRadius = 20;
    }
    return _infoImg0;
}

-(UIImageView *)infoImg1
{
    if(!_infoImg1)
    {
        _infoImg1 = [[UIImageView alloc] init];
        _infoImg1.layer.masksToBounds = YES;
        _infoImg1.layer.borderWidth = 1;
        _infoImg1.layer.borderColor = [UIColor whiteColor].CGColor;
        _infoImg1.layer.cornerRadius = 20;
    }
    return _infoImg1;
}

-(UIImageView *)infoImg2
{
    if(!_infoImg2)
    {
        _infoImg2 = [[UIImageView alloc] init];
        _infoImg2.layer.masksToBounds = YES;
        _infoImg2.layer.borderWidth = 1;
        _infoImg2.layer.borderColor = [UIColor whiteColor].CGColor;
        _infoImg2.layer.cornerRadius = 20;
    }
    return _infoImg2;
}

-(UIImageView *)infoImg3
{
    if(!_infoImg3)
    {
        _infoImg3 = [[UIImageView alloc] init];
        _infoImg3.layer.masksToBounds = YES;
        _infoImg3.layer.borderWidth = 1;
        _infoImg3.layer.borderColor = [UIColor whiteColor].CGColor;
        _infoImg3.layer.cornerRadius = 20;
    }
    return _infoImg3;
}

-(UIImageView *)infoImg4
{
    if(!_infoImg4)
    {
        _infoImg4 = [[UIImageView alloc] init];
        _infoImg4.image = [UIImage imageNamed:@"更多"];
    }
    return _infoImg4;
}


@end

