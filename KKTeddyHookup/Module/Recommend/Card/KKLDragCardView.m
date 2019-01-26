//
//  YFLDragCardBaseView.m
//  YFLDragCardViewProject
//
//  Created by YangShuai on 2018/10/16.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "KKLDragCardView.h"

@interface KKLDragCardView()

@property (nonatomic,strong) UIImageView *like;

@property (nonatomic,strong) UIImageView *dislike;

@end

@implementation KKLDragCardView

#pragma mark - Init Method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

#pragma mark - Private Method
- (void)setUp
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor cyanColor];
}

#pragma mark - Public Method
- (void)setConfigure:(KKLDragConfigure *)configure
{
    _configure = configure;
    self.layer.cornerRadius = configure.cardCornerRadius;
    self.layer.borderWidth = configure.cardCornerBorderWidth;
    self.layer.borderColor = configure.cardBordColor.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)YFLDragCardViewLayoutSubviews
{
}


- (void)startAnimatingForDirection:(ContainerDragDirection)direction
{
    
}

//实现NSCopying协议的方法，来使此类具有copy功能
-(id)copyWithZone:(NSZone *)zone
{
    KKLDragConfigure *newFract = [[KKLDragConfigure allocWithZone:zone] init];
    return newFract;
}


@end
