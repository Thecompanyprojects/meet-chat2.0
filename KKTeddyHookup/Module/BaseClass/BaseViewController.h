//
//  BaseViewController.h
//  XToolWhiteNoiseIOS
//
//  Created by PanZhi on 2018/7/25.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, AdmobType)   {
    Adwithlike = 0,
    Adwithalive = 1,
    Adwithshake = 2,
    Adwithsetbottle = 3,
    Adwithsayhi = 4,
    Adwithgetbottle = 5
};

@interface BaseViewController : UIViewController

@property (nonatomic,assign) AdmobType adType;

/**
 从堆栈中移除
 */
- (void)removeFromNavigationStack;


/**
 打开一个链接
 */
- (void)pushWebViewController:(NSString *)url;


/**
 设置下一级的返回按钮文字
 */
- (void)setBackButtonItemText:(NSString *)text;

/**
 是否可以侧滑返回
 */
- (BOOL)backToPreviousByGesture;


/**
 订阅页面弹出
 */
- (void)showPaymentViewController;

/**
 广告弹出
 */
//-(void)showAdViewControllerKey:(NSString *)getkey scene:(NSString*)scene withloadsence:(NSString *)loadsence;



/**
 导航栏下面的那条线消失
 */
-(void)delNavLine;

#pragma mark - 弹出激励视频选择项目

/**
 Active部分弹出激励视频
 */
-(void)adVideowithActive;

/**
 Sayhi部分弹出激励视频
 */
-(void)adVideowithSayhi;

/**
 滑动喜欢 弹出激励视频
 */
-(void)adVideowithlike;

/**
 扔漂流瓶  弹出激励视频
 */
-(void)adVideowithbottle;

/**
 捡漂流瓶 弹出激励视频
 */
-(void)adVideowithgetbottle;


/**
 摇一摇 弹出激励视频
 */
-(void)adVideowithshake;



/**
 是否需要上传头像

 @return TRUE 需要上传头像  
 */
-(BOOL)isshouldUpload;


/**
 头像上传
 */
-(void)UploadthePhoto;

/**
 滑动撤回 弹出激励视频
 */
-(void)adVideowithSlideCRecall;

@end
