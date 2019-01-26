//
//  getbottleAlertView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^replyBlock)(NSString *string);
typedef void(^dismissBlock)(NSString *string);


@interface KKgetbottleAlertView : UIView
@property(nonatomic,copy)replyBlock replyClick;
-(void)withrepylClick:(replyBlock)block;
@property(nonatomic,copy)dismissBlock dismissClick;
-(void)withDismissClick:(dismissBlock)block;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *ageLab;
@property (nonatomic,strong) UIImageView *sexImg;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UITextView *messageLab;
@end

NS_ASSUME_NONNULL_END
