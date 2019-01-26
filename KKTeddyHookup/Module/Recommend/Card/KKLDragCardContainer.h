//
//  YFLDragCardContainer.h
//  YFLDragCardViewProject
//
//  Created by YangShuai on 2018/10/16.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLDragCardView.h"
@class KKLDragCardContainer;

@protocol YFLDragCardContainerDataSource <NSObject>

@required

/** 数据源个数 **/
- (NSInteger)numberOfRowsInYFLDragCardContainer:(KKLDragCardContainer *)container;

/** 显示数据源 **/
- (KKLDragCardView *)container:(KKLDragCardContainer *)container viewForRowsAtIndex:(NSInteger)index;

@end

@protocol YFLDragCardContainerDelegate <NSObject>

@optional

/** 点击卡片回调 **/
- (void)container:(KKLDragCardContainer *)container didSelectRowAtIndex:(NSInteger)index;

/** 拖到最后一张卡片 YES，空，可继续调用reloadData分页数据**/
- (void)container:(KKLDragCardContainer *)container dataSourceIsEmpty:(BOOL)isEmpty;

/**  当前cardview 是否可以拖拽，默认YES **/
- (BOOL)container:(KKLDragCardContainer *)container canDragForCardView:(KKLDragCardView *)cardView;

/** 卡片处于拖拽中回调**/
- (void)container:(KKLDragCardContainer *)container dargingForCardView:(KKLDragCardView *)cardView direction:(ContainerDragDirection)direction widthRate:(float)widthRate  heightRate:(float)heightRate;

/** 卡片拖拽结束回调（卡片消失） **/
- (void)container:(KKLDragCardContainer *)container dragDidFinshForDirection:(ContainerDragDirection)direction forCardView:(KKLDragCardView *)cardView;

/** 卡片拖拽（卡片消失） **/
- (void)container:(KKLDragCardContainer *)container dragDisappearForDirection:(ContainerDragDirection)direction forCardView:(KKLDragCardView *)cardView;

@end


@interface KKLDragCardContainer : UIView


/** 初始化方法 **/
- (instancetype)initWithFrame:(CGRect)frame configure:(KKLDragConfigure*)configure;

/** 默认初始化方法 **/
- (instancetype)initWithFrame:(CGRect)frame;

/** 数据源代理 **/
@property (nonatomic, weak, nullable) id <YFLDragCardContainerDataSource> dataSource;

/**  动作代理 **/
@property (nonatomic, weak, nullable) id <YFLDragCardContainerDelegate> delegate;

/** 刷新数据 **/
- (void)reloadData;

/** 主动调用拖拽 **/
- (void)removeCardViewForDirection:(ContainerDragDirection)direction;

/** 主动调用撤回*/
-(void)addCardViewForDirection:(ContainerDragDirection)direction withCardView:(KKLDragCardView *)cardView;

/** 获取显示当前卡片 **/
- (KKLDragCardView *)getCurrentShowCardView;

/** 获取显示当前卡片的index **/
- (NSInteger)getCurrentShowCardViewIndex;

@end
