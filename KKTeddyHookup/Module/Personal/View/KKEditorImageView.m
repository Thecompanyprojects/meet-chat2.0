//
//  XTEditorImageView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKEditorImageView.h"

@interface KKEditorImageView()

@end

@implementation KKEditorImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
        self.userInteractionEnabled = YES;
        self.layer.masksToBounds = YES;
        self.contentMode =  UIViewContentModeScaleAspectFill;
        [self addSubview:self.addBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(27);
        make.height.mas_offset(27);
    }];
}

#pragma mark - getters

-(UIButton *)addBtn
{
    if(!_addBtn)
    {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:normal];
    }
    return _addBtn;
}





@end
