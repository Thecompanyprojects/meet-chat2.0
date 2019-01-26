//
//  ServiceController.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/11/3.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKServiceController.h"

@interface KKServiceController ()<UIWebViewDelegate>

@end

@implementation KKServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
    
}



@end
