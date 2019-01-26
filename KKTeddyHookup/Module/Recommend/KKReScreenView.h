//
//  ReScreenView.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

@protocol ScreenDelegate <NSObject>

@optional
-(void)screeenPassValue:(id)data;
-(void)screenConfirm:(id)data;
@end

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKReScreenView : UIView
@property(nonatomic,assign)id delegate;
@end

NS_ASSUME_NONNULL_END
