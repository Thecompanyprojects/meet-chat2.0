//
//  MyImageView.m
//  AutoBeta Message
//
//  Created by YangShuai on 13-3-7.
//  Copyright (c) 2013年 杨帅. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

-(void)addTarget:(id)target action:(SEL)action{
    _target = target;
    _action = action;
    self.userInteractionEnabled = YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    if (touch.view == self) {
        if ([_target respondsToSelector:_action]) {
            [_target performSelector:_action withObject:self];
        }
    }
    

}
@end
