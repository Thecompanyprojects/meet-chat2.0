//
//  XTaboutViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/31.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKAboutViewController.h"
#import <FCUUID/UIDevice+FCUUID.h>
#import <SafariServices/SafariServices.h>

@interface KKAboutViewController ()
@property (nonatomic,strong) UIImageView *logoImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *versionLab;
@property (nonatomic,strong) UIButton * serviceBtn;
@property (nonatomic,strong) UIButton * privacyBtn;
@end

@implementation KKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.versionLab];
    [self.view addSubview:self.privacyBtn];
    [self.view addSubview:self.serviceBtn];
    
#if DEBUG
    UILabel *deviceLabel = [[UILabel alloc] init];
    deviceLabel.textColor = [UIColor redColor];
    deviceLabel.text = [FCUUID uuidForDevice];
    deviceLabel.numberOfLines = 0;
    deviceLabel.textAlignment = NSTextAlignmentCenter;
    deviceLabel.font = [UIFont systemFontOfSize:17];
    deviceLabel.frame = CGRectMake(20, kScreenHeight/2.0, kScreenWidth - 40, 60);
    
    deviceLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deviceLabelTapEnent:)];
    [deviceLabel addGestureRecognizer:tap];
    [self.view addSubview:deviceLabel];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.textColor = [UIColor redColor];
    tipsLabel.text = @"点击字符串复制";
    tipsLabel.numberOfLines = 0;
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font = [UIFont systemFontOfSize:17];
    tipsLabel.frame = CGRectMake(20, kScreenHeight/2.0 + 60, kScreenWidth -40, 40);
    [self.view addSubview:tipsLabel];
#endif
    
    
    [self setuplayout];
}

- (void)deviceLabelTapEnent:(UITapGestureRecognizer *)sender {
    UILabel *label = (UILabel *)sender.view;
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"复制成功!\n%@",label.text]];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = label.text;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(81);
        make.height.mas_offset(81);
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).with.offset(170);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.logoImg.mas_bottom).with.offset(27);
        make.left.equalTo(weakSelf.view).with.offset(20);
        
    }];
    [weakSelf.versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.nameLab).with.offset(43);
        make.left.equalTo(weakSelf.view).with.offset(20);
    }];
    

    [weakSelf.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).with.offset(-30 - (isIPhoneX ? 22:0));
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.width.mas_offset(120);
        make.height.mas_offset(20);
    }];

    [weakSelf.privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).with.offset(-30- (isIPhoneX ? 22:0));
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.width.mas_offset(120);
        make.height.mas_offset(20);
        
    }];
}


-(void)webClick:(UIButton *)sender{

    NSString *terms_of_services = [NSString new];
    if (sender.tag == 100) {
        terms_of_services = [[KKStatisticalManager shareTools] getLocalPrivacyPolicyUrl];
    }else{
        terms_of_services = [[KKStatisticalManager shareTools] getLocalTermsSeveiceUrl];
    }
    SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:terms_of_services]];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - getters

-(UIButton *)privacyBtn{
    if (!_privacyBtn) {
        _privacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_privacyBtn setTitle:NSLocalizedString(@"Privacy Policy", nil) forState:UIControlStateNormal];
        [_privacyBtn setTitleColor:[UIColor colorWithHexString:@"#B1B1B1"] forState:UIControlStateNormal];
        _privacyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_privacyBtn addTarget:self action:@selector(webClick:) forControlEvents:UIControlEventTouchUpInside];
        _privacyBtn.tag = 100;
    
    }
    
    return _privacyBtn;
}
-(UIButton *)serviceBtn{
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn setTitle:NSLocalizedString(@"Terms of Service", nil) forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:[UIColor colorWithHexString:@"#B1B1B1"] forState:UIControlStateNormal];
        _serviceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_serviceBtn addTarget:self action:@selector(webClick:) forControlEvents:UIControlEventTouchUpInside];
        _serviceBtn.tag = 101;
    }
    return _serviceBtn;
}
-(UIImageView *)logoImg
{
    if(!_logoImg)
    {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"LOGO"];
        _logoImg.layer.masksToBounds = YES;
        _logoImg.layer.cornerRadius = 8;
    }
    return _logoImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.text = @"Teddy Hookup";
        _nameLab.font = [UIFont systemFontOfSize:16];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _nameLab;
}

-(UILabel *)versionLab
{
    if(!_versionLab)
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _versionLab = [[UILabel alloc] init];
        _versionLab.textAlignment = NSTextAlignmentCenter;
        _versionLab.text = [NSString stringWithFormat:@"V%@",app_Version];
        _versionLab.textColor = [UIColor colorWithHexString:@"B1B1B1"];
        _versionLab.font = [UIFont systemFontOfSize:14];
    }
    return _versionLab;
}

@end
