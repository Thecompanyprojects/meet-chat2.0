//
//  ReciveMsgCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "KKReciveMsgCell.h"
#import "MessageItem.h"
#import "MyImageView.h"
#import <UIImageView+WebCache.h>
#import "YYWebImage.h"
#import "KKChatDownload.h"

@interface KKReciveMsgCell ()

@property (weak, nonatomic) IBOutlet MyImageView *headImgV;
@property (weak, nonatomic) IBOutlet UIImageView *contentBgImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgTrailing;
@property (weak, nonatomic) IBOutlet MyImageView * contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView * playIcon;
@property (strong, nonatomic) UIVisualEffectView * effectView;
@property (strong, nonatomic)MessageItem * msgItem;
@property (weak, nonatomic) IBOutlet UIProgressView * progressView;

@end




@implementation KKReciveMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentBgImgV.image = [self getPopImg];
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDidFire:)];
    [self.contentBgImgV addGestureRecognizer:longPressGestureRecognizer];
    
    [self.headImgV addTarget:self action:@selector(inforClick)];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.vipView.bounds byRoundingCorners: UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.vipView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.vipView.layer.mask = maskLayer;
    
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    self.effectView.alpha = 1.0;
    self.effectView.frame = CGRectMake(0, 0, MMessageImageSizeWidth , MMessageImageSizeWidth * 262/220.0 + 5);
    [self.contentImageView addSubview:self.effectView];

     UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
    UITapGestureRecognizer *tapGesturRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
    [self.contentImageView addGestureRecognizer:tapGesturRecognizer1];
    [self.contentBgImgV addGestureRecognizer:tapGesturRecognizer];

    self.contentImageView.layer.cornerRadius = 5;
    self.contentImageView.clipsToBounds = YES;
    [self.contentImageView addTarget:self action:@selector(btnClick)];
    
    
    self.progressView.layer.cornerRadius = 2;
    self.progressView.clipsToBounds = YES;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setContentMsg:(MessageItem *)msgItem {
    self.msgItem = msgItem;
    if (msgItem.msgType == 0) {
        if ([self isVisable]) {
            self.contentLabel.text = msgItem.message;
            self.vipView.hidden = YES;
        }else{
            self.vipView.hidden = NO;
            self.msgItem.message = @"Visable afer subsciption";
            self.contentLabel.text = self.msgItem.message;
        }
        CGFloat maxWidth = SCREEN_MIN_LENGTH - 8 - 16  - 50 - 36 - 16 - 4;
        if ([msgItem.message contentHaveOneLinesWithWidth:maxWidth font:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] lineSpacing:0]) {
            CGSize contentSize = [msgItem.message contentSizeWithWidth:maxWidth font:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] lineSpacing:0];
            CGFloat contentWidth = ceil(contentSize.width);
            if (contentWidth < 30) {
                contentWidth = 30;
            }
            self.contentBgTrailing.constant = SCREEN_MIN_LENGTH - contentWidth - 8 - 16  - 50 - 36 - 16 - 4 + 30;
        } else {
            self.contentBgTrailing.constant = 50;
        }
        self.contentBgImgV.hidden = NO;
        self.playIcon.hidden = YES;
        self.contentImageView.hidden = YES;
        self.progressView.hidden = YES;
        
    }else if (msgItem.msgType == 1){
        self.contentLabel.text = @"";
        self.contentImageView.hidden = NO;
        CGFloat marign = kScreenWidth - 8 - 36 - 4 - MMessageImageSizeWidth;
        self.contentBgTrailing.constant =  marign;
        [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:[msgItem.message stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] options:0];
        self.contentBgImgV.hidden = YES;
        self.playIcon.hidden = YES;
        if (![KKUserModel sharedUserModel].isVip) {
            self.effectView.hidden = NO;
            self.vipView.hidden = NO;
        }else{
            self.effectView.hidden = YES;
            self.vipView.hidden = YES;
        }
        self.progressView.hidden = YES;
    }else if (msgItem.msgType == 2){
        self.contentLabel.text = @"";
        self.contentImageView.hidden = NO;
        CGFloat marign = kScreenWidth - 8 - 36 - 4 - MMessageImageSizeWidth;
        self.contentBgTrailing.constant =  marign;
        /*图片必须编码*/
        NSString * url = [[[msgItem.message componentsSeparatedByString:@"||"] firstObject]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionIgnoreFailedURL];
        self.contentBgImgV.hidden = YES;
        self.playIcon.hidden = NO;
        if (![KKUserModel sharedUserModel].isVip) {
            self.effectView.hidden = NO;
            self.vipView.hidden = NO;
        }else{
            self.effectView.hidden = YES;
            self.vipView.hidden = YES;
        }
        self.progressView.hidden = YES;
        if([[msgItem.message componentsSeparatedByString:@"||"] count] > 1){
            NSString * videoUrl = [[[msgItem.message componentsSeparatedByString:@"||"] objectAtIndex:1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSString * nameKey = [NSString md5:videoUrl];
            [KKChatDownload sharedChatManager].sprogress = ^(NSString * _Nonnull key, CGFloat progress) {
                if ([key isEqual:nameKey]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        self.progressView.progress = progress;
                        self.progressView.hidden = NO;
                        if (progress >= 1.0) {
                            self.progressView.hidden = YES;
                        }
                    }];
                }
            };
        }
        
    }
}
-(void)inforClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellPassIndexPath:withObject:)]) {
        [self.delegate cellPassIndexPath:self.indexPath withObject:self.contentImageView];
    }
}
//是否显示VIP标记
-(BOOL)isVisable{
        
    BOOL isVisable = [KKUserModel sharedUserModel].isVip;
    if (![KKUserModel sharedUserModel].isVip) {
        NSInteger recieveCount = 0;
        for (int i = 0;i<self.dataArray.count;i++) {
            if ([self.dataArray[i] isKindOfClass:[MessageItem class]]) {
                MessageItem * item = self.dataArray[i];
                if ([item.userId isEqual:self.msgItem.userId]) {
                    recieveCount ++;
                }
            }
        }
        NSInteger count = self.receiveCount - recieveCount;
        NSInteger index = 0;
        BOOL isHas = NO;
        for (int i = 0;i<self.dataArray.count;i++) {
            if ([self.dataArray[i] isKindOfClass:[MessageItem class]]) {
                MessageItem * item = self.dataArray[i];
                if ([item.userId isEqual:self.msgItem.userId]) {
                    count ++;
                }
                if (count >= [[KKShowsubscribeModel sharedShowsubModel].chat_robot_reply integerValue]) {
                    index = i;
                    isHas = YES;
                    break;
                }
            }
        }
        
        if (self.receiveCount == recieveCount) {
            if (self.indexPath.row > index && isHas) {
                return NO;
            }else{
                return YES;
            }
        }else{
            if (self.indexPath.row >= index && isHas) {
                return NO;
            }else{
                return YES;
            }
        }

    }
    return isVisable;
}
-(void)btnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellPassIndexPath:withObject:withCell:)]) {
        [self.delegate cellPassIndexPath:self.indexPath withObject:self.contentImageView withCell:self];
    }
}
- (void)setHeadImg:(NSString *)imgUrlStr {
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
}

- (UIImage *)getPopImg {
    UIImage *image = [UIImage imageNamed:@"ReceiverBkg"];
    return [image stretchableImageWithLeftCapWidth:40 topCapHeight:30];
}

//长按cell
- (void)longPressGestureDidFire:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        CGRect rect = self.contentBgImgV.frame;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        // 定义菜单
        UIMenuItem *a = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                   action:@selector(aAction)];
//        UIMenuItem *b = [[UIMenuItem alloc] initWithTitle:@"转发"
//                                                   action:@selector(bAction)];
//        UIMenuItem *c = [[UIMenuItem alloc] initWithTitle:@"删除"
//                                                   action:@selector(cAction)];
//        menu.menuItems = @[a,b,c];
        menu.menuItems = @[a];
        [menu setTargetRect:rect inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(aAction) || action == @selector(bAction) || action == @selector(cAction)) {
        return YES;
    } else {
        return NO;
    }
}

- (void)aAction{
    NSLog(@"--aAction--");
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    pastboard.string = self.contentLabel.text;
}

- (void)bAction{
    NSLog(@"--bAction--");
}

- (void)cAction{
    NSLog(@"--aAction--");
}

@end
