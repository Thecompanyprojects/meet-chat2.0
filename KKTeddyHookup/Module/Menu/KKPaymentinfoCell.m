//
//  XTPaymentInfoCell.m
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPaymentinfoCell.h"

@interface KKPaymentinfoCell ()

@property (strong, nonatomic) YYLabel *infoLabel;

@end

@implementation KKPaymentinfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initSubviews {
    
    self.infoLabel = [[YYLabel alloc] init];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.textAlignment = NSTextAlignmentLeft;
    self.infoLabel.preferredMaxLayoutWidth = kScreenWidth - 40; //设置最大的宽度
    
    [self.contentView addSubview:self.infoLabel];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth - 40);
        make.bottom.mas_equalTo(-40);
    }];
    
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName][@"data"][@"cloud"][@"subscribe"];
    NSString *text = info[@"instructions_text"];
    NSNumber *alpha = info[@"instructions_alpha"];
    NSNumber *font = info[@"instructions_font"];
    UIColor *color = [UIColor colorWithHexString:info[@"instructions_color"]];
    
    NSMutableAttributedString *infotext = [[NSMutableAttributedString alloc] initWithString:text];
    infotext.yy_lineSpacing = 4;
    infotext.yy_font = FontPingFangR(font.intValue);
    infotext.yy_color = color;

    NSRange rang_privacy = [text rangeOfString:@"Privacy Policy"];
    NSRange rang_term = [text rangeOfString:@"Term of Service"];
    
    [infotext yy_setUnderlineStyle:NSUnderlineStyleSingle range:rang_privacy];
    [infotext yy_setUnderlineStyle:NSUnderlineStyleSingle range:rang_term];
    [infotext yy_setUnderlineColor:[UIColor blueColor] range:rang_privacy];
    [infotext yy_setUnderlineColor:[UIColor blueColor] range:rang_term];
    
    @weakify(self);
    [infotext yy_setTextHighlightRange:rang_privacy color:[UIColor blueColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"Privacy Policy协议被点击了");
        @strongify(self);
        if (self.textTapAction) {
            NSString *privacy_policy = info[@"privacy_policy"];
            self.textTapAction(privacy_policy);
        }
    }];
    
    [infotext yy_setTextHighlightRange:rang_term color:[UIColor blueColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"Term of Service协议被点击了");
        @strongify(self);
        if (self.textTapAction) {
            NSString *terms_of_services = info[@"terms_of_services"];
            self.textTapAction(terms_of_services);
        }
    }];
    
    self.infoLabel.attributedText = infotext;
    self.infoLabel.alpha = alpha.doubleValue;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
