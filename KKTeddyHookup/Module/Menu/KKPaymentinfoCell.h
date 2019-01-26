//
//  XTPaymentInfoCell.h
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPaymentinfoCell : UITableViewCell

@property (nonatomic, copy) void (^textTapAction)(NSString *url);

@end


