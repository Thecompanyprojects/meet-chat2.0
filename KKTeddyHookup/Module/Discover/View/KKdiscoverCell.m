//
//  discoverCell.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/17.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKdiscoverCell.h"

@interface KKdiscoverCell()
@property (nonatomic,strong) UIButton *changeBtn;
@property (nonatomic,strong) UIImageView *effView;
@end

@implementation KKdiscoverCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.coverImg];
        [self.contentView addSubview:self.effView];
        [self.contentView addSubview:self.changeBtn];
        [self setuplayout];
    }
    return self;
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
    
    [weakSelf.effView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
}

- (void)newsetModel:(KKDiscoverModel *)model
{
    [self.effView setHidden:YES];
    if (model.photopreview.count!=0) {
        NSString *imgUrl = [[model.photopreview firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.coverImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"backImg2"]];
    }
    else
    {
        self.coverImg.image = [UIImage imageNamed:@"backImg2"];
    }
    
    if (model.issayHi) {
        [self.changeBtn setImage:[UIImage imageNamed:@"hi2"] forState:normal];
    }
    else
    {
        [self.changeBtn setImage:[UIImage imageNamed:@"hi"] forState:normal];
    }
}

- (void)setModel:(KKDiscoverModel *)model withIndex:(NSIndexPath *)index{

    KKShowsubscribeModel *submodel = [KKShowsubscribeModel sharedShowsubModel];
    NSString *indexrstr = submodel.discover_user_count;
    int indexr = [indexrstr intValue];
    if (indexr==0) {
        indexr = 20;
    }
    if (index.row<indexr) {
        self.effView.hidden = YES;
        if (model.photopreview.count!=0) {
            NSString *imgUrl = [[model.photopreview firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [self.coverImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
        else
        {
            self.coverImg.image = [UIImage imageNamed:@"backImg2"];
        }
    }
    else
    {
        if (model.photopreview.count!=0) {
            self.effView.hidden = NO;
            if ([[KKShowsubscribeModel sharedShowsubModel] isNewSub]) {
                self.effView.image = [UIImage imageNamed:@"角标01"];
            }
            else
            {
                self.effView.image = [UIImage imageNamed:@"mengban"];
            }
            NSString *imgUrl = [[model.photopreview firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [self.coverImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"backImg2"]];
        }
    }
    if (model.issayHi) {
         [self.changeBtn setImage:[UIImage imageNamed:@"hi2"] forState:normal];
    }
    else
    {
         [self.changeBtn setImage:[UIImage imageNamed:@"hi"] forState:normal];
    }
}


#pragma mark - getters


-(UIImageView *)effView
{
    if(!_effView)
    {
        _effView = [[UIImageView alloc] init];
        _effView.image = [UIImage imageNamed:@"mengban"];
    }
    return _effView;
}


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
        [_changeBtn addTarget:self action:@selector(changebtnClick) forControlEvents:UIControlEventTouchUpInside];
        _changeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        _changeBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;

    }
    return _changeBtn;
}

-(void)changebtnClick
{
    [self.delegate myTabVClick:self];
}

@end
