//
//  XTChoosesexView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/23.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^replyBlock)(NSString *string);

@interface KKChoosesexView : UIView
@property(nonatomic,copy)replyBlock replyClick;
-(void)withrepylClick:(replyBlock)block;
@end

NS_ASSUME_NONNULL_END
