//
//  ReciveMsgCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//



@class MessageItem;

@interface KKReciveMsgCell : UITableViewCell
@property (weak,nonatomic)IBOutlet UIImageView * vipView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic,assign)id<CellPassDelegate> delegate;
@property(nonatomic,strong)NSIndexPath * indexPath;
@property(nonatomic,assign)NSInteger receiveCount;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,assign)BOOL isVisable;
- (void)setContentMsg:(MessageItem *)msgItem;
- (void)setHeadImg:(NSString *)imgUrlStr;
@end
