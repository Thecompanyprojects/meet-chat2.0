//
//  TTUpdateView.m
//  VideoPlayer
//
//  Created by KevinXu on 2018/11/22.
//  Copyright © 2018 KevinXu. All rights reserved.
//

#define TTHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define TTUpdateViewTag 8368573489

#import "TTUpdateView.h"
#import "YYText/YYText.h"

@interface TTUpdateView ()

// 背景遮照
@property (nonatomic, strong) UIView        *maskView;
// 关闭按钮
@property (nonatomic, strong) UIButton      *closeButton;
// 更新按钮
@property (nonatomic, strong) UIButton      *updateButton;
// 图片框
@property (nonatomic, strong) UIImageView   *iconImageView;
// 滚动容器
@property (nonatomic, strong) UIScrollView  *contentScrollView;
// 更新内容
@property (nonatomic, strong) UILabel       *infoLabel;

// 回调
@property (nonatomic, copy) void (^handleBlock)(BOOL update);

@end

@implementation TTUpdateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

#pragma mark - 更新
- (void)updateButtonAction:(UIButton *)sender {
    [self dismissView];
    if (self.handleBlock) {
        self.handleBlock(YES);
        [[XYLogManager shareManager] addLogKey1:@"update" key2:@"click" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
    }
}

#pragma mark - 关闭
- (void)closeButtonAction:(UIButton *)sender {
    [self dismissView];
    if (self.handleBlock) {
        self.handleBlock(NO);
        [[XYLogManager shareManager] addLogKey1:@"update" key2:@"click" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
    }
}

#pragma mark - 关闭
- (void)maskViewTapEnent:(UITapGestureRecognizer *)sender {
    [self dismissView];
    if (self.handleBlock) {
        self.handleBlock(NO);
        [[XYLogManager shareManager] addLogKey1:@"update" key2:@"click" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
    }
}

+ (void)showUpdateViewUpdate:(BOOL)updateNow handleBlock:(void (^)(BOOL))handleBlock {
    [self showUpdateViewWithInfo:nil shouldUpdate:updateNow handleBlock:handleBlock];
}

+ (void)showUpdateViewWithInfo:(NSString *)info shouldUpdate:(BOOL)updateNow handleBlock:(void (^)(BOOL))handleBlock {
    [self showUpdateViewWithInfo:info infoTextAlignment:NSTextAlignmentCenter shouldUpdate:updateNow handleBlock:handleBlock];
}

+ (void)showUpdateViewWithInfo:(NSString *)info infoTextAlignment:(NSTextAlignment)textAlignment shouldUpdate:(BOOL)updateNow handleBlock:(void (^)(BOOL))handleBlock {
    [self showUpdateViewWithInfo:info infoTextAlignment:textAlignment headerImageURL:nil shouldUpdate:updateNow handleBlock:handleBlock];
}

+ (void)showUpdateViewWithInfo:(NSString *)info infoTextAlignment:(NSTextAlignment)textAlignment headerImageURL:(NSString *)imageUrl shouldUpdate:(BOOL)updateNow handleBlock:(void (^)(BOOL))handleBlock {
    [self showUpdateViewWithInfo:info infoTextAlignment:textAlignment headerImageURL:imageUrl updateButtonText:nil shouldUpdate:updateNow handleBlock:handleBlock];
}

+ (void)showUpdateViewWithInfo:(NSString *)info infoTextAlignment:(NSTextAlignment)textAlignment headerImageURL:(NSString *)imageUrl updateButtonText:(NSString *)updateText shouldUpdate:(BOOL)updateNow handleBlock:(void (^)(BOOL))handleBlock {
    
    [[XYLogManager shareManager] addLogKey1:@"update" key2:@"show" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    TTUpdateView *updateView = nil;
    if ([keyWindow viewWithTag:TTUpdateViewTag]) {
        updateView = (TTUpdateView *)[keyWindow viewWithTag:TTUpdateViewTag];
        [updateView.maskView removeFromSuperview];
        [updateView removeFromSuperview];
    } else {
        updateView = [[TTUpdateView alloc] init];
    }
    
    updateView.closeButton.hidden = updateNow;
    updateView.maskView.gestureRecognizers.lastObject.enabled = !updateNow;
    
    if (imageUrl && imageUrl.length > 0) {
        if ([imageUrl hasPrefix:@"http"]) {
            [updateView.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"update_header"]];
        } else {
            updateView.iconImageView.image = [UIImage imageNamed:imageUrl];
        }
    }
    
    if (!info || info.length <= 0) {
        info = TTDefaultUpdateTipsString;
    }
   
    if (updateText) {
        [updateView.updateButton setTitle:updateText forState:UIControlStateNormal];
    }
    
    updateView.handleBlock = handleBlock;
    
    NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:info];
    stringM.yy_font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    stringM.yy_lineSpacing = 6;
    stringM.yy_color = TTHexColor(0x333333);
    if (textAlignment < 0 || textAlignment > 2) {
        textAlignment = NSTextAlignmentCenter;
    }
    stringM.yy_alignment = textAlignment;
    
    updateView.infoLabel.attributedText = stringM;
    

    CGFloat updateViewWith = (keyWindow.bounds.size.width * (320.0/375.0));
    CGFloat updateViewX = (keyWindow.bounds.size.width - updateViewWith)/2.0;
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(updateViewWith * 0.95 * 0.86, CGFLOAT_MAX) text:stringM];
    CGFloat infoTextHeight = layout.textBoundingSize.height;
    if (infoTextHeight >= keyWindow.bounds.size.height * 0.3) {
        infoTextHeight = keyWindow.bounds.size.height * 0.3;
    }
    CGFloat updateViewHeight = (54 + 37 + 25 + 40 + 6 + updateViewWith*(83.0/330.0) + infoTextHeight);
    CGFloat updateViewY = (keyWindow.bounds.size.height - updateViewHeight)/2.0;
    
    updateView.frame = CGRectMake(updateViewX, updateViewY, updateViewWith, updateViewHeight);
    
    updateView.maskView.alpha = 0;
    updateView.maskView.frame = keyWindow.bounds;
    updateView.alpha = 0;
    updateView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -300);
    
    [keyWindow addSubview:updateView.maskView];
    [keyWindow addSubview:updateView];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        updateView.maskView.alpha = 0.6;
        updateView.alpha = 1.0;
        updateView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)dismissUpdateView {
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    TTUpdateView *updateView = (TTUpdateView *)[keyWindow viewWithTag:TTUpdateViewTag];
    if (!updateView) {
        return;
    }
    
    if (updateView.closeButton.hidden) {
        return;
    }
    
    [updateView dismissView];
}

- (void)dismissView {
    
    if (self.closeButton.hidden) {
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -300);
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)initSubviews {
   
    self.tag = TTUpdateViewTag;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    self.closeButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"update_close"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn;
    });
    [self addSubview:self.closeButton];
    [self.closeButton.widthAnchor constraintEqualToConstant:44].active = YES;
    [self.closeButton.heightAnchor constraintEqualToConstant:44].active = YES;
    [self.closeButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.closeButton.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;

    self.updateButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 37.0/2.0;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        [btn setTitle:@"Update" forState:UIControlStateNormal];
        [btn setBackgroundColor:TTHexColor(0xF8438B)];
        [btn addTarget:self action:@selector(updateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn;
    });
    [self addSubview:self.updateButton];
    [self.updateButton.widthAnchor constraintEqualToConstant:150].active = YES;
    [self.updateButton.heightAnchor constraintEqualToAnchor:self.updateButton.widthAnchor multiplier:(37.0/150.0)].active = YES;
    [self.updateButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-25].active = YES;
    [self.updateButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;


    self.iconImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"update_header"];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView;
    });
    [self addSubview:self.iconImageView];
    [self.iconImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:159.0/330.0].active = YES;
    [self.iconImageView.heightAnchor constraintEqualToAnchor:self.iconImageView.widthAnchor multiplier:83.0/159.0].active = YES;
    [self.iconImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.iconImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:54].active = YES;
    
    self.contentScrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        scrollView;
    });
    [self addSubview:self.contentScrollView];
    [self.contentScrollView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.contentScrollView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.95].active = YES;
    [self.contentScrollView.topAnchor constraintEqualToAnchor:self.iconImageView.bottomAnchor constant:20].active = YES;
    [self.contentScrollView.bottomAnchor constraintEqualToAnchor:self.updateButton.topAnchor constant:-20].active = YES;
    
    self.infoLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label;
    });
    [self.contentScrollView addSubview:self.infoLabel];
    [self.infoLabel.centerXAnchor constraintEqualToAnchor:self.contentScrollView.centerXAnchor constant:0].active = YES;
    [self.infoLabel.widthAnchor constraintEqualToAnchor:self.contentScrollView.widthAnchor multiplier:0.86].active = YES;
    [self.infoLabel.topAnchor constraintEqualToAnchor:self.contentScrollView.topAnchor].active = YES;
    [self.infoLabel.bottomAnchor constraintEqualToAnchor:self.contentScrollView.bottomAnchor].active = YES;
}


- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTapEnent:)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}


@end


@implementation TTUpdateTool

+ (void)openAppStoreWithAppID:(NSString *)appID {
    NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",appID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
