//
//  XTPayManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKPayManager.h"

@interface KKPayManager()<TTPaymentManageDelegate>

@end

@implementation KKPayManager

+ (instancetype)sharedClient {
    static KKPayManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KKPayManager alloc] init];
      
    });
    return _sharedClient;
}

#pragma mark - 支付方法

-(void)addpay
{
    [[TTPaymentManager shareInstance] addPayTransactionObserver];
    [TTPaymentManager shareInstance].delegate = self;
}

#pragma mark - XYPaymentManageDelegate
- (void)tt_paymentTransactionSucceedType:(TTPaymentStatus)SucceedType {
    [self showWithState:SucceedType isSuccess:YES];
}

- (void)tt_paymentTransactionFailureType:(TTPaymentStatus)failtype {
    [self showWithState:failtype isSuccess:NO];
}

- (void)showWithState:(TTPaymentStatus)state isSuccess:(BOOL)success {
    NSString *logString = @"";
    switch (state) {
        case pay_success:{
            logString = NSLocalizedString(@"Payment success",nil);
        } break;
        case verify_timeout:{
            logString = NSLocalizedString(@"Verification timeout",nil);
        } break;
        case verify_fail:{
            logString = NSLocalizedString(@"Verification failed",nil);
        } break;
        case payment_fail:{
            logString = NSLocalizedString(@"Payment timeout",nil);
        } break;
        case no_product:{
            logString = NSLocalizedString(@"Unavailable",nil);
        } break;
        case bought_status:{
            logString = NSLocalizedString(@"Purchased",nil);
        } break;
        case pay_fail:{
            logString = NSLocalizedString(@"Payment failed",nil);
        } break;
        case expires:{
            logString = NSLocalizedString(@"Subscription has expired",nil);
        } break;
        case app_store_connect_fail:{
            logString = NSLocalizedString(@"iTunes Store connect failed",nil);
        } break;
        case not_allowed:{
            logString = NSLocalizedString(@"No purchase allowed",nil);
        } break;
        case user_cancel:{
            logString = NSLocalizedString(@"Purchase cancelled",nil);
        } break;
        default:
            break;
    }
    
    if (success) {
        [TTPaymentManager shareInstance].isVip = YES;
        [[TTPaymentManager shareInstance] checkSubscriptionStatusComplete:nil];
        
        [SVProgressHUD dismiss];
//        //@weakify(self);
//        [UIAlertController showAlertTitle:@"Successful Verification" message:@"congratulations on your successful subscription, now you can enjoy it!" cancelTitle:@"Sure" otherTitle:nil cancleBlock:^{
////            @strongify(self);
//
////            [self dismissViewControllerAnimated:YES completion:nil];
//
//        } otherBlock:nil];
        
        [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"success" content:@{@"state":logString} userInfo:nil upload:YES];
    } else {
        [SVProgressHUD showErrorWithStatus:logString];
        [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"failed" content:@{@"state":logString} userInfo:nil upload:YES];
    }
    
}

- (void)dealloc {
    [[TTPaymentManager shareInstance] removePayTransactionObserver];
    [SVProgressHUD dismiss];
}


@end
