//
//  inputView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKinputView.h"
#import "UITextField+Extension.h"

@interface KKinputView()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel *phoneLab;
@property (nonatomic,strong) UILabel *passwordLab;
@property (nonatomic,strong) UIView *phoneLine;
@property (nonatomic,strong) UIView *passwordLine;
@property (nonatomic,strong) UIButton *clearBtn;
@property (nonatomic,assign) BOOL isEntry;
@end

@implementation KKinputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isEntry = YES;
        [self addSubview:self.phoneLab];
        [self addSubview:self.phoneText];
        [self addSubview:self.phoneLine];
        [self addSubview:self.clearBtn];
        
        [self addSubview:self.passwordText];
        [self addSubview:self.passwordLab];
        [self addSubview:self.passwordLine];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(3);
        make.left.equalTo(weakSelf);
        
    }];
    [weakSelf.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.phoneLab.mas_bottom).with.offset(3);
        make.height.mas_offset(40);
    }];
    [weakSelf.phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.phoneText.mas_bottom).with.offset(3);
    }];
    [weakSelf.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(12);
        make.height.mas_offset(12);
        make.centerY.equalTo(weakSelf.phoneText);
        make.right.equalTo(weakSelf.phoneText.mas_right).with.offset(-3);
    }];
    
    [weakSelf.passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.phoneLine.mas_bottom).with.offset(6);
    }];
    [weakSelf.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.passwordLab.mas_bottom).with.offset(3);
        make.height.mas_offset(40);
    }];

    [weakSelf.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.passwordText.mas_bottom).with.offset(3);
        make.height.mas_offset(1);
    }];

}

-(UILabel *)phoneLab
{
    if(!_phoneLab)
    {
        _phoneLab = [[UILabel alloc] init];
       // _phoneLab.text = @"";
        _phoneLab.font = [UIFont systemFontOfSize:10];
        _phoneLab.textColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    return _phoneLab;
}

-(UILabel *)passwordLab
{
    if(!_passwordLab)
    {
        _passwordLab = [[UILabel alloc] init];
       // _passwordLab.text = @"Login password";
        _passwordLab.font = [UIFont systemFontOfSize:10];
        _passwordLab.textColor = [UIColor colorWithHexString:@"D1D1D1"];
        
    }
    return _passwordLab;
}

-(UITextField *)phoneText
{
    if(!_phoneText)
    {
        _phoneText = [[UITextField alloc] init];
        _phoneText.delegate = self;
        _phoneText.font = [UIFont systemFontOfSize:14];
        [_phoneText addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _phoneText.placeholder = @"Phone number";
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneText;
}

-(UIButton *)clearBtn
{
    if(!_clearBtn)
    {
        _clearBtn = [[UIButton alloc] init];
        [_clearBtn setImage:[UIImage imageNamed:@"clone"] forState:normal];
        [_clearBtn addTarget:self action:@selector(clearButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_clearBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    }
    return _clearBtn;
}

-(UITextField *)passwordText
{
    if(!_passwordText)
    {
        _passwordText = [[UITextField alloc] init];
        _passwordText.secureTextEntry = YES;
        _passwordText.delegate = self;
        [_passwordText setTextFieldWithFont:14 color:[UIColor blackColor] alignment:NSTextAlignmentLeft title:@"" placeHolder:@"Login password"];
        [_passwordText addTarget:self action:@selector(textFieldChanged2:) forControlEvents:UIControlEventEditingChanged];

    }
    return _passwordText;
}

-(UIView *)phoneLine
{
    if(!_phoneLine)
    {
        _phoneLine = [[UIView alloc] init];
        _phoneLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    return _phoneLine;
}

-(UIView *)passwordLine
{
    if(!_passwordLine)
    {
        _passwordLine = [[UIView alloc] init];
        _passwordLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    return _passwordLine;
}

-(void)clearButtonDidClick
{
    self.phoneText.text = nil;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
    if (textField==self.phoneText) {
        self.phoneLab.textColor = MainColor;
        self.phoneLine.backgroundColor = MainColor;
        self.passwordLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
        self.passwordLab.textColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    else
    {
        self.phoneLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
        self.phoneLab.textColor = [UIColor colorWithHexString:@"D1D1D1"];
        self.passwordLine.backgroundColor = MainColor;
        self.passwordLab.textColor = MainColor;
        
        
    }
}

- (void)textFieldChanged:(UITextField*)textField{
    
    //NSString *_string = textField.text;
    if (textField.text.length==0) {
        self.phoneText.placeholder = @"Phone number";
        self.phoneLab.text = @"";
        
        // result:0/1/2/3/4/5 0:phone_number 1:pwd 2:login 3:sign_up 4:google 5:fb
        if ([self.type isEqualToString:@"0"]) {
            [[XYLogManager shareManager] addLogKey1:@"login" key2:@"click" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
        }
        else
        {
            [[XYLogManager shareManager] addLogKey1:@"sign_up" key2:@"click" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
        }
       
    }
    else
    {
        self.phoneLab.text = @"Phone number";
        self.phoneText.placeholder = @"";
    }
}

- (void)textFieldChanged2:(UITextField*)textField
{
    if (textField.text.length==0) {
        self.passwordText.placeholder = @"Password";
        self.passwordLab.text = @"";
        
        // result:0/1/2/3/4/5 0:phone_number 1:pwd 2:login 3:sign_up 4:google 5:fb
        if ([self.type isEqualToString:@"0"]) {
            [[XYLogManager shareManager] addLogKey1:@"login" key2:@"click" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
        }
        else
        {
            [[XYLogManager shareManager] addLogKey1:@"sign_up" key2:@"click" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
        }
   
    }
    else
    {
        self.passwordLab.text = @"Password";
        self.passwordText.placeholder = @"";
    }
}

@end
