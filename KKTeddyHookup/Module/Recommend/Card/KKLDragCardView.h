//
//  YFLDragCardBaseView.h
//  YFLDragCardViewProject
//
//  Created by YangShuai on 2018/10/16.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLDragConfigure.h"
@interface KKLDragCardView : UIView <NSCopying>


@property (nonatomic,assign) CGAffineTransform originTransForm;


@property (nonatomic,strong) KKLDragConfigure *configure;

/**
 布局子视图，其子类重写，并在其进行布局
 */
- (void)YFLDragCardViewLayoutSubviews;


/**
 执行卡片上动画(喜欢、不喜欢)
 */
- (void)startAnimatingForDirection:(ContainerDragDirection)direction;


@end
