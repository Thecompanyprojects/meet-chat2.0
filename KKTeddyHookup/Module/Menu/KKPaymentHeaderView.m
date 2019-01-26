//
//  XTPaymentHeaderView.m
//  KKTeddyHookup
//
//  Created by KevinXu on 2018/10/30.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPaymentHeaderView.h"

@interface KKPaymentHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation KKPaymentHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSString *title = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName][@"data"][@"cloud"][@"subscribe"][@"title_big"];
    self.titleLabel.text = title;
}

@end
