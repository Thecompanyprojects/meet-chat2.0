//
//  MessageCell.h
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//



@class MessageItem;

@interface KKMessageCell : UITableViewCell
//@property(nonatomic,strong)MessageItem * item;
- (void)setMessageContent:(MessageItem *)item;
@end
