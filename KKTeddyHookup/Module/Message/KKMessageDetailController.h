//
//  XTMessageDetailController.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "BaseViewController.h"



NS_ASSUME_NONNULL_BEGIN
@class MessageItem;

typedef void (^CloseBlock)(void);

@interface KKMessageDetailController : BaseViewController
@property (nonatomic, strong) MessageItem *msgItem;
@property(nonatomic,copy)CloseBlock closeBlock;
//@property(nonatomic,st)
@end

NS_ASSUME_NONNULL_END
