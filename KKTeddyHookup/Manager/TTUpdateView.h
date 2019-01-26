//
//  TTUpdateView.h
//  VideoPlayer
//
//  Created by KevinXu on 2018/11/22.
//  Copyright © 2018 KevinXu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 默认更新提醒文字
static NSString *TTDefaultUpdateTipsString = @"Hey, there is a new version for you, update and enjoy the latest Chat Style.";


@interface TTUpdateView : UIView

/**
 弹出更新提示
 默认更新按钮文字:Update;
 默认图片:update_image;
 默认居中对齐;
 默认提示文字:TTDefaultUpdateTipsString
 
 @param updateNow       是否必须更新
 @param handleBlock     回调处理,YES:立即更新;NO:关闭弹窗
 */
+ (void)showUpdateViewUpdate:(BOOL)updateNow
                 handleBlock:(void(^)(BOOL update))handleBlock;

/**
 弹出更新提示
 默认更新按钮文字:Update;
 默认图片:update_image;
 默认居中对齐
 
 @param info            更新内容
 @param updateNow       是否必须更新
 @param handleBlock     回调处理,YES:立即更新;NO:关闭弹窗
 */
+ (void)showUpdateViewWithInfo:(NSString *)info
                  shouldUpdate:(BOOL)updateNow
                   handleBlock:(void(^)(BOOL update))handleBlock;

/**
 弹出更新提示
 默认更新按钮文字:Update;
 默认图片:update_image
 
 @param info            更新内容
 @param textAlignment   对齐方式
 @param updateNow       是否必须更新
 @param handleBlock     回调处理,YES:立即更新;NO:关闭弹窗
 */
+ (void)showUpdateViewWithInfo:(NSString *)info
             infoTextAlignment:(NSTextAlignment)textAlignment
                  shouldUpdate:(BOOL)updateNow
                   handleBlock:(void(^)(BOOL update))handleBlock;


/**
 弹出更新提示
 默认更新按钮文字:Update
 
 @param info            更新内容
 @param textAlignment   对齐方式
 @param imageUrl        图片链接
 @param updateNow       是否必须更新
 @param handleBlock     回调处理,YES:立即更新;NO:关闭弹窗
 */
+ (void)showUpdateViewWithInfo:(NSString *)info
             infoTextAlignment:(NSTextAlignment)textAlignment
                headerImageURL:(NSString *)imageUrl
                  shouldUpdate:(BOOL)updateNow
                   handleBlock:(void(^)(BOOL update))handleBlock;


/**
 弹出更新提示

 @param info            更新内容
 @param textAlignment   对齐方式
 @param imageUrl        图片链接
 @param updateText      更新按钮文字
 @param updateNow       是否必须更新
 @param handleBlock     回调处理,YES:立即更新;NO:关闭弹窗
 */
+ (void)showUpdateViewWithInfo:(NSString *)info
             infoTextAlignment:(NSTextAlignment)textAlignment
                headerImageURL:(NSString *)imageUrl
              updateButtonText:(NSString *)updateText
                  shouldUpdate:(BOOL)updateNow
                   handleBlock:(void(^)(BOOL update))handleBlock;


/**
 关闭弹窗
 强制更新情况下该方法不可用
 */
+ (void)dismissUpdateView;

@end


@interface TTUpdateTool : NSObject


/**
 打开AppStore指定App页面

 @param appID App在AppStored中的编号,在iTunes Connect账号中查找;
 */
+ (void)openAppStoreWithAppID:(NSString *)appID;

@end

