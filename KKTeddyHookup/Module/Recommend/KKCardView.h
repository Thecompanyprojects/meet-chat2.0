//
//  CardView.h
//  YFLDragCardViewProject
//
//  Created by YangShuai on 2018/10/16.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "KKLDragCardView.h"

@interface KKCardView : KKLDragCardView
@property(nonatomic,assign)BOOL isLiked;//可以喜欢
@property(nonatomic,strong)UILabel * label;

- (void)setAnimationwithDriection:(ContainerDragDirection)direction;

- (void)setImage:(NSString*)imageName name:(NSString*)name withAge:(NSString *)age;

-(void)recoverAnimation;


@end
