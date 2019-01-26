//
//  discoverheaderView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/17.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKDiscoverheaderView.h"
#import "UIButton+PassValue.h"

@interface KKDiscoverheaderView()
@property (nonatomic,strong) NSMutableArray *masonryViewArray;
@property (nonatomic,strong) UIButton *btn0;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UILabel *titleLab0;
@property (nonatomic,strong) UILabel *titleLab1;
@property (nonatomic,strong) UILabel *titleLab2;
@property (nonatomic,strong) UILabel *titleLab3;
@property (nonatomic,strong) UILabel *typeLab;
@end

@implementation KKDiscoverheaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.btn0];
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        
        [self addSubview:self.titleLab0];
        [self addSubview:self.titleLab1];
        [self addSubview:self.titleLab2];
        [self addSubview:self.titleLab3];
        
        [self addSubview:self.typeLab];
        [self setuplayout];
    }
    [self setBtntitlefromweb];
    return self;
}

#pragma mark --云控按钮显示

-(void)setBtntitlefromweb
{
    NSArray *discover = [[NSUserDefaults standardUserDefaults] objectForKey:@"discover"];
    if (discover.count!=0) {
        NSString *strtitle0 = [discover firstObject];
        NSString *strtitle1 = [discover objectAtIndex:1];
        NSString *strtitle2 = [discover objectAtIndex:2];
        NSString *strtitle3 = [discover objectAtIndex:3];
        
        NSString *TEACHERUpFirst0  = [strtitle0 capitalizedString];
        NSString *TEACHERUpFirst1  = [strtitle1 capitalizedString];
        NSString *TEACHERUpFirst2  = [strtitle2 capitalizedString];
        NSString *TEACHERUpFirst3  = [strtitle3 capitalizedString];
        
        self.titleLab0.text = TEACHERUpFirst0;
        self.titleLab1.text = TEACHERUpFirst1;
        self.titleLab2.text = TEACHERUpFirst2;
        self.titleLab3.text = TEACHERUpFirst3;
        
        [self.btn0 setImage:[UIImage imageNamed:strtitle0] forState:normal];
        [self.btn1 setImage:[UIImage imageNamed:strtitle1] forState:normal];
        [self.btn2 setImage:[UIImage imageNamed:strtitle2] forState:normal];
        [self.btn3 setImage:[UIImage imageNamed:strtitle3] forState:normal];
        
        self.btn0.paramDic = @{@"title":strtitle0};
        self.btn1.paramDic = @{@"title":strtitle1};
        self.btn2.paramDic = @{@"title":strtitle2};
        self.btn3.paramDic = @{@"title":strtitle3};
    }else
    {
        NSString *strtitle0 = @"shake";
        NSString *strtitle1 = @"drifter";
        NSString *strtitle2 = @"active";
        NSString *strtitle3 = @"video";
        
        NSString *TEACHERUpFirst0   = [strtitle0 capitalizedString];
        NSString *TEACHERUpFirst1   = [strtitle1 capitalizedString];
        NSString *TEACHERUpFirst2   = [strtitle2 capitalizedString];
        NSString *TEACHERUpFirst3   = [strtitle3 capitalizedString];
        
        self.titleLab0.text = TEACHERUpFirst0;
        self.titleLab1.text = TEACHERUpFirst1;
        self.titleLab2.text = TEACHERUpFirst2;
        self.titleLab3.text = TEACHERUpFirst3;
        
        [self.btn0 setImage:[UIImage imageNamed:strtitle0] forState:normal];
        [self.btn1 setImage:[UIImage imageNamed:strtitle1] forState:normal];
        [self.btn2 setImage:[UIImage imageNamed:strtitle2] forState:normal];
        [self.btn3 setImage:[UIImage imageNamed:strtitle3] forState:normal];
        
        self.btn0.paramDic = @{@"title":strtitle0};
        self.btn1.paramDic = @{@"title":strtitle1};
        self.btn2.paramDic = @{@"title":strtitle2};
        self.btn3.paramDic = @{@"title":strtitle3};
    }
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    self.masonryViewArray = [NSMutableArray array];
    [self.masonryViewArray addObject:self.btn0];
    [self.masonryViewArray addObject:self.btn1];
    [self.masonryViewArray addObject:self.btn2];
    [self.masonryViewArray addObject:self.btn3];
    
    // 实现masonry水平固定控件宽度方法
    [weakSelf.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:48 leadSpacing:36 tailSpacing:36];
    
    // 设置array的垂直方向的约束
    [weakSelf.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.height.mas_offset(48);
    }];
    
    [weakSelf.titleLab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btn0.mas_bottom).with.offset(10);
        make.centerX.equalTo(weakSelf.btn0);
        make.height.mas_offset(12);
    }];
    [weakSelf.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab0);
        make.centerX.equalTo(weakSelf.btn1);
        make.height.mas_offset(12);
    }];
    [weakSelf.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab0);
        make.centerX.equalTo(weakSelf.btn2);
        make.height.mas_offset(12);
    }];
    [weakSelf.titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab0);
        make.centerX.equalTo(weakSelf.btn3);
        make.height.mas_offset(12);
    }];
    
    [weakSelf.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf.titleLab2.mas_bottom).with.offset(32);
    }];
    
}

#pragma mark - getters

-(UIButton *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[UIButton alloc] init];
        [_btn0 addTarget:self action:@selector(p_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn0;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[UIButton alloc] init];
        [_btn1 addTarget:self action:@selector(p_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

-(UIButton *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[UIButton alloc] init];
        [_btn2 addTarget:self action:@selector(p_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

-(UIButton *)btn3
{
    if(!_btn3)
    {
        _btn3 = [[UIButton alloc] init];
        [_btn3 addTarget:self action:@selector(p_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

-(UILabel *)titleLab0
{
    if(!_titleLab0)
    {
        _titleLab0 = [[UILabel alloc] init];
        _titleLab0.textAlignment = NSTextAlignmentCenter;
        _titleLab0.font = [UIFont systemFontOfSize:12];
        _titleLab0.textColor = [UIColor colorWithHexString:@"666666"];

    }
    return _titleLab0;
}

-(UILabel *)titleLab1
{
    if(!_titleLab1)
    {
        _titleLab1 = [[UILabel alloc] init];
        _titleLab1.textAlignment = NSTextAlignmentCenter;
        _titleLab1.font = [UIFont systemFontOfSize:12];
        _titleLab1.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _titleLab1;
}

-(UILabel *)titleLab2
{
    if(!_titleLab2)
    {
        _titleLab2 = [[UILabel alloc] init];
        _titleLab2.textAlignment = NSTextAlignmentCenter;
        _titleLab2.font = [UIFont systemFontOfSize:12];
        _titleLab2.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _titleLab2;
}

-(UILabel *)titleLab3
{
    if(!_titleLab3)
    {
        _titleLab3 = [[UILabel alloc] init];
        _titleLab3.textAlignment = NSTextAlignmentCenter;
        _titleLab3.font = [UIFont systemFontOfSize:12];
        _titleLab3.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _titleLab3;
}

-(UILabel *)typeLab
{
    if(!_typeLab)
    {
        _typeLab = [[UILabel alloc] init];
        _typeLab.font = [UIFont systemFontOfSize:16];
        _typeLab.textColor = [UIColor colorWithHexString:@"000000"];
        _typeLab.text = @"Find a friend";
    }
    return _typeLab;
}

- (void)p_clickBtn:(UIButton *)sender{
    
//    //通过代理回调
//    [_delegate respondsToSelector:@selector(clickBtn:)] ?
//    [_delegate clickBtn:sender] : nil;
    NSString *title = [sender.paramDic objectForKey:@"title"];
    [self.delegate myheaderClick:title];
}

@end
