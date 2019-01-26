//
//  SendMsgCell.m
//  WeChat1
//
//  Created by Topsky on 2018/5/9.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "KKSendMsgCell.h"
#import "MessageItem.h"
#import <UIImageView+WebCache.h>
#import "MyImageView.h"
#import "KKChatDownload.h"

@interface KKSendMsgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UIImageView *contentBgImgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgLeading;
@property (weak, nonatomic) IBOutlet MyImageView * contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView * playIcon;
@property (weak, nonatomic) IBOutlet UIProgressView * progressView;
@property (strong,nonatomic)NSTimer * timer;
@property (strong,nonatomic)NSString * nameKey;
@property (weak, nonatomic)IBOutlet UIActivityIndicatorView * activityView;
@property (weak, nonatomic)IBOutlet UIButton * sendErrorBtn;
@end

@implementation KKSendMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentBgImgV.image = [self getPopImg];
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDidFire:)];
    [self.contentBgImgV addGestureRecognizer:longPressGestureRecognizer];
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    self.effectView.effect = effect;
//    self.effectView.backgroundColor = [UIColor redColor];
    
    
    self.activityView.hidden = YES;
    self.contentImageView.layer.cornerRadius = 5;
    self.contentImageView.clipsToBounds = YES;
    [self.contentImageView addTarget:self action:@selector(btnClick)];
    
    self.progressView.layer.cornerRadius = 2;
    self.progressView.clipsToBounds = YES;
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if([KKUserModel sharedUserModel].userphotos && [KKUserModel sharedUserModel].userphotos.count > 0){
        [self.headImgV sd_setImageWithURL:[NSURL URLWithString:[KKUserModel sharedUserModel].userphotos.firstObject] placeholderImage:[UIImage imageNamed:HEAD_IMG_NAME]];
    }else{
        [self.headImgV setImage:[UIImage imageNamed:HEAD_IMG_NAME]];
    }    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)btnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellPassIndexPath:withObject:withCell:)]) {
        [self.delegate cellPassIndexPath:self.indexPath withObject:self.contentImageView withCell:self];
    }
}
-(IBAction)reSendMessage:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellPassIndexPath:withObject:)]) {
        self.sendErrorBtn.hidden = YES;
        self.activityView.hidden = NO;
        [self.activityView startAnimating];
        [self.delegate cellPassIndexPath:self.indexPath withObject:self.msgItem];
    }
}
- (void)setContentMsg:(MessageItem *)msgItem {
    
    self.msgItem = msgItem;
    if (msgItem.msgType == 0) {
        self.contentLabel.text = msgItem.message;
        CGFloat maxWidth = SCREEN_MIN_LENGTH - 8 - 16  - 50 - 36 - 16 - 4;
        if ([msgItem.message contentHaveOneLinesWithWidth:maxWidth font:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] lineSpacing:0]) {
            CGSize contentSize = [msgItem.message contentSizeWithWidth:maxWidth font:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] lineSpacing:0];
            CGFloat contentWidth = ceil(contentSize.width);
//            if (contentWidth < 30) {
//                contentWidth = 30;
//            }
            self.contentBgLeading.constant = SCREEN_MIN_LENGTH - contentWidth - 8 - 16  - 50 - 36 - 16 - 4 + 30;
        } else {
            self.contentBgLeading.constant = 50;
        }
        self.contentBgImgV.hidden = NO;
        self.playIcon.hidden = YES;
        self.contentImageView.hidden = YES;
        self.progressView.hidden = YES;
    }else if (msgItem.msgType == 1){
        self.contentLabel.text = @"";
        self.contentImageView.hidden = NO;
        UIImage * image = [self getDocumentImagePath:msgItem.message];
        CGFloat marign = kScreenWidth - 8 - 36 - 4 - MMessageImageSizeWidth;
        self.contentBgLeading.constant =  marign;
        self.contentImageView.image = image;
        self.contentBgImgV.hidden = YES;
        self.playIcon.hidden = YES;
        self.progressView.hidden = YES;
    }else if (msgItem.msgType == 2){
        self.contentLabel.text = @"";
        self.contentImageView.hidden = NO;
        NSString * path=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),msgItem.message];
        UIImage * image = [self getVideoPreViewImage:[NSURL fileURLWithPath:path]];
        CGFloat marign = kScreenWidth - 8 - 36 - 4 - MMessageImageSizeWidth;
        self.contentBgLeading.constant =  marign;
        self.contentImageView.image = image;
        self.contentBgImgV.hidden = YES;
        self.playIcon.hidden = NO;
        self.progressView.hidden = YES;
        
        self.nameKey = [NSString md5:msgItem.message];
        if([[KKChatDownload sharedChatManager].downloadModelsDic objectForKey:self.nameKey ]){
        self.progressView.hidden = NO;
        self.timer  =   [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(progressChanged:)
                                           userInfo:nil
                                            repeats:YES];
        }
    }
    
    if (!msgItem.sendError) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
    }
    self.sendErrorBtn.hidden = !msgItem.sendError;
}

-(void)progressChanged:(NSTimer *)timer
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.progressView.progress += 0.05;
    }];
    if (self.progressView.progress >= 1.0) {
        [self.timer invalidate];
        self.progressView.hidden = YES;
        [[KKChatDownload sharedChatManager].downloadModelsDic removeObjectForKey:self.nameKey];
    }
}

- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
    
}
//读取图片
-(UIImage *)getDocumentImagePath:(NSString *)path{
    NSString *aPath3=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),path];
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    return imgFromUrl3;
}
- (UIImage *)getPopImg {
    UIImage *image = [UIImage imageNamed:@"SenderBkg"];
    return [image stretchableImageWithLeftCapWidth:10 topCapHeight:30];
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
