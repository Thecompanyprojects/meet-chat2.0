//
//  MyImageView.h
//  AutoBeta Message
//
//  Created by YangShuai on 13-3-7.
//  Copyright (c) 2013年 杨帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyImageView : UIImageView
{
    id _target;
    SEL _action;
}

-(void)addTarget:(id)target action:(SEL)action;


@end
