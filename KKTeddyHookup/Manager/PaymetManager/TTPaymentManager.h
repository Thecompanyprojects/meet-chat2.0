//
//  KKPaymentManage.h
//  VPN
//
//  Created by PanZhi on 2018/3/8.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    pay_success,//购买成功
    verify_timeout, //购买成功 验证超时
    verify_fail,    //购买成功 验证失败
    payment_fail,   //支付超时
    no_product,     //没有商品
    bought_status,         //购买过
    pay_fail,//交易失败
    expires,    //vip已过期
    app_store_connect_fail, //App Store连接失败
    not_allowed, //该设备不允许支付或不能支付
    user_cancel // 用户中途取消了
} TTPaymentStatus;

@protocol TTPaymentManageDelegate <NSObject>

-(void)tt_paymentTransactionSucceedType:(TTPaymentStatus)SucceedType;
-(void)tt_paymentTransactionFailureType:(TTPaymentStatus)failtype;

@end

@interface TTPaymentManager : NSObject

@property (nonatomic, weak)   id<TTPaymentManageDelegate>delegate;
@property (nonatomic, assign) BOOL                       isVip;

@property (nonatomic, copy) NSString *availableProductID; /**< 可用的产品ID */
@property (nonatomic, strong) NSArray <NSString *>*productIdArray;// 有效的订阅ID数组
@property (nonatomic, strong) NSArray <NSNumber *>*applyCladdID;// 解锁的功能ID

+ (instancetype) shareInstance;

- (void)addPayTransactionObserver;
- (void)removePayTransactionObserver;

// 根据id购买
- (void)paymentWithProductID:(NSString *)ProductID;
- (void)refreshReceipt;


// 直接购买
- (void)paymentDirect;


- (void)checkSubscriptionStatusComplete:(void(^)(BOOL isVip))complete;

@end
