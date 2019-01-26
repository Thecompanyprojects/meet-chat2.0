//
//  XTEditorViewController.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "BaseViewController.h"
#import "KKPersonModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnTextBlock)(NSString *showText);

@interface KKEditorViewController : BaseViewController
@property (nonatomic,strong) KKPersonModel *personModel;
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
- (void)returnText:(ReturnTextBlock)block;
@end

NS_ASSUME_NONNULL_END
