//
//  inputView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKinputView : UIView
@property (nonatomic,strong) UITextField *phoneText;
@property (nonatomic,strong) UITextField *passwordText;
@property (nonatomic,strong) NSString *type;
@end

NS_ASSUME_NONNULL_END
