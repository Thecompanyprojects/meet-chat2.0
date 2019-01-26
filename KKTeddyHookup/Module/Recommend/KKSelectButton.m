//
//  SelectButton.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKSelectButton.h"

@implementation KKSelectButton

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = MainColor;
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
}
@end
