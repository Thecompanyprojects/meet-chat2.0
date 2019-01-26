//
//  MessageCell.m
//  WeChat1
//
//  Created by Topsky on 2018/4/28.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "KKMessageCell.h"
#import <UIImageView+WebCache.h>
#import "MessageItem.h"
#import "NSDate+Extension.h"

@interface KKMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *silentImgV;
@property (weak,nonatomic)IBOutlet UILabel * unreadLabel;

@end

@implementation KKMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.headImgV.layer.cornerRadius = 10;
    self.headImgV.clipsToBounds = YES;
    self.unreadLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
     self.unreadLabel.backgroundColor = [UIColor redColor];
}

- (void)setMessageContent:(MessageItem *)item {
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:item.photo]];
    self.nameLabel.text = item.userName;
    if (item.msgType == 0) {
        self.contentLabel.text = item.message;
    }else if (item.msgType == 1){
        self.contentLabel.text = @"[image]";
    }else if (item.msgType == 2){
        self.contentLabel.text = @"[video]";
    }
   
//    NSString * key = [NSString stringWithFormat:@"%@_recievecount",item.userId];
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
//        NSInteger count = [[[NSUserDefaults standardUserDefaults] objectForKey:key] integerValue];
//        if (count > [[XTShowsubscribeModel sharedShowsubModel].chat_robot_reply integerValue] && ![UserModel sharedUserModel].isVip) {
//            self.contentLabel.text = NSLocalizedString(@"You have a message", nil);
//        }
//    }
    
    if (![KKUserModel sharedUserModel].isVip) {
        if ([item.sendUserId integerValue] != [[KKUserModel sharedUserModel].userId integerValue]) {
            self.contentLabel.text = NSLocalizedString(@"You have a message", nil);
        }
    }
    
    NSDictionary * cornerMarList =  [[NSUserDefaults standardUserDefaults] objectForKey:@"cornerMarList"];
    NSInteger unreadCount = [[cornerMarList safeObj:item.chatId] integerValue];
    if (unreadCount > 0) {
        self.unreadLabel.hidden = NO;
        self.unreadLabel.text = [NSString stringWithFormat:@"%lu",unreadCount];
    }else{
        self.unreadLabel.hidden = YES;
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:item.createDate/1000];
//    self.silentImgV.hidden = !item.isSilent;
    NSString *createDate = [NSDate transformMillisecondToTime:item.createDate/1000  format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *todayStr = [NSDate stringFromDate:[NSDate date] format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *str0 = [[createDate substringToIndex:10] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *str1 = [[todayStr substringToIndex:10] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    
    if ([str1 integerValue] - [str0 integerValue] < 0) {
        self.timeLabel.text = nil;
    } else if ([str1 integerValue] - [str0 integerValue] == 0) {
        self.timeLabel.text = [createDate substringWithRange:NSMakeRange(11, 5)];
    } else if ([str1 integerValue] - [str0 integerValue] == 1) {
        self.timeLabel.text = NSLocalizedString(@"yday", nil);;
    } else if([str1 integerValue] - [str0 integerValue] <= 7){
        self.timeLabel.text = [date dayFromWeekday];
    }else{
        self.timeLabel.text = [createDate substringToIndex:10];
    }
}



- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    
    self.unreadLabel.backgroundColor = [UIColor redColor];
  
    
}


@end
