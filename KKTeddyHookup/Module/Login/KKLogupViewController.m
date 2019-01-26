//
//  LogupViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKLogupViewController.h"
#import "KKinputView.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "KKTabbarController.h"
#import <SafariServices/SafariServices.h>

@interface KKLogupViewController ()<YBAttributeTapActionDelegate>
@property (nonatomic,strong) UIImageView *logoImg;
@property (nonatomic,strong) KKinputView *textView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UILabel *userinfoLab;
@property (nonatomic,strong) UIButton *chooseImg;
@property (nonatomic,strong) UIButton *boyBtn;
@property (nonatomic,strong) UIButton *girlBtn;
@property (nonatomic,strong) UILabel *boyLab;
@property (nonatomic,strong) UILabel *girlLab;
@property (nonatomic,strong) UILabel *userinfoLab1;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,strong) UIButton *leftBtn;
@end

@implementation KKLogupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    self.sex = @"";
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.boyBtn];
    [self.view addSubview:self.girlBtn];
    [self.view addSubview:self.boyLab];
    [self.view addSubview:self.girlLab];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.userinfoLab];
    [self.view addSubview:self.userinfoLab1];
    [self.view addSubview:self.leftBtn];
    [self setuplayout];
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    [weakSelf.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_offset(75);
        make.height.mas_offset(75);
        make.top.equalTo(weakSelf.view).with.offset(64+40);
    }];
    
    [weakSelf.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(weakSelf.logoImg.mas_bottom).with.offset(32);
        }
        else
        {
            make.top.equalTo(weakSelf.logoImg.mas_bottom).with.offset(72);
        }
        make.right.equalTo(weakSelf.view).with.offset(-20);
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.height.mas_offset(130);
    }];
    
    [weakSelf.boyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(64);
        make.height.mas_offset(64);
        make.left.equalTo(weakSelf.view).with.offset(73*KWIDTH);
        if (IS_IPHONE_5) {
              make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(20);
        }
        else
        {
             make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(70*KHEIGHT);
        }
       
    }];
    [weakSelf.girlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(64);
        make.height.mas_offset(64);
        make.right.equalTo(weakSelf.view).with.offset(-73*KWIDTH);
        make.top.equalTo(weakSelf.boyBtn);
    }];
    
    [weakSelf.boyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.boyBtn);
        make.right.equalTo(weakSelf.boyBtn);
        make.top.equalTo(weakSelf.boyBtn.mas_bottom).with.offset(6);
    }];
    
    [weakSelf.girlLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.girlBtn);
        make.right.equalTo(weakSelf.girlBtn);
        make.top.equalTo(weakSelf.girlBtn.mas_bottom).with.offset(6);
    }];
    
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.girlBtn.mas_bottom).with.offset(42*KHEIGHT);
        make.height.mas_offset(40);
        make.centerX.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view).with.offset(42*KWIDTH);
    }];
    
    [weakSelf.userinfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isIPhoneX_All) {
            make.bottom.equalTo(weakSelf.view).with.offset(-35);
        }
        else
        {
            make.bottom.equalTo(weakSelf.view).with.offset(-15);
        }
        make.centerX.equalTo(weakSelf.view);
    }];
   
    [weakSelf.userinfoLab1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(weakSelf.userinfoLab.mas_top).with.offset(-6);
        make.left.equalTo(weakSelf.view).with.offset(23);
        make.right.equalTo(weakSelf.view).with.offset(-23);
    }];
    
    [weakSelf.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(20);
        if (isIPhoneX_All) {
            make.top.equalTo(weakSelf.view).with.offset(44);
        }
        else
        {
            make.top.equalTo(weakSelf.view).with.offset(24);
        }
        make.width.mas_offset(22);
        make.height.mas_offset(22);
    }];
}

#pragma mark - getters

-(UIImageView *)logoImg
{
    if(!_logoImg)
    {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"userimg"];
        _logoImg.layer.cornerRadius = 75/2;
    }
    return _logoImg;
}

-(KKinputView *)textView
{
    if(!_textView)
    {
        _textView = [[KKinputView alloc] init];
        _textView.type = @"1";
    }
    return _textView;
}

-(UIButton *)boyBtn
{
    if(!_boyBtn)
    {
        _boyBtn = [[UIButton alloc] init];
        [_boyBtn setImage:[UIImage imageNamed:@"nan-1"] forState:normal];
        [_boyBtn addTarget:self action:@selector(chooseboyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boyBtn;
}

-(UIButton *)girlBtn
{
    if(!_girlBtn)
    {
        _girlBtn = [[UIButton alloc] init];
        [_girlBtn setImage:[UIImage imageNamed:@"nv"] forState:normal];
        [_girlBtn addTarget:self action:@selector(choosegirlClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _girlBtn;
}

-(UILabel *)boyLab
{
    if(!_boyLab)
    {
        _boyLab = [[UILabel alloc] init];
        _boyLab.textAlignment = NSTextAlignmentCenter;
        _boyLab.font = [UIFont systemFontOfSize:14];
        _boyLab.textColor = [UIColor colorWithHexString:@"999999"];
        _boyLab.text = @"Male";
    }
    return _boyLab;
}

-(UILabel *)girlLab
{
    if(!_girlLab)
    {
        _girlLab = [[UILabel alloc] init];
        _girlLab.textAlignment = NSTextAlignmentCenter;
        _girlLab.font = [UIFont systemFontOfSize:14];
        _girlLab.textColor = [UIColor colorWithHexString:@"999999"];
        _girlLab.text = @"Female";
    }
    return _girlLab;
}


-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn addTarget:self action:@selector(submitbtlcikck) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _submitBtn.backgroundColor = MainColor;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        [_submitBtn setTitle:@"Sign Up" forState:normal];
    }
    return _submitBtn;
}

-(UILabel *)userinfoLab
{
    if(!_userinfoLab)
    {
        _userinfoLab = [[UILabel alloc] init];
        _userinfoLab.font = [UIFont systemFontOfSize:12];
        _userinfoLab.textAlignment = NSTextAlignmentLeft;
//        _userinfoLab.numberOfLines = 0;
        //NSString *str1 = @"By signing up, you agree to our";
        NSString *str2 = @" Terms of Servoce";
        NSString *str3 = @" and ";
        NSString *str4 = @" Privacy Policy";
        
        NSString *newStr = [NSString stringWithFormat:@"%@%@%@",str2,str3,str4];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:newStr];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, newStr.length)];
        //添加文字颜色
//        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, str1.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:MainColor range:NSMakeRange(0, str2.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(str2.length, str3.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:MainColor range:NSMakeRange(str2.length+str3.length, str4.length)];
        _userinfoLab.enabledTapEffect = NO;
        _userinfoLab.attributedText = attrStr;
        [_userinfoLab sizeToFit];
        [_userinfoLab yb_addAttributeTapActionWithStrings:@[@"Terms of Servoce",@"Privacy Policy"] delegate:self];
        
    }
    return _userinfoLab;
}

-(UILabel *)userinfoLab1
{
    if(!_userinfoLab1)
    {
        _userinfoLab1 = [[UILabel alloc] init];
        _userinfoLab1.font = [UIFont systemFontOfSize:12];
        _userinfoLab1.textAlignment = NSTextAlignmentCenter;
        NSString *str1 = @"By signing up, you agree to our";
        _userinfoLab1.text = str1;
        _userinfoLab1.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _userinfoLab1;
}

-(UIButton *)leftBtn
{
    if(!_leftBtn)
    {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn addTarget:self action:@selector(leftbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setImage:[UIImage imageNamed:@"logupBack"] forState:normal];
    }
    return _leftBtn;
}



#pragma mark - 实现方法

-(void)submitbtlcikck
{
     [[XYLogManager shareManager] addLogKey1:@"sign_up" key2:@"click" content:@{@"result":@(2)} userInfo:[NSDictionary new] upload:YES];
    if (self.textView.phoneText.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"Pleast enter a user phone"];
        return;
    }
    
    if (self.textView.passwordText.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"Please enter a password"];
        return;
    }
    
    if (self.sex.length==0) {
        [SVProgressHUD showInfoWithStatus:@"Please select gender"];
        return;
    }
    
    [XYLoadingHUD show];
    NSString *username = self.textView.phoneText.text;
    NSString *password = self.textView.passwordText.text;
    NSDictionary *para = @{@"username":username?:@"",@"password":password?:@"",@"sex":self.sex};
    NSString *url = [ServerIP stringByAppendingString:LOGUP];
    NSDictionary *newPara = @{@"data":para};
    [[XYNetworkRequest manager] requestUrl:url Parameters:newPara success:^(NSDictionary *response) {
          [XYLoadingHUD dismiss];
        if ([[response objectForKey:@"code"] intValue]==1) {
            NSDictionary *dic = [response objectForKey:@"data"];
            NSString *newid = [dic objectForKey:@"id"];
            NSString *token = [dic objectForKey:@"token"];
            NSString *refreshtoken = [dic objectForKey:@"refreshtoken"];
            KKUserModel *model = [KKUserModel sharedUserModel];
            model.sex = self.sex;
            model.token = token?:refreshtoken;
            model.userId = newid;
            model.name = [dic objectForKey:@"name"];
            NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
            [userdefat setObject:@"1" forKey:@"isLogin"];
            [userdefat setObject:model.token forKey:@"token"];
            [userdefat setObject:model.refreshtoken forKey:@"refreshtoken"];
            [userdefat setObject:model.userId forKey:@"userId"];
            [userdefat setObject:username forKey:@"username"];
            [userdefat setObject:password forKey:@"password"];
            [userdefat synchronize];
            [[APIResult sharedClient] getUserInfo];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            KKTabbarController * main = [[KKTabbarController alloc] init];
            appDelegate.window.rootViewController = main;
        }
        if ([[response objectForKey:@"code"] intValue]==1005) {
            [SVProgressHUD showInfoWithStatus:@"You have registered"];
            
        }
    } failure:^(NSError *error) {
         [XYLoadingHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"Please check your network"];
    }];

}

-(void)chooseboyClick
{
    [[XYLogManager shareManager] addLogKey1:@"sign_up" key2:@"click" content:@{@"result":@(3)} userInfo:[NSDictionary new] upload:YES];
    [SVProgressHUD showInfoWithStatus:@"Please select your gender and you cann't change once selected"];
    [self.boyBtn setImage:[UIImage imageNamed:@"nan"] forState:normal];
    [self.girlBtn setImage:[UIImage imageNamed:@"nv"] forState:normal];
    self.boyLab.textColor = MainColor;
    self.girlLab.textColor = [UIColor colorWithHexString:@"999999"];
    self.sex = @"m";
}

-(void)choosegirlClick
{
    [[XYLogManager shareManager] addLogKey1:@"sign_up" key2:@"click" content:@{@"result":@(4)} userInfo:[NSDictionary new] upload:YES];
    [SVProgressHUD showInfoWithStatus:@"Please select your gender and you cann't change once selected"];
    [self.boyBtn setImage:[UIImage imageNamed:@"nan-1"] forState:normal];
    [self.girlBtn setImage:[UIImage imageNamed:@"nv-1"] forState:normal];
    self.girlLab.textColor = MainColor;
    self.boyLab.textColor = [UIColor colorWithHexString:@"999999"];
    self.sex = @"f";
}


#pragma mark - YBAttributeTapActionDelegate

- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    NSString *terms_of_services = [NSString new];
    if ([string isEqualToString:@"Terms of Servoce"]) {
        terms_of_services = [[KKStatisticalManager shareTools] getLocalTermsSeveiceUrl];
    }else{
        terms_of_services = [[KKStatisticalManager shareTools] getLocalPrivacyPolicyUrl];

    }
    SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:terms_of_services]];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - leftClick

-(void)leftbtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
