//
//  XTPaymentNormalCell.m
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPaymentNormalCell.h"
#import "KKPaymentPriceModel.h"

@interface KKPaymentNormalCell ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;

@end

@implementation KKPaymentNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(KKPaymentPriceModel *)model {
    _model = model;
    
    _numberLabel.text = [NSString stringWithFormat:@"%02zd",model.index];
    
    NSMutableAttributedString *arrMStr = [[NSMutableAttributedString alloc] initWithString:model.title];
    arrMStr.yy_lineSpacing = 4;
    _titleLabel.attributedText = arrMStr;
    
    if ([[TTPaymentManager shareInstance].availableProductID isEqualToString:model.payment_id]) {
        [_priceButton setTitle:@"Subscribed" forState:UIControlStateNormal];
    } else {
        [_priceButton setTitle:model.price forState:UIControlStateNormal];
    }
    
    _numberLabel.backgroundColor = MainColor;
    _priceButton.backgroundColor = MainColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)priceButtonAction:(UIButton *)sender {
    if ([[TTPaymentManager shareInstance].availableProductID isEqualToString:self.model.payment_id]) {
        return;
    }
    
    if (self.payButtonAction) {
        self.payButtonAction(self.model);
    }
}

@end
