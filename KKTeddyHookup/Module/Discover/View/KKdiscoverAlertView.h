//
//  discoverAlertView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/18.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sureBlock)(NSString *string);

typedef void(^dismissBlock)(NSString *string);

@interface KKdiscoverAlertView : UIView
@property (nonatomic,strong) UIView *alertView;
@property(nonatomic,copy)sureBlock sureClick;
@property(nonatomic,copy)dismissBlock dismissClick;
-(void)withSureClick:(sureBlock)block;
-(void)withDismissClick:(dismissBlock)block;
@property (nonatomic,strong) UIButton *changeBtn;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *ageLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,assign) BOOL isKeep;
@end

NS_ASSUME_NONNULL_END
