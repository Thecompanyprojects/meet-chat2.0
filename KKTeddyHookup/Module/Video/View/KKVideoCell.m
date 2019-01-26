//
//  XTVideoCell.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKVideoCell.h"

@interface KKVideoCell()
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UIImageView *maskImg;
@property (nonatomic,strong) UIImageView *effView;
@property (nonatomic,strong) UIButton *playBtn;
@end

@implementation KKVideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bgImg];
        [self.contentView addSubview:self.maskImg];
        [self.contentView addSubview:self.effView];
        [self.contentView addSubview:self.playBtn];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(KKVideolistModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.effView setHidden:NO];
    [self.maskImg setHidden:YES];
    if (model.videopreview.count!=0) {
        NSString *ImgUrl = [[model.videopreview firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.bgImg sd_setImageWithURL:[NSURL URLWithString:ImgUrl] placeholderImage:[UIImage imageNamed:@"videoback"]];
        
    }
    else
    {
        self.bgImg.image = [UIImage imageNamed:@"videoback"];
    }
}

-(void)newSetmodel:(KKVideolistModel *)model
{
    [self.effView setHidden:YES];
    [self.maskImg setHidden:YES];
    if (model.videopreview.count!=0) {
        NSString *ImgUrl = [[model.videopreview firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.bgImg sd_setImageWithURL:[NSURL URLWithString:ImgUrl] placeholderImage:[UIImage imageNamed:@"videoback"]];
    }
}

-(UIImageView *)effView
{
    if(!_effView)
    {
        _effView = [[UIImageView alloc] init];
        _effView.image = [UIImage imageNamed:@"mengban"];
    }
    return _effView;
}

#pragma mark ---- 获取图片第一帧

- (UIImage *)firstFrameWithVideoURL:(NSURL *)url
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    //generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    //CGImageRelease(img);
    return nil;
}

-(NSString *)arcRandomArray:(NSArray *)video
{
    int value = arc4random() % video.count;
    NSString *str = [video objectAtIndex:value];
    return str;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    [weakSelf.maskImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    [weakSelf.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(42*KWIDTH);
        make.height.mas_offset(42*KWIDTH);
    }];
    [weakSelf.effView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.width.mas_offset(30);
        make.height.mas_offset(30);
    }];
}

#pragma mark - getters

-(UIImageView *)bgImg
{
    if(!_bgImg)
    {
        _bgImg = [[UIImageView alloc] init];
        _bgImg.layer.masksToBounds = YES;
        _bgImg.contentMode =  UIViewContentModeScaleAspectFill;
    }
    return _bgImg;
}

-(UIImageView *)maskImg
{
    if(!_maskImg)
    {
        _maskImg = [[UIImageView alloc] init];
        _maskImg.image = [UIImage imageNamed:@"maskview"];
    }
    return _maskImg;
}

-(UIButton *)playBtn
{
    if(!_playBtn)
    {
        _playBtn = [[UIButton alloc] init];
        [_playBtn setImage:[UIImage imageNamed:@"play"] forState:normal];
        [_playBtn addTarget:self action:@selector(playbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(void)playbtnClick
{
    [self.delegate myTabVClick:self];
}


@end
