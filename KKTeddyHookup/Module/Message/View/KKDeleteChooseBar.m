//
//  DeleteChooseBar.m
//  KKTeddyHookup
//
//  Created by 张葱 on 2018/11/13.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "KKDeleteChooseBar.h"
@interface KKDeleteChooseBar()
@property(nonatomic,strong)UIButton*selectedBtn;
@end
@implementation KKDeleteChooseBar

+(instancetype)ChooseBArWithchoose:(Clicked)clicked{
    KKDeleteChooseBar * toolbar = [[self alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,50)];
    toolbar.click = clicked;
    return toolbar;
}
-(void)setIshasdelete:(BOOL)ishasdelete{
    _ishasdelete = ishasdelete;
    UIButton *delbtn = [self viewWithTag:101];
    
    if (ishasdelete) {
        delbtn.selected = YES;
  
    }else{

       delbtn.selected = NO;

    }
  
}

-(void)setIshasSelectedAll:(BOOL)ishasSelectedAll{
    _ishasSelectedAll = ishasSelectedAll;
    
    UIButton *allbtn = [self viewWithTag:100];
    
    if (ishasSelectedAll) {
        allbtn.selected = YES;
        
    }else{
        
        allbtn.selected = NO;
        
    }
    
    
    
}

-(void)Clean{
    

    UIButton *delbtn = [self viewWithTag:101];
    delbtn.selected = NO;
    UIButton *allbtn = [self viewWithTag:100];
    allbtn.selected = NO;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}



-(void)setUI{
    
    UIView*line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    [self addSubview:line];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#F8438B"] forState:UIControlStateSelected];
    [btn setTitle:@"Choose all" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.xy_width = kScreenWidth/2.0;
    btn.xy_x = 0;
    btn.xy_y = 0;
    btn.xy_height = self.xy_height;
    btn.tag = 100;
    self.selectedBtn = btn;
    [self addSubview:btn];
    
    
    UIButton * delbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delbtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [delbtn setTitleColor:[UIColor colorWithHexString:@"#F8438B"] forState:UIControlStateSelected];
    [delbtn setTitle:@"Delete" forState:UIControlStateNormal];
    delbtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [delbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    delbtn.tag = 101;
    delbtn.xy_width = kScreenWidth/2.0;
    delbtn.xy_x = kScreenWidth/2.0;
    delbtn.xy_y = 0;
    delbtn.xy_height = self.xy_height;
    [self addSubview:delbtn];
    
    
    UIView*colline = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, 13, 1, 25)];
    colline.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:colline];
}


-(void)click:(UIButton*)sender{
    
    if (self.click) {
        self.click(sender.tag -100,self);
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
