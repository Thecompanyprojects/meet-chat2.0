//
//  XTEditorheaderView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKEditorheaderView.h"
#import "KKPersonModel.h"

@interface KKEditorheaderView()

@end

@implementation KKEditorheaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView0];
        [self addSubview:self.imgView1];
        [self addSubview:self.imgView2];
        [self addSubview:self.imgView3];
        [self addSubview:self.imgView4];
        [self addSubview:self.imgView5];
        [self setuplayout];
    }
    return self;
}

-(void)setheader:(KKPersonModel *)model
{
        switch (model.photos.count) {
            case 0:
            {
                [self.imgView0.addBtn setHidden:NO];
                [self.imgView1.addBtn setHidden:NO];
                [self.imgView2.addBtn setHidden:NO];
                [self.imgView3.addBtn setHidden:NO];
                [self.imgView4.addBtn setHidden:NO];
                [self.imgView5.addBtn setHidden:NO];
                
            }
                break;
            case 1:
            {
                [self.imgView0 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView0.addBtn setHidden:YES];
                [self.imgView1.addBtn setHidden:NO];
                [self.imgView2.addBtn setHidden:NO];
                [self.imgView3.addBtn setHidden:NO];
                [self.imgView4.addBtn setHidden:NO];
                [self.imgView5.addBtn setHidden:NO];
            }
                break;
            case 2:
            {
     
                [self.imgView0 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView0.addBtn setHidden:YES];
                [self.imgView1.addBtn setHidden:YES];
                
                [self.imgView2.addBtn setHidden:NO];
                [self.imgView3.addBtn setHidden:NO];
                [self.imgView4.addBtn setHidden:NO];
                [self.imgView5.addBtn setHidden:NO];
                
            }
                break;
            case 3:
            {
          
                [self.imgView0 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:2]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView0.addBtn setHidden:YES];
                [self.imgView1.addBtn setHidden:YES];
                [self.imgView2.addBtn setHidden:YES];
                [self.imgView3.addBtn setHidden:NO];
                [self.imgView4.addBtn setHidden:NO];
                [self.imgView5.addBtn setHidden:NO];
                
            }
                break;
            case 4:
            {
                [self.imgView0 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:2]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:3]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                
                [self.imgView0.addBtn setHidden:YES];
                [self.imgView1.addBtn setHidden:YES];
                [self.imgView2.addBtn setHidden:YES];
                [self.imgView3.addBtn setHidden:YES];
                [self.imgView4.addBtn setHidden:NO];
                [self.imgView5.addBtn setHidden:NO];
               
            }
                break;
            case 5:
            {
                [self.imgView0 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:2]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:3]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView4 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:4]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView0.addBtn setHidden:YES];
                [self.imgView1.addBtn setHidden:YES];
                [self.imgView2.addBtn setHidden:YES];
                [self.imgView3.addBtn setHidden:YES];
                [self.imgView4.addBtn setHidden:YES];
                [self.imgView5.addBtn setHidden:NO];
              
            }
                break;
            case 6:
            {
                
                [self.imgView0 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:2]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:3]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView4 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:4]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                [self.imgView5 sd_setImageWithURL:[NSURL URLWithString:[model.photos objectAtIndex:5]] placeholderImage:[UIImage imageNamed:@"head portrait"] options:SDWebImageRefreshCached];
                
                [self.imgView0.addBtn setHidden:YES];
                [self.imgView1.addBtn setHidden:YES];
                [self.imgView2.addBtn setHidden:YES];
                [self.imgView3.addBtn setHidden:YES];
                [self.imgView4.addBtn setHidden:YES];
                [self.imgView5.addBtn setHidden:YES];
            }
                break;
            default:
                break;
        }
   
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    [weakSelf.imgView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.width.mas_offset(kScreenWidth/3*2-2);
        make.height.mas_offset(kScreenWidth/3*2-2);
    }];
    [weakSelf.imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.width.mas_offset(kScreenWidth/3-2);
        make.height.mas_offset(kScreenWidth/3-2);
    }];
    [weakSelf.imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgView1.mas_bottom).with.offset(2);
        make.right.equalTo(weakSelf.imgView1);
        make.width.mas_offset(kScreenWidth/3-2);
        make.height.mas_offset(kScreenWidth/3-2);
    }];
    
    [weakSelf.imgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgView0);
        make.top.equalTo(weakSelf.imgView2.mas_bottom).with.offset(2);
        make.width.mas_offset(kScreenWidth/3-2);
        make.height.mas_offset(kScreenWidth/3-2);
    }];
    [weakSelf.imgView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgView3);
        make.right.equalTo(weakSelf.imgView0);
        make.width.mas_offset(kScreenWidth/3-2);
        make.height.mas_offset(kScreenWidth/3-2);
    }];
    [weakSelf.imgView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kScreenWidth/3-2);
        make.height.mas_offset(kScreenWidth/3-2);
        make.top.equalTo(weakSelf.imgView3);
        make.right.equalTo(weakSelf);
    }];
}

#pragma mark - getters

-(KKEditorImageView *)imgView0
{
    if(!_imgView0)
    {
        _imgView0 = [[KKEditorImageView alloc] init];
        _imgView0.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage0)];
        [_imgView0 addGestureRecognizer:singleTap];
    }
    return _imgView0;
}

-(KKEditorImageView *)imgView1
{
    if(!_imgView1)
    {
        _imgView1 = [[KKEditorImageView alloc] init];
        _imgView1.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage1)];
        [_imgView1 addGestureRecognizer:singleTap];
    }
    return _imgView1;
}

-(KKEditorImageView *)imgView2
{
    if(!_imgView2)
    {
        _imgView2 = [[KKEditorImageView alloc] init];
        _imgView2.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage2)];
        [_imgView2 addGestureRecognizer:singleTap];
    }
    return _imgView2;
}

-(KKEditorImageView *)imgView3
{
    if(!_imgView3)
    {
        _imgView3 = [[KKEditorImageView alloc] init];
        _imgView3.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage3)];
        [_imgView3 addGestureRecognizer:singleTap];
    }
    return _imgView3;
}

-(KKEditorImageView *)imgView4
{
    if(!_imgView4)
    {
        _imgView4 = [[KKEditorImageView alloc] init];
        _imgView4.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage4)];
        [_imgView4 addGestureRecognizer:singleTap];
    }
    return _imgView4;
}

-(KKEditorImageView *)imgView5
{
    if(!_imgView5)
    {
        _imgView5 = [[KKEditorImageView alloc] init];
        _imgView5.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage5)];
        [_imgView5 addGestureRecognizer:singleTap];
    }
    return _imgView5;
}

-(void)onClickImage0
{
    if (self.imgView0.addBtn.hidden==YES) {
        [self.delegate myTabVClick:@"0"];
    }
}

-(void)onClickImage1
{
    if (self.imgView1.addBtn.hidden==YES) {
        [self.delegate myTabVClick:@"1"];
    }
}

-(void)onClickImage2
{
    if (self.imgView2.addBtn.hidden==YES) {
         [self.delegate myTabVClick:@"2"];
    }
}

-(void)onClickImage3
{
    if (self.imgView3.addBtn.hidden==YES) {
        [self.delegate myTabVClick:@"3"];
    }
}

-(void)onClickImage4
{
    if (self.imgView4.addBtn.hidden==YES) {
        [self.delegate myTabVClick:@"4"];
    }
}

-(void)onClickImage5
{
    if (self.imgView5.addBtn.hidden==YES) {
        [self.delegate myTabVClick:@"5"];
    }
}

@end
