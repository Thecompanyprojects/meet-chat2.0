//
//  XTMessageDetailController.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKMessageDetailController.h"
#import "KKReciveMsgCell.h"
#import "KKSendMsgCell.h"
#import "MessageItem.h"
#import "KKMessageTimeCell.h"
#import "SqliteManager.h"
#import "KKChatSendManager.h"
#import <MJRefresh.h>
#import "KKMessageImageCell.h"
#import "YBImageBrowser.h"
#import "SVProgressHUD.h"
#import "YYWebImage.h"
#import "KKChatDownload.h"
#import "KKDiscoverModel.h"
#import "KKRobitinfoViewController.h"
#import "KKChatManager.h"

static NSString *const kCellID0 = @"ReciveCell";
static NSString *const kCellID1 = @"SendCell";

@interface KKMessageDetailController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate,CellPassDelegate>
@property (weak, nonatomic) IBOutlet UIView *kInputView;
@property (weak, nonatomic) IBOutlet UITextView *kTextView;
@property (weak, nonatomic) IBOutlet UITableView *kTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kInputViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kInputViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kTextViewBottom;
@property (nonatomic, strong) NSMutableArray *msgMuArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,weak)IBOutlet UIButton * chatAddBtn;
@property (nonatomic,assign)NSInteger receiveCount;
@property (nonatomic,assign)long long lastTime;
@property (nonatomic,assign)NSInteger showMessageCount;
@property (nonatomic,strong)UIView * toolBar;
@property (nonatomic,assign)BOOL isToolBarShow;
@property(nonatomic,strong) NSURLSessionDownloadTask *task;
@property(nonatomic,strong)KKDiscoverModel * boltModel;
@property(nonatomic,assign)long long  messageDate;
@property(nonatomic,strong)NSMutableDictionary *  messageDict;
@end

@implementation KKMessageDetailController

#define pageSize  30
#define ToolBarHeight 150.0
#define TIMECELLHEIGHT 31.0
#define TimeInterval  300000   //时间间隔5分钟

- (NSMutableArray *)msgMuArray {
    if (_msgMuArray == nil) {
        _msgMuArray = [NSMutableArray array];
    }
    return _msgMuArray;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    if (_closeBlock) {
        self.closeBlock();
    }
    [SVProgressHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}
/*
 数据库更新
 */
-(void)sqliteUpdateItems{
    
     NSString * sessionId = [NSString stringWithFormat:@"%@_%@",[KKUserModel sharedUserModel].userId,self.msgItem.userId];
    [[SqliteManager sharedInstance] updateTableDField:@[@"sendError"] WithType:DBChatType_Private sessionID:sessionId];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.dataArray = [NSMutableArray array];
    self.kTextView.enablesReturnKeyAutomatically = YES;
    
    self.navigationItem.title = self.msgItem.userName;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.kTextView.layer.cornerRadius = 5;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.kTextView.typingAttributes = attributes;
    self.kTextView.delegate = self;
    
    self.kTableView.estimatedRowHeight = 10;
    [self.kTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKReciveMsgCell class]) bundle:nil] forCellReuseIdentifier:kCellID0];
    [self.kTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKSendMsgCell class]) bundle:nil] forCellReuseIdentifier:kCellID1];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
//    [self.kTableView addGestureRecognizer:tap];
    
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    self.kTableView.tableHeaderView = headView;
    
    
    self.kTableView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
  

    [[KKChatManager sharedChatManager] cornerMarkZero:self.msgItem.userId];

    [self loadDataSource];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveData:) name:@"MessageDetail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource) name:kPaymentSuccessNotificationName object:nil];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"#000000"];
    self.navigationController.navigationBar.translucent = NO;
    
    NSString * key = [NSString stringWithFormat:@"%@_recievecount",self.msgItem.userId];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        NSInteger count = [[[NSUserDefaults standardUserDefaults] objectForKey:key] integerValue];
        self.receiveCount = count;
    }else{
        self.receiveCount = 0;
    }
    
    self.toolBar.xy_y = kScreenHeight;
    self.kTextView.layer.cornerRadius = 5.0f;
    self.kTextView.clipsToBounds = YES;
    self.kTextView.layer.borderColor = MainColor.CGColor;
    self.kTextView.layer.borderWidth = 1;
    
    self.messageDict = [NSMutableDictionary dictionary];
    [self getUserInfo];
}

-(void)getUserInfo{
    [WJGAFCheckNetManager shareTools].type = checkNetTypeWithmassage;
    [[WJGAFCheckNetManager shareTools] checkNetWithBlock];
    __weak __typeof(&*self)weakSelf =self;
    [[AFNetAPIClient sharedClient] requestUrl:getbotinfo cParameters:@{@"botid":@([self.msgItem.userId integerValue])} success:^(NSDictionary * response) {
        NSLog(@"response----%@",response);
        if ([[response objectForKey:@"code"] intValue]==1) {
            weakSelf.boltModel = [[KKDiscoverModel alloc] init];
            NSDictionary * data = [response objectForKey:@"data"];
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSDictionary * botinfo = [data objectForKey:@"botinfo"];
                weakSelf.boltModel.Newid = [botinfo safeObj:@"id"];
                weakSelf.boltModel.name = [botinfo safeObj:@"name"];
                weakSelf.boltModel.age = [botinfo safeObj:@"age"];
                weakSelf.boltModel.signature = [botinfo safeObj:@"signature"];
                weakSelf.boltModel.horoscope = [botinfo safeObj:@"horoscope"];
                weakSelf.boltModel.single = [botinfo safeObj:@"single"];
                weakSelf.boltModel.city = [botinfo safeObj:@"city"];
                weakSelf.boltModel.issayHi = YES;
                weakSelf.boltModel.photo = [botinfo objectForKey:@"photo"];
                weakSelf.boltModel.video = [botinfo objectForKey:@"video"];
                weakSelf.boltModel.videopreview = [botinfo objectForKey:@"videopreview"];
                weakSelf.boltModel.photopreview = [botinfo objectForKey:@"photopreview"];

            }
        } else
        {
            [[XYLogManager shareManager] addLogKey1:@"data" key2:@"error" content:@{@"type":@(7)} userInfo:[NSDictionary new] upload:NO];
        }
    } failure:^(NSError * error) {
        NSLog(@"error----%@",error);
         [[XYLogManager shareManager] addLogKey1:@"data" key2:@"overtime" content:@{@"type":@(7)} userInfo:[NSDictionary new] upload:NO];
    }];
}
-(void)loadDataSource{
    
    [self.msgMuArray removeAllObjects];
    [self.dataArray removeAllObjects];
    __weak __typeof(&*self)weakSelf =self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * sessionId = [NSString stringWithFormat:@"%@_%@",[KKUserModel sharedUserModel].userId,weakSelf.msgItem.userId];
        [[SqliteManager sharedInstance] queryChatLogTableWithType:DBChatType_Private sessionID:sessionId userInfo:nil fuzzyUserInfo:nil complete:^(BOOL success, id obj) {
            for (MessageItem * item in obj) {
                if (item.createDate - weakSelf.lastTime > TimeInterval) {
                    NSString * time = [NSString stringWithFormat:@"%@    ",[self getChateDate:item.createDate]];
                    [weakSelf.msgMuArray addObject:time];
                    weakSelf.lastTime = item.createDate;
                }
                [weakSelf.msgMuArray addObject:item];
            }
            if (weakSelf.msgMuArray.count >= pageSize) {
                NSMutableIndexSet  *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, pageSize)];
                [weakSelf.dataArray insertObjects:[weakSelf.msgMuArray subarrayWithRange:NSMakeRange(weakSelf.msgMuArray.count - pageSize, pageSize)] atIndexes:indexes];
                weakSelf.showMessageCount += pageSize;
            }else{
                weakSelf.dataArray = weakSelf.msgMuArray;
            }
            //加入头
            [weakSelf setHeaderRefresh];
        }];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.msgMuArray.count > 0) {
                [weakSelf.kTableView reloadData];
                NSIndexPath *path = [NSIndexPath indexPathForRow:weakSelf.dataArray.count - 1 inSection:0];
                [weakSelf.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
        });
        
    });
}
//机器人聊天
-(void)requestChat:(NSString *)content withType:(NSInteger)msgType messageItem:(MessageItem *)item indexpath:(NSIndexPath *)indexpath{
    
    [[AFNetAPIClient sharedClient] requestUrl:socialchat cParameters:@{@"botid":@([self.msgItem.userId integerValue]),
                                                                       @"lang":@"en",
                                                                       @"contenttype":@(msgType),
                                                                       @"content":content}
                                      success:^(NSDictionary * response) {
                                          NSLog(@"response----%@",response);
                                          if ([[response objectForKey:@"code"] isEqual:@1]) {
                                              NSDictionary * data = [response
                                                                      objectForKey:@"data"];
                                              if ([data isKindOfClass:[NSDictionary class]]) {
                                                  if ([[data objectForKey:@"replyflag"] isEqual:@1]) {
                                                      NSInteger replytime = [[data objectForKey:@"replytime"] integerValue];
                                                      MessageItem * msgItem = [MessageItem new];
                                                      msgItem.userId = self.msgItem.userId;
                                                      msgItem.photo = self.msgItem.photo;
                                                      msgItem.chatId = [NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970 * 1000 ];
                                                      
                                                      NSInteger type = [[data objectForKey:@"contenttype"] integerValue];
                                                      msgItem.msgType = type - 1;
                                                      if (type == 1) {
                                                          msgItem.message = [[[data objectForKey:@"content"] safeObj:@"msg"]filtrationSpecailCharactor];
                                                      }else if (type == 2){
                                                          msgItem.message = [[data objectForKey:@"content"] safeObj:@"photo"];
                                                      }else if (type == 3){
                                                          msgItem.message = [NSString stringWithFormat:@"%@||%@",[[data objectForKey:@"content"] safeObj:@"videopreview"],[[data objectForKey:@"content"] safeObj:@"video"]];
                                                      }
                                                      msgItem.userName = self.msgItem.userName;
                                                      msgItem.sendUserId = self.msgItem.userId;
                                                      msgItem.createDate = [NSDate date].timeIntervalSince1970 * 1000 + replytime * 1000 ;
                                                      if ([[data objectForKey:@"replyflag"] boolValue]) {
                                                          [self updateChatDetail:msgItem withAfterSecond:replytime];
                                                      }
                                                      
                                                      if (msgType == 3) {
                                                          NSString * key = [NSString md5:item.message];
                                                          [[KKChatDownload sharedChatManager].downloadModelsDic setObject:@1 forKey:key];
                                                      }
                                                      
                                                      item.sendError = 0;
                                                      [self updateSendError:item indexpath:indexpath];
                                                      
                                                  }else{
                                                    item.sendError = 1;
                                                    [self updateSendError:item indexpath:indexpath];
                                                  }
                                              }else{
                                                  item.sendError = 1;
                                                  [self updateSendError:item indexpath:indexpath];
                                              }
                                          }
    } failure:^(NSError * error) {
        item.sendError = 1;
        [self updateSendError:item indexpath:indexpath];
    }];
}
-(void)updateSendError:(MessageItem *)item indexpath:(NSIndexPath *)indexpath{
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    if (indexpath) {
        path = indexpath;
    }
    [self updateChatDetail:item];
    [self.kTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
}
//更新消息列表
-(void)updateChatList:(MessageItem *)msgItem{
    NSString * sessionId = [NSString stringWithFormat:@"%@_list",[NSString stringWithFormat:@"%@",[KKUserModel sharedUserModel].userId]];
    self.msgItem.message = msgItem.message;
    self.msgItem.createDate = msgItem.createDate;
    self.msgItem.chatId =  self.msgItem.userId;
    [[SqliteManager sharedInstance] updateOneChatLogWithType:DBChatType_Private sessionID:sessionId aChatLog:self.msgItem updateItems:nil complete:^(BOOL success, id obj) {
        NSLog(@"su---%d",success);
        NSLog(@"obj---%@",obj);
    }];
}
//是否需要订阅
-(BOOL)isSubscribe{
    return self.receiveCount > [[KKShowsubscribeModel sharedShowsubModel].chat_robot_reply integerValue] && ![KKUserModel sharedUserModel].isVip;
}
//弹订阅
-(void)addSubscribe{
    if ([self isSubscribe]) {
        [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(5)} userInfo:nil upload:YES];
        [self showPaymentViewController];
    }
}

-(void)updateChatDetail:(MessageItem *)msgItem{
    
    NSString * sessionId = [NSString stringWithFormat:@"%@_%@",[KKUserModel sharedUserModel].userId,self.msgItem.userId];
    [[SqliteManager sharedInstance] updateOneChatLogWithType:DBChatType_Private sessionID:sessionId aChatLog:msgItem updateItems:nil complete:^(BOOL success, id obj) {
        NSLog(@"su---%d",success);
        NSLog(@"obj---%@",obj);
        self.msgItem.sendUserId = msgItem.sendUserId;
        self.msgItem.msgType = msgItem.msgType;
        [self updateChatList:msgItem];
    }];
    
    if (msgItem.createDate - self.lastTime > TimeInterval) {
        NSString * time = [NSString stringWithFormat:@"%@    ",[self getChateDate:msgItem.createDate]];
        [self.dataArray addObject:time];
        self.lastTime = msgItem.createDate;
        [self.kTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

//更新消息详情
-(void)updateChatDetail:(MessageItem *)msgItem withAfterSecond:(NSInteger)sencond{

    if ([msgItem.userId isEqual:self.msgItem.userId]) {
        self.msgItem.message = msgItem.message;
        self.msgItem.msgType = msgItem.msgType;
        self.msgItem.createDate = [NSDate date].timeIntervalSince1970 * 1000  + sencond * 1000 ;
        [((AppDelegate *)[UIApplication sharedApplication].delegate) registerNotification:sencond withMessageItem:self.msgItem];
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sencond * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self updateChatDetail:msgItem];
        [self.dataArray addObject:msgItem];
        [self.kTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
            [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
        });
        
    });
}
-(NSString *)getChateDate:(long long)timeStamp{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    NSString *createDate = [NSDate transformMillisecondToTime:timeStamp/1000 format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *todayStr = [NSDate stringFromDate:[NSDate date] format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *str0 = [[createDate substringToIndex:10] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *str1 = [[todayStr substringToIndex:10] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([str1 integerValue] - [str0 integerValue] < 0) {
        return @"";
    } else if ([str1 integerValue] - [str0 integerValue] == 0) {
        return [createDate substringWithRange:NSMakeRange(11, 5)];
    } else if([str1 integerValue] - [str0 integerValue] <= 7){
        return  [date dayFromWeekday];
    }else{
        return  [createDate substringToIndex:16];
    }
}
-(void)recieveData:(NSNotification *)user{
    
    MessageItem * item = [user.userInfo objectForKey:@"data"];
    if ([item.userId isEqual:self.msgItem.userId]) { //
        self.receiveCount ++;

        if (item.createDate - self.lastTime > TimeInterval) {
            NSString * time = [NSString stringWithFormat:@"%@    ",[self getChateDate:item.createDate]];
            [self.dataArray addObject:time];
            self.lastTime = item.createDate;
            [self.kTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        [self.dataArray addObject:item];
        [self.kTableView reloadData];
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count - 1  inSection:0];
        [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    self.msgItem.sendUserId = self.msgItem.userId; //接受消息
    [[KKChatManager sharedChatManager] cornerMarkZero:self.msgItem.userId];
}
- (void)setHeaderRefresh {
    
    if (pageSize >= self.msgMuArray.count) {
        return;
    }
    __weak __typeof(&*self)weakSelf =self;
    weakSelf.kTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [weakSelf.kTableView.mj_header endRefreshing];
                if (weakSelf.msgMuArray.count > weakSelf.showMessageCount) {
                    NSArray * smallArray = nil;
                    if (weakSelf.msgMuArray.count - weakSelf.showMessageCount > pageSize) {
                        smallArray = [weakSelf.msgMuArray subarrayWithRange:NSMakeRange(weakSelf.msgMuArray.count - weakSelf.showMessageCount - pageSize, pageSize)];
                        NSMutableIndexSet  *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, pageSize)];
                        [weakSelf.dataArray insertObjects:smallArray atIndexes:indexes];
                        weakSelf.showMessageCount += pageSize;
                    }else{
                       smallArray = [weakSelf.msgMuArray subarrayWithRange:NSMakeRange(0, weakSelf.msgMuArray.count - weakSelf.showMessageCount)];
                        NSMutableIndexSet  *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, weakSelf.msgMuArray.count - weakSelf.showMessageCount)];
                        [weakSelf.dataArray insertObjects:smallArray atIndexes:indexes];
                        weakSelf.showMessageCount = weakSelf.msgMuArray.count;
                        
                        weakSelf.kTableView.mj_header = nil;
                    }
                dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.kTableView reloadData];
                        NSIndexPath *path = [NSIndexPath indexPathForRow:smallArray.count - 1  inSection:0];
                        [weakSelf.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.kTableView reloadData];
                    NSIndexPath *path = [NSIndexPath indexPathForRow:weakSelf.dataArray.count - 1  inSection:0];
                    [weakSelf.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
                    [weakSelf.kTableView.mj_header endRefreshing];
                    weakSelf.kTableView.mj_header = nil;
                });
                
            }
        });
    }];
}

- (void)hideKeyBoard {
    [self.kTextView resignFirstResponder];
}

- (void)sendMessage:(NSString *)text autoAnswer:(BOOL)autoAnswer{
    
    MessageItem * msgItem = [MessageItem new];
    msgItem.userId = [KKUserModel sharedUserModel].userId;
    msgItem.photo = [KKUserModel sharedUserModel].userphotos.firstObject;
    msgItem.chatId = [NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970 * 1000];
    msgItem.message = text;
    msgItem.createDate = [NSDate date].timeIntervalSince1970 * 1000;
    msgItem.userName = [KKUserModel sharedUserModel].name;
    msgItem.sendUserId = [KKUserModel sharedUserModel].userId;
    [self updateChatDetail:msgItem withAfterSecond:0];
    
    if (self.messageDate > 0) {
        if ([NSDate date].timeIntervalSince1970 * 1000 - self.messageDate < 5000) {
            [self.messageDict setObject:@(1) forKey:[NSString stringWithFormat:@"%lld",self.messageDate]];
        }
    }
    self.messageDate = [NSDate date].timeIntervalSince1970 * 1000;
    
    if (autoAnswer) {
        [self sendeMessage:self.messageDate withText:text messageItem:msgItem];
       
    }
    self.kTextView.text = @"";
    [self textViewDidChange:self.kTextView];
}
-(void)sendeMessage:(long long)date withText:(NSString *)text messageItem:(MessageItem *)item{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![self.messageDict objectForKey:[NSString stringWithFormat:@"%lld",date]]) {
            [self requestChat:text withType:1 messageItem:item indexpath:nil];
        }
    });
}
- (IBAction)clickVoiceBtn:(UIButton *)sender {
    
}

- (IBAction)clickEmotionBtn:(id)sender {
    
}

- (IBAction)clickAddBtn:(id)sender {
    
    if (self.toolBar.xy_y == kScreenHeight) {
        self.toolBar.xy_y = kScreenHeight;
        self.isToolBarShow = YES;
        [self.kTextView resignFirstResponder];
        self.isToolBarShow = NO;
        self.kInputViewBottom.constant = ToolBarHeight;
        [UIView animateWithDuration:0.25 animations:^{
            self.toolBar.xy_y = kScreenHeight - ToolBarHeight - kNavBarHeight - kBottomHeight;
            [self.view layoutIfNeeded];
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
            [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
        });
    }
    
}
-(UIView *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - ToolBarHeight - kNavBarHeight - kBottomHeight, kScreenWidth, ToolBarHeight)];
        
        CGFloat margin = (kScreenWidth - 60 * 2)/3.0;
        NSArray * images = @[@"image_select",@"video_select"];
        for (int i = 0; i < 2; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(margin + (60 + margin) * i, 30, 60, 60);
            btn.tag = 300 + i;
            [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(barClick:) forControlEvents:UIControlEventTouchUpInside];
            [_toolBar addSubview:btn];
        }
        _toolBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.toolBar];
        
    }
    return _toolBar;
}
//读取图片
-(UIImage *)getDocumentImagePath:(NSString *)path{
    NSString *aPath3=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),path];
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    return imgFromUrl3;
}
//保存图片
-(NSString *)saveImageDocuments:(UIImage *)image{
    NSString * uuid =[[NSUUID UUID] UUIDString];
    UIImage *imagesave = image;
    NSString *path_sandox = NSHomeDirectory();
    NSString * address = [NSString stringWithFormat:@"/Documents/%@.png",uuid];
    NSString *imagePath = [path_sandox stringByAppendingString:address];
    BOOL isScucess = [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
    if (isScucess) {
        return address;
    }else{
        return nil;
    }
}

-(void)barClick:(UIButton *)sender{
    
    if (![self isReceive]) {
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"Message" message:@"The user is not replying now and cannot send the message again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:action0];
        [self presentViewController:control animated:YES completion:nil];
        return;
    }
    
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.oKButtonTitleColorNormal = [UIColor colorWithHexString:@"BB52FE"];
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor whiteColor];
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.preferredLanguage = @"en";
    if (sender.tag == 300) {
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowTakePicture = YES;
    }else{
        imagePickerVc.allowPickingImage = NO;
        imagePickerVc.allowTakeVideo = NO;
    }
    imagePickerVc.allowCameraLocation = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count!=0) {
            //                [sender setImage:photos[0] forState:UIControlStateNormal];
            NSString * path = [self saveImageDocuments:photos[0]];
            if (path) {
                MessageItem * msgItem = [MessageItem new];
                msgItem.msgType = 1;
                msgItem.userId = [KKUserModel sharedUserModel].userId;
                msgItem.photo = [KKUserModel sharedUserModel].userphotos.firstObject;
                msgItem.chatId = [NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970 * 1000];
                msgItem.message = path;
                msgItem.createDate = [NSDate date].timeIntervalSince1970 * 1000;
                msgItem.userName = [KKUserModel sharedUserModel].name;
                msgItem.sendUserId = [KKUserModel sharedUserModel].userId;
                [self updateChatDetail:msgItem withAfterSecond:0];
                [self requestChat:@"" withType:2 messageItem:msgItem indexpath:nil];
            }
        }
    }];
    
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        PHAsset *phAsset = (PHAsset*)asset;
        if (phAsset.mediaType == PHAssetMediaTypeVideo) {
            
            [[TZImageManager manager] getVideoWithAsset:phAsset completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
                
                [[PHImageManager defaultManager] requestAVAssetForVideo:phAsset options:nil
                                                          resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                                                              NSLog(@"info----%@",info);
                                                              NSString * sandboxExtensionTokenKey = info[@"PHImageFileSandboxExtensionTokenKey"];
                                                    NSArray * arr = [sandboxExtensionTokenKey componentsSeparatedByString:@";"];
                                                    NSString * filePath = arr[arr.count - 1];
                                                    NSString * path = [NSString stringWithFormat:@"Documents/%@",filePath.lastPathComponent];
                                                    [NSString copyItemAtPath:filePath toPath:[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),path] overwrite:YES error:nil];
                                                    MessageItem * msgItem = [MessageItem new];
                                                    msgItem.msgType = 2;
                                                    msgItem.userId = [KKUserModel sharedUserModel].userId;
                                                    msgItem.photo = [KKUserModel sharedUserModel].userphotos.firstObject;
                                                    msgItem.chatId = [NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970 * 1000];
                                                    msgItem.message = path;
                                                    msgItem.createDate = [NSDate date].timeIntervalSince1970 * 1000;
                                                    msgItem.userName = [KKUserModel sharedUserModel].name;
                                                    msgItem.sendUserId = [KKUserModel sharedUserModel].userId;
                                                    [self updateChatDetail:msgItem withAfterSecond:0];
                                                    [self requestChat:@"" withType:3 messageItem:msgItem indexpath:nil];
                                                   
                                            }];
            }];

        }
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(IBAction)senderMessage:(id)sender{
    
    //对方没有回复不能发送消息
    if (![self isReceive]) {
       
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"Message" message:@"The user is not replying now and cannot send the message again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:action0];
        [self presentViewController:control animated:YES completion:nil];
        return;
    }
    
    [self sendMessage:self.kTextView.text autoAnswer:YES];
}

-(BOOL)isReceive{
    BOOL isRecieve = NO;
    for (id  obj in self.msgMuArray) {
        if ([obj isKindOfClass:[MessageItem class]]) {
            MessageItem * item = (MessageItem *)obj;
            if ([item.userId isEqual:self.msgItem.userId]) {
                isRecieve = YES;
            }
        }
    }
    return isRecieve;
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    // 1,取出键盘动画的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2,取得键盘将要移动到的位置的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 3,计算kInputView需要平移的距离
    CGFloat moveY = self.view.frame.size.height + TOPBAR_HEIGHT - keyboardFrame.origin.y ;
    if (keyboardFrame.origin.y == 550 || keyboardFrame.origin.y  == 506) {
        if (!self.isToolBarShow) {
            moveY -= isIPhoneX ? 34:0;
        }
    }
 
    // 4,执行动画
    //xib中的动画必须要这样写，否则无效
    if (!self.isToolBarShow) {
        self.kInputViewBottom.constant = moveY;
        [UIView animateWithDuration:duration animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    [self.view bringSubviewToFront:self.kInputView];
    if (self.dataArray.count > 0) {
        if (moveY == 0) {
//            if (!self.isToolBarShow) {
////                [self.kTableView reloadData];
//            }else{
//                NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
//                [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            }
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
            [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
        } else {
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
            [self.kTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

- (void)dealloc {
    NSLog(@"dealloc----%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MessageDetail" object:nil];
}
-(void)cellPassIndexPath:(NSIndexPath *)indexpath withObject:(id)object{
    if ([object isKindOfClass:[MessageItem class]]) {
        MessageItem * item = (MessageItem *)object;
        [self requestChat:item.message withType:item.msgType+1 messageItem:item indexpath:indexpath];
    }else{
        [[XYLogManager shareManager] addLogKey1:@"personal_details" key2:@"show" content:@{@"type":@(3)} userInfo:[NSDictionary new] upload:YES];
        KKRobitinfoViewController *VC = [KKRobitinfoViewController new];
        VC.type = RobotinfofromShake;
        VC.model = self.boltModel;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
-(void)cellPassIndexPath:(NSIndexPath *)indexpath withObject:(id)object withCell:(id)cell{
    MessageItem * item = self.dataArray[indexpath.row];
    if (item.msgType == 0) {
        if ([cell isKindOfClass:[KKReciveMsgCell class]]) {
            KKReciveMsgCell * rCell = (KKReciveMsgCell *)cell;
            if (!rCell.isVisable) {
                [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(5)} userInfo:nil upload:YES];
                [self showPaymentViewController];
            }
        }
    }else if (item.msgType == 1) {
        // 图片
        YBImageBrowseCellData *data0 = [YBImageBrowseCellData new];
        if ([cell isKindOfClass:[KKReciveMsgCell class]]) {
            if (![KKUserModel sharedUserModel].isVip) {
                [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(5)} userInfo:nil upload:YES];
                [self showPaymentViewController];
                 return;
            }
            data0.url = [NSURL URLWithString:[item.message stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        }else{
            NSString *aPath3=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),item.message];
            data0.thumbImage = [UIImage imageWithContentsOfFile:aPath3];
            data0.url = [NSURL fileURLWithPath:aPath3];
        }
        data0.sourceObject = object;
    
        // 设置数据源数组并展示
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSourceArray = @[data0];
        [browser show];
    }else if (item.msgType == 2){
        // 视频
        YBVideoBrowseCellData *data1 = [YBVideoBrowseCellData new];
        if ([cell isKindOfClass:[KKReciveMsgCell class]]) {
            if (![KKUserModel sharedUserModel].isVip) {
                [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(5)} userInfo:nil upload:YES];
                [self showPaymentViewController];
                return;
            }
            if ([[item.message componentsSeparatedByString:@"||"] count] > 1) {
                NSString * url = [[[item.message componentsSeparatedByString:@"||"] objectAtIndex:1]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
                
                NSString *fileName=[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[NSString md5:url]]];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
                    data1.url = [NSURL fileURLWithPath:fileName];
                }else{
                    [[KKChatDownload sharedChatManager] downloadUrl:url];
                    return;
                }
            }
        }else{
            NSString * path=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),item.message];
            data1.url = [NSURL fileURLWithPath:path];
        }
        data1.sourceObject = object;
        // 设置数据源数组并展示
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSourceArray = @[data1];
        [browser show];
    }
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id item = self.dataArray[indexPath.row];
    if ([item isKindOfClass:[NSString class]]) {
        return TIMECELLHEIGHT;
    }else if([item isKindOfClass:[MessageItem class]]){
        MessageItem * msgItem = (MessageItem *)item;
        if (msgItem.msgType == 1) {
            //用户自己发送
            if ([msgItem.userId integerValue] == [[KKUserModel sharedUserModel].userId integerValue]) {
                UIImage * image = [self getDocumentImagePath:msgItem.message];
                return MMessageImageSizeWidth * image.size.height/image.size.width + 36.0f;
            }else{
                return MMessageImageSizeWidth * 262/220.0 + 36.0f;
            }
            
        } if (msgItem.msgType == 2) {
            return MMessageImageSizeWidth * 9/16 + 36.0f;
        }
        else{
            UIFont * font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
            CGFloat maxWidth = SCREEN_MIN_LENGTH - 8 - 16  - 50 - 36 - 16 - 4;
            if ([msgItem.message isKindOfClass:[NSString class]]) {
                if ([msgItem.message contentHaveOneLinesWithWidth:maxWidth font:font lineSpacing:0]) {
                    return 70.0f;
                }else{
                    CGSize contentSize = [msgItem.message contentSizeWithWidth:maxWidth font:font lineSpacing:0];
                    return contentSize.height + 56.0f;
                }
            }
            
        }
        return UITableViewAutomaticDimension;
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = self.dataArray[indexPath.row];
    if ([item isKindOfClass:[NSString class]]) {
        KKMessageTimeCell *timeCell = (KKMessageTimeCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KKMessageTimeCell class])];
        if (!timeCell) {
            timeCell = [[KKMessageTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([KKMessageTimeCell class])];
        }
        timeCell.timeLable.text = (NSString *)item;
        timeCell.contentView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        return timeCell;
    }else{
        MessageItem *msgItem = (MessageItem *)item;
        if ([msgItem.userId integerValue] == [[KKUserModel sharedUserModel].userId integerValue]) {
            
            KKSendMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID1 forIndexPath:indexPath];
            cell.delegate = self;
            cell.indexPath = indexPath;
            cell.msgItem = msgItem;
            [cell setContentMsg:msgItem];
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
            return cell;
            
        } else {
            KKReciveMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID0 forIndexPath:indexPath];
            cell.delegate = self;
            cell.receiveCount = self.receiveCount;
            cell.indexPath = indexPath;
            cell.dataArray = self.dataArray;
            [cell setHeadImg:self.msgItem.photo];
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
            [cell setContentMsg:msgItem];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyBoard];
    self.kInputViewBottom.constant = 0;
    self.toolBar.xy_y = kScreenHeight;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITextViewDelegate
- (void) textViewDidBeginEditing:(UITextView *)textView {
    self.toolBar.xy_y = kScreenHeight;
}
- (void) textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 5000) { // 限制5000字内
        textView.text = [textView.text substringToIndex:5000];
    }
    static CGFloat maxHeight = 36 + 24 * 2;//初始高度为36，每增加一行，高度增加24
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    NSLog(@"size = %f ,  frame = %f", size.height, frame.size.height);
    if (size.height >= maxHeight) {
        size.height = maxHeight;
        textView.scrollEnabled = YES;   // 允许滚动
    } else {
        textView.scrollEnabled = NO;    // 不允许滚动
    }
    
    CGFloat height = ceil(size.height) + self.kTextViewBottom.constant * 2;
    
    if (self.kInputViewHeight.constant != ceil(size.height) + self.kTextViewBottom.constant * 2) {
        if (height > 55.0) {
            self.kInputViewHeight.constant = ceil(size.height) + self.kTextViewBottom.constant * 2;
        }else{
            self.kInputViewHeight.constant = 55.0f;
        }
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString * textStr = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([text isEqualToString:@"\n"]){
        
        if (![self isReceive]) {
            [self senderMessage:nil];
            return NO;
        }
        
        if (textStr.length > 0) {     // send Text
            [self sendMessage:self.kTextView.text autoAnswer:YES];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot send blank messages" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }
        [self.kTextView setText:@""];
        self.kInputViewHeight.constant = 55;
        return NO;
    }
    return YES;
}

@end
