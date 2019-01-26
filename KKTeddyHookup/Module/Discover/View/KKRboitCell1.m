//
//  XTRobitCell1.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKRboitCell1.h"
#import "KKRobitvideoImg.h"

@interface KKRboitCell1()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) KKRobitvideoImg *videoImg0;
@property (nonatomic,strong) KKRobitvideoImg *videoImg1;
@property (nonatomic,strong) KKRobitvideoImg *videoImg2;
@property (nonatomic,strong) KKRobitvideoImg *videoImg3;
@property (nonatomic,strong) UIImageView *effView0;
@property (nonatomic,strong) UIImageView *effView1;
@property (nonatomic,strong) UIImageView *effView2;
@property (nonatomic,strong) UIImageView *effView3;
@end

@implementation KKRboitCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.videoImg0];
        [self.contentView addSubview:self.videoImg1];
        [self.contentView addSubview:self.videoImg2];
        [self.contentView addSubview:self.videoImg3];
        [self.contentView addSubview:self.effView0];
        [self.contentView addSubview:self.effView1];
        [self.contentView addSubview:self.effView2];
        [self.contentView addSubview:self.effView3];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(KKDiscoverModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    if (model.videopreview.count==1) {
        
        [self.videoImg0 setHidden:NO];
        [self.videoImg1 setHidden:YES];
        [self.videoImg2 setHidden:YES];
        [self.videoImg3 setHidden:YES];
        
        if ([KKUserModel sharedUserModel].isVip) {
            [self.effView0 setHidden:YES];
        }
        else
        {
            [self.effView0 setHidden:NO];
        }
        [self.effView1 setHidden:YES];
        [self.effView2 setHidden:YES];
        [self.effView3 setHidden:YES];
        
        NSString *videoUrl0 = [model.videopreview firstObject];
        NSString *NewUrl0 = [videoUrl0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.videoImg0.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl0] placeholderImage:[UIImage imageNamed:@"videoback"]];
    }
    if (model.videopreview.count==2) {
        
        [self.videoImg0 setHidden:NO];
        [self.videoImg2 setHidden:NO];
        [self.videoImg2 setHidden:YES];
        [self.videoImg3 setHidden:YES];
        if ([KKUserModel sharedUserModel].isVip) {
            [self.effView0 setHidden:YES];
            [self.effView1 setHidden:YES];
        }
        else
        {
            [self.effView0 setHidden:NO];
            [self.effView1 setHidden:NO];
        }
        [self.effView2 setHidden:YES];
        [self.effView3 setHidden:YES];
        
        NSString *videoUrl0 = [model.videopreview firstObject];
        NSString *videoUrl1 = [model.videopreview objectAtIndex:1];
        NSString *NewUrl0 = [videoUrl0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *NewUrl1 = [videoUrl1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        

       [self.videoImg0.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl0] placeholderImage:[UIImage imageNamed:@"videoback"]];
       [self.videoImg1.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl1] placeholderImage:[UIImage imageNamed:@"videoback"]];
        
    }
    if (model.videopreview.count==3) {
        
        [self.videoImg0 setHidden:NO];
        [self.videoImg1 setHidden:NO];
        [self.videoImg2 setHidden:NO];
        [self.videoImg3 setHidden:YES];
        
        if ([KKUserModel sharedUserModel].isVip) {
            [self.effView0 setHidden:YES];
            [self.effView1 setHidden:YES];
            [self.effView2 setHidden:YES];
        }
        else
        {
            [self.effView0 setHidden:NO];
            [self.effView1 setHidden:NO];
            [self.effView2 setHidden:NO];
        }
        [self.effView3 setHidden:YES];
        
        NSString *videoUrl0 = [model.videopreview firstObject];
        NSString *videoUrl1 = [model.videopreview objectAtIndex:1];
        NSString *videoUrl2 = [model.videopreview objectAtIndex:2];
        NSString *NewUrl0 = [videoUrl0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *NewUrl1 = [videoUrl1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *NewUrl2 = [videoUrl2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.videoImg0.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl0] placeholderImage:[UIImage imageNamed:@"videoback"]];
        [self.videoImg1.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl1] placeholderImage:[UIImage imageNamed:@"videoback"]];
        [self.videoImg2.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl2] placeholderImage:[UIImage imageNamed:@"videoback"]];
    }
    if (model.videopreview.count>=4) {
        [self.videoImg0 setHidden:NO];
        [self.videoImg1 setHidden:NO];
        [self.videoImg2 setHidden:NO];
        [self.videoImg3 setHidden:NO];
        if ([KKUserModel sharedUserModel].isVip) {
            [self.effView0 setHidden:YES];
            [self.effView1 setHidden:YES];
            [self.effView2 setHidden:YES];
            [self.effView3 setHidden:YES];
        }
        else
        {
            [self.effView0 setHidden:NO];
            [self.effView1 setHidden:NO];
            [self.effView2 setHidden:NO];
            [self.effView3 setHidden:NO];
        }

        NSString *videoUrl0 = [model.videopreview firstObject];
        NSString *videoUrl1 = [model.videopreview objectAtIndex:1];
        NSString *videoUrl2 = [model.videopreview objectAtIndex:2];
        NSString *videoUrl3 = [model.videopreview objectAtIndex:3];
        
        NSString *NewUrl0 = [videoUrl0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *NewUrl1 = [videoUrl1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *NewUrl2 = [videoUrl2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *NewUrl3 = [videoUrl3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [self.videoImg0.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl0] placeholderImage:[UIImage imageNamed:@"videoback"]];
        [self.videoImg1.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl1] placeholderImage:[UIImage imageNamed:@"videoback"]];
        [self.videoImg2.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl2] placeholderImage:[UIImage imageNamed:@"videoback"]];
        [self.videoImg3.videoImg sd_setImageWithURL:[NSURL URLWithString:NewUrl3] placeholderImage:[UIImage imageNamed:@"videoback"]];
    }
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(17);
        make.left.equalTo(weakSelf).with.offset(20);
        make.centerX.equalTo(weakSelf);
        make.height.mas_offset(14);
    }];
    [weakSelf.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.height.mas_offset(1);
        make.width.mas_offset(20);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(5);
    }];
    [weakSelf.videoImg0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.line.mas_bottom).with.offset(10);
        make.width.mas_offset(68);
        make.height.mas_offset(82);
    }];
    [weakSelf.videoImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(68);
        make.height.mas_offset(82);
        make.top.equalTo(weakSelf.videoImg0);
        make.left.equalTo(weakSelf.videoImg0.mas_right).with.offset(10);
    }];
    [weakSelf.videoImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.videoImg1.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.videoImg0);
        make.width.mas_offset(68);
        make.height.mas_offset(82);
    }];
    [weakSelf.videoImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.videoImg2.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.videoImg0);
        make.width.mas_offset(68);
        make.height.mas_offset(82);
    }];
    
    [weakSelf.effView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.videoImg0);
        make.right.equalTo(weakSelf.videoImg0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    [weakSelf.effView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.videoImg1);
        make.right.equalTo(weakSelf.videoImg1);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    [weakSelf.effView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.videoImg2);
        make.top.equalTo(weakSelf.videoImg2);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    [weakSelf.effView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.videoImg3);
        make.right.equalTo(weakSelf.videoImg3);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"Video";
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor blackColor];
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

-(KKRobitvideoImg *)videoImg0
{
    if(!_videoImg0)
    {
        _videoImg0 = [[KKRobitvideoImg alloc] init];
        _videoImg0.userInteractionEnabled = YES;
        _videoImg0.maskImg.userInteractionEnabled = YES;
        _videoImg0.videoImg.userInteractionEnabled = YES;
        [_videoImg0.playBtn addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick0:)];
        [_videoImg0 addGestureRecognizer:singleTap];
    }
    return _videoImg0;
}

-(KKRobitvideoImg *)videoImg1
{
    if(!_videoImg1)
    {
        _videoImg1 = [[KKRobitvideoImg alloc] init];
        _videoImg1.userInteractionEnabled = YES;
        _videoImg1.maskImg.userInteractionEnabled = YES;
        _videoImg1.videoImg.userInteractionEnabled = YES;
        [_videoImg1.playBtn addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick1:)];
        [_videoImg1 addGestureRecognizer:singleTap];
    }
    return _videoImg1;
}

-(KKRobitvideoImg *)videoImg2
{
    if(!_videoImg2)
    {
        _videoImg2 = [[KKRobitvideoImg alloc] init];
        _videoImg2.userInteractionEnabled = YES;
        _videoImg2.maskImg.userInteractionEnabled = YES;
        _videoImg2.videoImg.userInteractionEnabled = YES;
        [_videoImg2.playBtn addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick2:)];
        [_videoImg2 addGestureRecognizer:singleTap];
    }
    return _videoImg2;
}

-(KKRobitvideoImg *)videoImg3
{
    if(!_videoImg3)
    {
        _videoImg3 = [[KKRobitvideoImg alloc] init];
        _videoImg3.userInteractionEnabled = YES;
        _videoImg3.maskImg.userInteractionEnabled = YES;
        _videoImg3.videoImg.userInteractionEnabled = YES;
        [_videoImg3.playBtn addTarget:self action:@selector(btn3click) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick3:)];
        [_videoImg3 addGestureRecognizer:singleTap];

    }
    return _videoImg3;
}

-(UIImageView *)effView0
{
    if(!_effView0)
    {
        _effView0 = [[UIImageView alloc] init];
        _effView0.image = [UIImage imageNamed:@"mengban"];
        _effView0.hidden = YES;
        _effView0.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick0:)];
        [_effView0 addGestureRecognizer:singleTap];

    }
    return _effView0;
}

-(UIImageView *)effView1
{
    if(!_effView1)
    {
        _effView1 = [[UIImageView alloc] init];
        _effView1.image = [UIImage imageNamed:@"mengban"];
        _effView1.hidden = YES;
        _effView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick1:)];
        [_effView1 addGestureRecognizer:singleTap];

    }
    return _effView1;
}

-(UIImageView *)effView2
{
    if(!_effView2)
    {
        _effView2 = [[UIImageView alloc] init];
        _effView2.image = [UIImage imageNamed:@"mengban"];
        _effView2.userInteractionEnabled = YES;
        _effView2.hidden = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick2:)];
        [_effView2 addGestureRecognizer:singleTap];

    }
    return _effView2;
}

-(UIImageView *)effView3
{
    if(!_effView3)
    {
        _effView3 = [[UIImageView alloc] init];
        _effView3.image = [UIImage imageNamed:@"mengban"];
        _effView3.userInteractionEnabled = YES;
        _effView3.hidden = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoChooseClick3:)];
        [_effView3 addGestureRecognizer:singleTap];

    }
    return _effView3;
}

#pragma mark - 实现方法

-(void)btn0click
{
    NSString *url = [self.model.video firstObject];
    [self.delegate myTabVClick:url];
}

-(void)btn1click
{
    NSString *url = [self.model.video objectAtIndex:1];
    [self.delegate myTabVClick:url];
}

-(void)btn2click
{
    NSString *url = [self.model.video objectAtIndex:2];
    [self.delegate myTabVClick:url];
}

-(void)btn3click
{
    NSString *url = [self.model.video objectAtIndex:3];
    [self.delegate myTabVClick:url];
}

-(void)videoChooseClick0:(UIGestureRecognizer *)gestureRecognizer
{
    NSString *url = [self.model.video firstObject];
    [self.delegate myTabVClick:url];
}

-(void)videoChooseClick1:(UIGestureRecognizer *)gestureRecognizer
{
    NSString *url = [self.model.video objectAtIndex:1];
    [self.delegate myTabVClick:url];
}

-(void)videoChooseClick2:(UIGestureRecognizer *)gestureRecognizer
{
    NSString *url = [self.model.video objectAtIndex:2];
    [self.delegate myTabVClick:url];
}

-(void)videoChooseClick3:(UIGestureRecognizer *)gestureRecognizer
{
    NSString *url = [self.model.video objectAtIndex:3];
    [self.delegate myTabVClick:url];
}

@end
