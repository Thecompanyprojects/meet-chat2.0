//
//  XTPaymentCardCell.h
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface KKPaymentCardCell : UITableViewCell
- (void)refreshUI;
@property (nonatomic, copy) void (^payButtonAction)(NSString *payment_id);

@end


