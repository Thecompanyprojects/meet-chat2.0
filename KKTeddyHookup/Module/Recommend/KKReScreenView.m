//
//  ReScreenView.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKReScreenView.h"
#import "KKSelectButton.h"
#import "KKDoubleSlider.h"


@interface KKReScreenView ()<DoubleSliderDelegate>
@property(nonatomic,strong) KKDoubleSlider * slider;
@property(nonatomic,weak)IBOutlet UILabel * ageLabel;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSArray * ages;
@property(nonatomic,strong)NSNumber * active; //活跃度
@end

@implementation KKReScreenView

-(void)awakeFromNib{
    [super awakeFromNib];

    _slider = [[KKDoubleSlider alloc]initWithFrame:CGRectMake(20, 95, kScreenWidth - 40, 40)];
    _slider.minNum = 18;
    _slider.maxNum = 40;
    _slider.minTintColor = [UIColor colorWithHexString:@"#999999"];
    _slider.maxTintColor = [UIColor  colorWithHexString:@"#999999"];
    _slider.mainTintColor = MainColor;
    _slider.delegate = self;
    self.sex = @"";
    self.active = @1;
    self.ages = @[@18,@40];
    [self addSubview:_slider];
}
-(void)sliderValueChange:(KKDoubleSlider *)slider{
    if ((int)slider.currentMaxValue == (int)slider.currentMinValue) {
        self.ageLabel.text = [NSString stringWithFormat:@"(%d)",(int)slider.currentMinValue];
    }else{
        self.ageLabel.text = [NSString stringWithFormat:@"(%d-%d)",(int)slider.currentMinValue,(int)slider.currentMaxValue];
    }
     self.ages = @[@((int)slider.currentMinValue),@((int)slider.currentMaxValue)];
}
-(IBAction)confirmClick:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(screeenPassValue:)]) {
        [self.delegate screeenPassValue:@{@"age":self.ages,
                                          @"active":self.active
                                          }];
         [[XYLogManager shareManager] addLogKey1:@"screen" key2:@"select" content:@{@"type":@(0)} userInfo:[NSDictionary new] upload:YES];
         [[XYLogManager shareManager] addLogKey1:@"screen" key2:@"select" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:YES];
    }
}
-(IBAction)sexClick:(KKSelectButton *)sender{
    NSArray * sexValues = @[@"",@"m",@"f"];
    KKSelectButton * btn0 = [self viewWithTag:200];
    KKSelectButton * btn1 = [self viewWithTag:201];
    KKSelectButton * btn2 = [self viewWithTag:202];
    btn0.selected = NO;
    btn1.selected = NO;
    btn2.selected = NO;
    sender.selected = YES;
    self.sex = sexValues[sender.tag - 200];
}
-(IBAction)agetClick:(KKSelectButton *)sender{
   
}
-(IBAction)closeClick:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(screeenPassValue:)]) {
        [self.delegate screeenPassValue:nil];
    }
}
-(IBAction)activityClick:(KKSelectButton *)sender{
    NSArray * activityValues = @[@1,@2,@3,@4];
    KKSelectButton * btn0 = [self viewWithTag:300];
    KKSelectButton * btn1 = [self viewWithTag:301];
    KKSelectButton * btn2 = [self viewWithTag:302];
    KKSelectButton * btn3 = [self viewWithTag:303];
    btn0.selected = NO;
    btn1.selected = NO;
    btn2.selected = NO;
    btn3.selected = NO;
    sender.selected = YES;
    self.active = activityValues[sender.tag - 300];
    
}
@end
