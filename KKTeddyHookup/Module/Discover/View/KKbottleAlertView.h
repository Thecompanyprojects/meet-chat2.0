//
//  bottleAlertView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/18.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^replyBlock)(NSString *string);

@interface KKbottleAlertView : UIView

@property(nonatomic,copy)replyBlock replyClick;
-(void)withrepylClick:(replyBlock)block;
@property (nonatomic,strong) UITextView *messageText;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *ageLab;
@property (nonatomic,strong) UIImageView *sexImg;
@property (nonatomic,strong) UILabel *contentLab;

@end

NS_ASSUME_NONNULL_END
