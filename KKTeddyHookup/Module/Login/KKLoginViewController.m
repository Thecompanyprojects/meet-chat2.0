//
//  LoginViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKLoginViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "KKinputView.h"
#import "KKbottomView.h"
#import "KKLogupViewController.h"
#import "KKTabbarController.h"
#import "KKChoosesexView.h"

@interface KKLoginViewController ()<GIDSignInUIDelegate,GIDSignInDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIButton *facebookBtn;
@property (nonatomic,strong) UIButton *googleBtn;
@property (nonatomic,strong) UIImageView *LogoImg;
@property (nonatomic,strong) KKinputView *textView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *logupBtn;
@property (nonatomic,strong) KKbottomView *bottom;
@end

@implementation KKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.LogoImg];
    [self.view addSubview:self.textView];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.logupBtn];
    [self.view addSubview:self.bottom];
    [self setuplayout];
    [self setUserInfo];

}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.LogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_offset(75);
        make.height.mas_offset(75);
        make.top.equalTo(weakSelf.view).with.offset(64+40);
    }];
    
    [weakSelf.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.LogoImg.mas_bottom).with.offset(72);
        make.right.equalTo(weakSelf.view).with.offset(-20);
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.height.mas_offset(150);
    }];
    
    [weakSelf.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
             make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(18);
        }
        else
        {
             make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(52*KHEIGHT);
        }
        make.height.mas_offset(40);
        make.centerX.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view).with.offset(42*KWIDTH);
    }];
    
    [weakSelf.logupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        if (IS_IPHONE_5) {
              make.top.equalTo(weakSelf.loginBtn.mas_bottom).with.offset(12);
        }
        else
        {
             make.top.equalTo(weakSelf.loginBtn.mas_bottom).with.offset(28);
        }
        make.width.mas_offset(200);
        make.height.mas_offset(16);
    }];
    
    [weakSelf.bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_offset(84*KHEIGHT);
        make.bottom.equalTo(weakSelf.view);
    }];
}

-(void)setUserInfo
{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    self.textView.phoneText.text = username?:@"";
//    self.textView.passwordText.text = password?:@"";
}

#pragma mark - getters

-(UIImageView *)LogoImg
{
    if(!_LogoImg)
    {
        _LogoImg = [[UIImageView alloc] init];
        _LogoImg.layer.cornerRadius = 75/2;
        _LogoImg.image = [UIImage imageNamed:@"userimg"];
    }
    return _LogoImg;
}

-(UIButton *)facebookBtn
{
    if(!_facebookBtn)
    {
        _facebookBtn = [[UIButton alloc] init];
        [_facebookBtn setTitle:@"faceBook" forState:normal];
        [_facebookBtn addTarget:self action:@selector(facebtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookBtn;
}

-(UIButton *)googleBtn
{
    if(!_googleBtn)
    {
        _googleBtn = [[UIButton alloc] init];
        [_googleBtn addTarget:self action:@selector(googleBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_googleBtn setTitle:@"google" forState:normal];
    }
    return _googleBtn;
}

-(KKinputView *)textView
{
    if(!_textView)
    {
        _textView = [[KKinputView alloc] init];
        _textView.type = @"0";
    }
    return _textView;
}

-(UIButton *)loginBtn
{
    if(!_loginBtn)
    {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"Log In" forState:normal];
        _loginBtn.backgroundColor = MainColor;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_loginBtn addTarget:self action:@selector(loginBtnclick) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 20;
    }
    return _loginBtn;
}

-(UIButton *)logupBtn
{
    if(!_logupBtn)
    {
        _logupBtn = [[UIButton alloc] init];
        [_logupBtn addTarget:self action:@selector(logupBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_logupBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
        [_logupBtn setTitle:@"Sign Up" forState:normal];
        _logupBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_logupBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    }
    return _logupBtn;
}

-(KKbottomView *)bottom
{
    if(!_bottom)
    {
        _bottom = [[KKbottomView alloc] init];
        [_bottom.facebookBtn addTarget:self action:@selector(facebtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottom.googleBtn addTarget:self action:@selector(googleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottom;
}


#pragma mark - 实现方法

-(void)loginBtnclick
{
    [self logmanagerWith:@"2"];
    if (self.textView.phoneText.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"Please enter a user phone"];
        return;
    }
    if (self.textView.passwordText.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"Please enter a password"];
        return;
    }
    NSString *username = self.textView.phoneText.text;
    NSString *password = self.textView.passwordText.text;
    [XYLoadingHUD show];
    NSDictionary *dic = @{@"username":username,@"password":password};
    [[AFNetAPIClient sharedClient] requestUrl:LOGIN cParameters:dic success:^(NSDictionary * response) {
        if ([[response objectForKey:@"code"] intValue]==1) {
            NSDictionary *data = [response objectForKey:@"data"];
            KKUserModel *model = [KKUserModel sharedUserModel];
            model.userId = [data objectForKey:@"id"];
            model.token = [data objectForKey:@"token"];
            model.refreshtoken = [data objectForKey:@"refreshtoken"];
            model.name = [data objectForKey:@"name"];
            model.sex = [data objectForKey:@"sex"];
            NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
            [userdefat setObject:@"1" forKey:@"isLogin"];
            [userdefat setObject:model.token forKey:@"token"];
            [userdefat setObject:model.refreshtoken forKey:@"refreshtoken"];
            [userdefat setObject:model.userId forKey:@"userId"];
            [userdefat setObject:username forKey:@"username"];
            [userdefat setObject:password forKey:@"password"];
            [userdefat setObject:model.sex forKey:@"sex"];
            [userdefat synchronize];
            
            [[XYLogManager shareManager] addLogKey1:@"login" key2:@"click_login" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
            
            [[APIResult sharedClient] getUserInfo];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            KKTabbarController * main = [[KKTabbarController alloc] init];
            appDelegate.window.rootViewController = main;
        }
        if ([[response objectForKey:@"code"] intValue]==1006) {
            [SVProgressHUD showInfoWithStatus:@"Please register an account"];
            [[XYLogManager shareManager] addLogKey1:@"login" key2:@"click_login" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
        }
        [XYLoadingHUD dismiss];
    } failure:^(NSError * error) {
        [XYLoadingHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"Please check your network"];
        [[XYLogManager shareManager] addLogKey1:@"login" key2:@"click_login" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
    }];
}

-(void)logupBtnclick
{
    [self logmanagerWith:@"3"];
    KKLogupViewController *vc = [KKLogupViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)facebtnClick {
    [self logmanagerWith:@"5"];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"email"]
                        fromViewController:self
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       //TODO: process error or result
                                       //注意这里面通过result是拿不到邮箱的
                                       
                                       NSString *token = [NSString stringWithFormat:@"%@",result.token.tokenString];
             
                                       NSLog(@"token-----%@",token);
                                       if (token.length>8) {
                                           [self getUserInfoWithResult:result];
                                       }

                                   }];
}

/**
 获取用户信息 picture用户头像

 @param result 获取用户信息 picture用户头像
 */
- (void)getUserInfoWithResult:(FBSDKLoginManagerLoginResult *)result
{
    NSDictionary*params= @{@"fields":@"id,name,email,age_range,first_name,last_name,link,gender,locale,picture,timezone,updated_time,verified"};
    [XYLoadingHUD show];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:result.token.userID
                                  parameters:params
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        if (![result isKindOfClass:[NSNull class]]) {
            NSString *thirdpartyid = [result objectForKey:@"id"]?:@"";
            NSString *sex = @"";
            NSDictionary *dic = @{@"thirdpartyid":thirdpartyid,@"sex":sex};
            NSDictionary *para = @{@"data":dic};
            NSString *url = [ServerIP stringByAppendingString:ThirdLogin];
            [[XYNetworkRequest manager] requestUrl:url Parameters:para success:^(NSDictionary *response) {
                if ([[response objectForKey:@"code"] intValue]==1) {
                    NSDictionary *data = [response objectForKey:@"data"];
                    KKUserModel *model = [KKUserModel sharedUserModel];
                    model.userId = [data objectForKey:@"id"];
                    model.token = [data objectForKey:@"token"];
                    model.refreshtoken = [data objectForKey:@"refreshtoken"];
                    model.name = [data objectForKey:@"name"];
                    model.sex = [data objectForKey:@"sex"];
                    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
                    [userdefat setObject:@"1" forKey:@"isLogin"];
                    [userdefat setObject:model.token forKey:@"token"];
                    [userdefat setObject:model.refreshtoken forKey:@"refreshtoken"];
                    [userdefat setObject:model.userId forKey:@"userId"];
                    [userdefat setObject:model.sex forKey:@"sex"];
                    [userdefat synchronize];
                    [[APIResult sharedClient] getUserInfo];
                    if (model.sex.length==0) {
                        [self showChoosewithuserid:model.userId];
                    }
                    else
                    {
                        [[XYLogManager shareManager] addLogKey1:@"login" key2:@"three_party_login" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
                        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        KKTabbarController * main = [[KKTabbarController alloc] init];
                        appDelegate.window.rootViewController = main;
                    }

                }
                 [XYLoadingHUD dismiss];
            } failure:^(NSError *error) {
                 [XYLoadingHUD dismiss];
                 [[XYLogManager shareManager] addLogKey1:@"login" key2:@"three_party_login" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
            }];
        }
        
    }];
}


-(void)googleBtnclick
{
    [self logmanagerWith:@"4"];
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [[GIDSignIn sharedInstance] signIn];
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error
{
    
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController
{
    
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    NSString *userID = user.userID;
    if (userID.length!=0) {
        NSString *thirdpartyid = userID?:@"";
        NSString *sex = @"";
        NSDictionary *dic = @{@"thirdpartyid":thirdpartyid,@"sex":sex};
        NSDictionary *para = @{@"data":dic};
        NSString *url = [ServerIP stringByAppendingString:ThirdLogin];
        [XYLoadingHUD show];
        [[XYNetworkRequest manager] requestUrl:url Parameters:para success:^(NSDictionary *response) {
             [XYLoadingHUD dismiss];
            if ([[response objectForKey:@"code"] intValue]==1) {
                NSDictionary *data = [response objectForKey:@"data"];
                KKUserModel *model = [KKUserModel sharedUserModel];
                model.userId = [data objectForKey:@"id"];
                model.token = [data objectForKey:@"token"];
                model.refreshtoken = [data objectForKey:@"refreshtoken"];
                model.name = [data objectForKey:@"name"];
                model.sex = [data objectForKey:@"sex"];
                NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
                [userdefat setObject:@"1" forKey:@"isLogin"];
                [userdefat setObject:model.token forKey:@"token"];
                [userdefat setObject:model.refreshtoken forKey:@"refreshtoken"];
                [userdefat setObject:model.userId forKey:@"userId"];
                [userdefat setObject:model.sex forKey:@"sex"];
                [userdefat synchronize];
                [[APIResult sharedClient] getUserInfo];
                if (model.sex.length==0) {
                     [self showChoosewithuserid:model.userId];
                }
                else
                {
                    [[XYLogManager shareManager] addLogKey1:@"login" key2:@"three_party_login" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
                   AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                   KKTabbarController * main = [[KKTabbarController alloc] init];
                   appDelegate.window.rootViewController = main;
                }
            }
        } failure:^(NSError *error) {
             [XYLoadingHUD dismiss];
             [[XYLogManager shareManager] addLogKey1:@"login" key2:@"three_party_login" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
        }];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[GIDSignIn sharedInstance] signOut];
}

-(void)showChoosewithuserid:(NSString *)userid
{
    KKChoosesexView *alert = [[KKChoosesexView alloc] init];
    [alert withrepylClick:^(NSString * _Nonnull string) {
        NSLog(@"reply%@",string);
        int idint = [userid intValue];
        NSDictionary *para = @{@"id":@(idint),@"sex":string?:@""};
        [XYLoadingHUD show];
        [[AFNetAPIClient sharedClient] requestUrl:UPloadsex cParameters:para success:^(NSDictionary * _Nonnull requset) {
            [XYLoadingHUD dismiss];
            if ([[requset objectForKey:@"code"] intValue]==1) {
                [[XYLogManager shareManager] addLogKey1:@"login" key2:@"three_party_login" content:@{@"result":@(0)} userInfo:[NSDictionary new] upload:YES];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                KKTabbarController * main = [[KKTabbarController alloc] init];
                appDelegate.window.rootViewController = main;
            }
            else
            {
                [[XYLogManager shareManager] addLogKey1:@"login" key2:@"three_party_login" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
            }
        } failure:^(NSError * _Nonnull error) {
            [XYLoadingHUD dismiss];
            [[XYLogManager shareManager] addLogKey1:@"login" key2:@"three_party_login" content:@{@"result":@(1)} userInfo:[NSDictionary new] upload:YES];
        }];
        
    }];
}

#pragma mark - 登录打点上报

-(void)logmanagerWith:(NSString *)typeStr
{
   // result:0/1/2/3/4/5 0:phone_number 1:pwd 2:login 3:sign_up 4:google 5:fb
    NSInteger inter = [typeStr integerValue];
    [[XYLogManager shareManager] addLogKey1:@"login" key2:@"click" content:@{@"result":@(inter)} userInfo:[NSDictionary new] upload:YES];
}



@end
