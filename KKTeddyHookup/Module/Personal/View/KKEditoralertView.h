//
//  XTEditoralertView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^replyBlock)(NSString *string);

@interface KKEditoralertView : UIView
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UITextField *editorText;
@property(nonatomic,copy)replyBlock replyClick;
-(void)withrepylClick:(replyBlock)block;
@property (nonatomic,copy) NSString *typeStr;
@end

NS_ASSUME_NONNULL_END
