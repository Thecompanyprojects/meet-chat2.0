//
//  MessageItem.h
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//


#define MMessageImageSizeWidth 150


#import "BaseItem.h"


@interface MessageItem : BaseItem
@property (nonatomic, copy) NSString * chatId;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) long long  createDate;
@property (nonatomic, assign) long long  updateDate;
@property (nonatomic,assign) NSInteger msgType;        //消息类型 // 0 是文本 1是图片 2是语音  3是gif
@property (nonatomic,assign)NSInteger unreadCount;//未读消息
@property (nonatomic, copy) NSString * sendUserId;
@property (nonatomic,assign)NSInteger sendError;//发送是否成功 0->发送成功 1->发送失败
@end
