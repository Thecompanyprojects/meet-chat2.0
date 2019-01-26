//
//  loginnavController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/17.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKloginnavController.h"
#import "KKLoginViewController.h"
#import "KKLogupViewController.h"

@interface KKloginnavController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation KKloginnavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    // 设置全屏滑动返回
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

-(void)handleNavigationTransition:(UIPanGestureRecognizer *)pand
{
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
 
    BOOL isHideNav = ([viewController isKindOfClass:[KKLogupViewController class]] ||
                      [viewController isKindOfClass:[KKLoginViewController class]]);
    
  
    [self setNavigationBarHidden:isHideNav animated:YES];
}

@end
