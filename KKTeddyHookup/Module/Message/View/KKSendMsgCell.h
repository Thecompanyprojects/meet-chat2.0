//
//  SendMsgCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//




@class MessageItem;

@interface KKSendMsgCell : UITableViewCell
@property(nonatomic,assign)id<CellPassDelegate> delegate;
@property(nonatomic,strong)NSIndexPath * indexPath;
- (void)setContentMsg:(MessageItem *)msgItem;
@property(nonatomic,strong)MessageItem * msgItem;
@end
