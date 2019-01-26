//
//  XTTabBarController.m
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/10/15.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "KKTabbarController.h"
#import "BaseNavigationController.h"
#import "KKDiscoverViewController.h"
#import "KKMessageListViewController.h"
#import "KKRecommendViewController.h"
#import "KKPersonalViewController.h"
#import "KKVideoListController.h"
#import "KKPeopleViewController.h"
#import "KKShakeViewController.h"
#import "KKBottleViewController.h"
#import "UITabBar+badge.h"
#import "SqliteManager.h"


//#import "activityViewController.h"

@interface KKTabbarController () <UITabBarControllerDelegate>
@property(nonatomic,strong)KKMessageListViewController *messageController;
@end

@implementation KKTabbarController

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xt_setAppearance];
    [self xt_setControllers];
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMessage) name:@"MessageTab" object:nil];
    [self loadMessage];
    [self sqliteUpdateItems];
}
-(void)loadMessage{
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"cornerMarList"];
    if(!dic){
        [self.tabBar hideBadgeOnItemIndex:self.viewControllers.count - 2];
    }else{
        NSArray *arr = [dic allKeys];
        NSInteger bedgeValue = 0;
        for (NSInteger i = 0; i < arr.count; i++) {
            NSLog(@"%@ : %@", arr[i], [dic objectForKey:arr[i]]); // dic[arr[i]]
            bedgeValue += [[dic objectForKey:arr[i]] integerValue];
        }
        if (bedgeValue > 0) {
            [self.tabBar showBadgeOnItemIndex:self.viewControllers.count - 2];
        }else{
            [self.tabBar hideBadgeOnItemIndex:self.viewControllers.count - 2];
        }
    }
    
}
- (void)xt_setAppearance {
    self.delegate = self;
    // 未选中字体颜色和字号
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kHexColor(0x8f8f8f), NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    // 选中字体颜色和字号
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kHexColor(0xF8438B), NSFontAttributeName:[UIFont systemFontOfSize:10] } forState:UIControlStateSelected];
    
    // 设置文字的位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    // 取消透明效果
    [UITabBar appearance].translucent = NO;
    
    // 设置背景色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    // 设置分割线颜色
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(kScreenWidth, kTabBarHeight)]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.9 alpha:1.0] size:CGSizeMake(kScreenWidth, 0.5)]];
}

- (void)xt_setControllers {
    
    NSArray * tabbars = [[NSUserDefaults standardUserDefaults] objectForKey:@"tabbar"];
    if (tabbars && [tabbars isKindOfClass:[NSArray class]]) { //默认显示
        for (NSString * tab in tabbars) {
            if ([tab isEqual:@"recommend"]) {
                KKRecommendViewController *recommendController = [KKRecommendViewController new];
                [self addChildController:recommendController
                                   title:NSLocalizedString(@"Recommend", nil)
                             imageNormal:@"recommand"
                           imageSelected:@"star"];
            }else if([tab isEqual:@"discover"]){
                KKDiscoverViewController *discoverController = [KKDiscoverViewController new];
                [self addChildController:discoverController
                                   title:NSLocalizedString(@"Discover", nil)
                             imageNormal:@"发现"
                           imageSelected:@"faxian"];
            }else if([tab isEqual:@"video"]){
                KKVideoListController * videoController = [KKVideoListController new];
                [self addChildController:videoController
                                   title:NSLocalizedString(@"Video", nil)
                             imageNormal:@"视频"
                           imageSelected:@"t_video"];
            }else if([tab isEqual:@"active"]){ //活跃的人
                KKPeopleViewController *peple = [[KKPeopleViewController alloc]init];
                [self addChildController:peple
                                   title:NSLocalizedString(@"activePeple", nil)
                             imageNormal:@"huoyue"
                           imageSelected:@"select_huoyue"];
            }else if([tab isEqual:@"shake"]){ //摇一摇
                KKShakeViewController * shake = [[KKShakeViewController alloc]init];
                [self addChildController:shake
                                   title:NSLocalizedString(@"shake", nil)
                             imageNormal:@"yaoyiyao"
                           imageSelected:@"select_yaoyiyao"];
            }else if([tab isEqual:@"drifter"]){//漂流瓶
                KKBottleViewController *bottle = [[KKBottleViewController alloc]init];
                [self addChildController:bottle
                                   title:NSLocalizedString(@"drifter", nil)
                             imageNormal:@"paoliuping"
                           imageSelected:@"select_paoliuping"];
            }else if([tab isEqual:@"hot"]){  //热门
                KKPaymentViewController * paymentController = [[KKPaymentViewController alloc] init];
                [self addChildController:paymentController
                                   title:NSLocalizedString(@"hot", nil)
                             imageNormal:@"lihe"
                           imageSelected:@"select_lihe"];
            }
        }
        self.messageController = [KKMessageListViewController new];
        [self addChildController:self.messageController
                           title:NSLocalizedString(@"Message", nil)
                     imageNormal:@"信息"
                   imageSelected:@"xinxi"];
        
        KKPersonalViewController *personalViewController = [KKPersonalViewController new];
        [self addChildController:personalViewController
                           title:NSLocalizedString(@"Mine", nil)
                     imageNormal:@"我的"
                   imageSelected:@"wode"];

    }else{
        KKRecommendViewController *recommendController = [KKRecommendViewController new];
        [self addChildController:recommendController
                           title:NSLocalizedString(@"Recommend", nil)
                     imageNormal:@"recommand"
                   imageSelected:@"star"];
        
        KKDiscoverViewController *discoverController = [KKDiscoverViewController new];
        [self addChildController:discoverController
                           title:NSLocalizedString(@"Discover", nil)
                     imageNormal:@"发现"
                   imageSelected:@"faxian"];
        
        KKVideoListController * videoController = [KKVideoListController new];
        [self addChildController:videoController
                           title:NSLocalizedString(@"Video", nil)
                     imageNormal:@"视频"
                   imageSelected:@"t_video"];
        
        self.messageController = [KKMessageListViewController new];
        [self addChildController:self.messageController
                           title:NSLocalizedString(@"Message", nil)
                     imageNormal:@"信息"
                   imageSelected:@"xinxi"];
        
        KKPersonalViewController *personalViewController = [KKPersonalViewController new];
        [self addChildController:personalViewController
                           title:NSLocalizedString(@"Mine", nil)
                     imageNormal:@"我的"
                   imageSelected:@"wode"];

    }
    

}
- (void)addChildController:(UIViewController *)controller title:(NSString *)title imageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected {
    controller.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]?:[self xt_placeholderImage];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]?:[self xt_placeholderImage_sel];
    [controller.tabBarItem setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
}


#pragma mark - <UITabBarControllerDelegate>
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSInteger index = [tabBarController.childViewControllers indexOfObject:viewController];
    if (index == tabBarController.selectedIndex) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTabBarItemClickNotificationName object:nil userInfo:@{@"index":@(index)}];
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    // 获取 UITabBarButton
    UIControl *button = [viewController.tabBarItem valueForKey:@"view"];
    // 创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.1,@0.9,@1.0];
    animation.duration = 0.25;
    animation.calculationMode = kCAAnimationCubic;
    // 添加动画
    [button.layer addAnimation:animation forKey:nil];
}

// 获取UITabBarButton
- (UIControl *)getTabBarButton {
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc] initWithCapacity:0];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    return tabBarButton;
}


- (UIImage *)xt_placeholderImage {
    UIImage *placeholderimage = [UIImage imageWithColor:kHexColor(0x8f8f8f) size:CGSizeMake(22, 22)];
    return [placeholderimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)xt_placeholderImage_sel {
    UIImage *placeholderimage_sel = [UIImage imageWithColor:kHexColor(0xBB52FE) size:CGSizeMake(22, 22)];
    return [placeholderimage_sel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
}


/*
 数据库更新
 */
-(void)sqliteUpdateItems{
    
    NSString * sessionId = [NSString stringWithFormat:@"%@_list",[NSString stringWithFormat:@"%@",[KKUserModel sharedUserModel].userId]];
    [[SqliteManager sharedInstance] updateTableDField:@[@"sendError"] WithType:DBChatType_Private sessionID:sessionId];
}
@end
