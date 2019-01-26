//
//  XTPaymentCardCell.m
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPaymentCardCell.h"


@interface KKPaymentCardCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *payButton;


@end

@implementation KKPaymentCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)refreshUI {
    // 文字
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName][@"data"][@"cloud"][@"subscribe"];
    NSString *title = info[@"title"];
    NSArray *titleArray = [title componentsSeparatedByString:@"\n"];
    
    NSMutableAttributedString *titleAttM = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSString *title in titleArray) {
        [titleAttM yy_appendString:@"•"];
        [titleAttM yy_appendString:@" "];
        [titleAttM yy_appendString:title];
        if ([titleArray indexOfObject:title] < titleArray.count - 1) {
            [titleAttM yy_appendString:@"\n"];
        }
    }
    titleAttM.yy_lineSpacing = 15;
    titleAttM.yy_font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    titleAttM.yy_color = kHexColor(0x333333);
    
    self.titleLabel.attributedText = titleAttM;
    
    
    // 按钮
    NSString *btnTitle = info[@"pay_btn_text_notvip"];
    NSString *btnTitle_v = info[@"pay_btn_text_vip"];
    
//    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName][@"data"][@"cloud"][@"subscribe"][@"subscribe_ids"];
//    NSString *payment_id = array.firstObject[@"payment_id"];
    
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName];
    NSString *payment_id = config[@"data"][@"cloud"][@"subscribe"][@"subscribe_id"];
    
    if ([[TTPaymentManager shareInstance].availableProductID isEqualToString:payment_id]) {
        [self.payButton setTitle:btnTitle_v forState:UIControlStateNormal];
    } else {
        [self.payButton setTitle:btnTitle forState:UIControlStateNormal];
    }
}

- (void)initSubviews {
    
    self.titleLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label;
    });
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
    }];
    
    
    self.payButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.backgroundColor = kHexColor(0xBB52FE);
        btn.backgroundColor = MainColor;
        btn.layer.cornerRadius = (55 * KWIDTH) / 2.0;
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Bold" size:14];
        btn.layer.shadowRadius = 3;
        btn.layer.shadowOpacity = 0.4;
        btn.layer.shadowOffset = CGSizeMake(3, 3);
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.contentView addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(50 * KWIDTH);
        make.bottom.mas_equalTo(-10);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)payButtonAction:(UIButton *)sender {
//    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName][@"data"][@"cloud"][@"subscribe"][@"subscribe_ids"];
//    NSString *payment_id = array.firstObject[@"payment_id"];
    
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName];
    NSString *payment_id = config[@"data"][@"cloud"][@"subscribe"][@"subscribe_id"];
    
    if ([[TTPaymentManager shareInstance].availableProductID isEqualToString:payment_id]) {
        return;
    }
    
    if (self.payButtonAction) {
        self.payButtonAction(payment_id);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //UIColor *btnBgColor = [UIColor colorGradientWithSize:self.payButton.bounds.size direction:GradientDirection_Horizontal startColor:kHexColor(0xF355D8) endColor:kHexColor(0xBB52FE)];
    UIColor *btnBgColor = [UIColor colorGradientWithSize:self.payButton.bounds.size direction:GradientDirection_Horizontal startColor:kHexColor(0xF355D8) endColor:MainColor];
    [self.payButton setBackgroundColor:btnBgColor];
}

@end
