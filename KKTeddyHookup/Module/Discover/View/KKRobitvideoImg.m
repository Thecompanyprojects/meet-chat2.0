//
//  XTRobitvideoImg.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKRobitvideoImg.h"

@implementation KKRobitvideoImg

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.videoImg];
        [self addSubview:self.maskImg];
        [self addSubview:self.playBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.maskImg setHidden:YES];
    [weakSelf.videoImg mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.width.mas_offset(18);
        make.height.mas_offset(18);
    }];
}

#pragma mark - getters

-(UIImageView *)videoImg
{
    if(!_videoImg)
    {
        _videoImg = [[UIImageView alloc] init];
        
    }
    return _videoImg;
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
    }
    return _playBtn;
}






@end
