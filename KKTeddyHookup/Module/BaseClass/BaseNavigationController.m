//
//  BaseNavigationController.m
//  XToolWhiteNoiseIOS
//
//  Created by PanZhi on 2018/7/25.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"


@interface BaseNavigationController ()  <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"C6C6C6"];
    self.navigationController.navigationBar.translucent = NO;
    
    // 设置Appearance效果
    [self xt_setAppearance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)xt_setAppearance {
    
    // Titlte颜色和字体大小
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    // 背景图片/颜色
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(kScreenWidth, kNavBarHeight)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    // 取消透明效果
    [UINavigationBar appearance].translucent = NO;
    
    // 两侧Item颜色
//    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    // 底部横线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    // 状态栏白色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
}

// 拦截push操作,非根控制器push时隐藏TabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 侧滑手势关闭
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 以下处理自定义NavigationView时右滑失效的问题
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    
    UIViewController *currentController = self.topViewController;
    if ([currentController isKindOfClass:[BaseViewController class]]) {
        BaseViewController *baseController = (BaseViewController *)currentController;
        return [baseController backToPreviousByGesture];
    }
    
    return YES;
}

// 允许同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// 禁止响应手势的是否ViewController中scrollView跟着滚动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}


// 控制器入栈之后,启用手势识别
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}


@end
