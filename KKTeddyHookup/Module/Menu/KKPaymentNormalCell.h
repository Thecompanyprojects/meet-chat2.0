//
//  XTPaymentNormalCell.h
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KKPaymentPriceModel;
@interface KKPaymentNormalCell : UITableViewCell

@property (nonatomic, strong) KKPaymentPriceModel *model;
@property (nonatomic, copy) void (^payButtonAction)(KKPaymentPriceModel *model);

@end


