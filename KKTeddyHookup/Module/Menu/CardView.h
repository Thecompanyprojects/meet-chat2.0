//
//  CardView.h
//  YFLDragCardViewProject
//
//  Created by 杨帅 on 2018/10/16.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "YFLDragCardView.h"

@interface CardView : YFLDragCardView

- (void)setAnimationwithDriection:(ContainerDragDirection)direction;

- (void)setImage:(NSString*)imageName title:(NSString*)title;

@end
