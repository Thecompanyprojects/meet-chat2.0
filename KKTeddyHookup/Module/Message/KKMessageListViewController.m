//
//  XTMessageListViewController.m
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/10/15.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "KKMessageListViewController.h"
#import "MessageItem.h"
#import "KKMessageCell.h"
#import "KKMessageDetailController.h"
#import "SqliteManager.h"
#import "KKChatSendManager.h"
#import "KKDeleteChooseBar.h"
#import "KKMessageAlertView.h"
#import "KKChatManager.h"

static CGFloat CHooseBarHieght = 50.0;
@interface KKMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIButton *_selectBtn;
}
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *msgMuArray;
@property (nonatomic,strong)NSMutableArray*deleteArray;
@property (nonatomic,strong)KKDeleteChooseBar*chooseBar;
@end

static NSString *const kCellID = @"MessageCellID";

@implementation KKMessageListViewController

-(KKDeleteChooseBar *)chooseBar{
    
    if (!_chooseBar) {
        __weak KKMessageListViewController*weakSelf =self;
       
        _chooseBar = [KKDeleteChooseBar ChooseBArWithchoose:^(NSInteger col,KKDeleteChooseBar* bar) {
            
            if (col == 0) {//全选
               
                if (self.deleteArray.count == self.msgMuArray.count) {
                    for (int i = 0; i < weakSelf.msgMuArray.count; i ++) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                        [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
                    }
                     [weakSelf.deleteArray removeAllObjects];
                    bar.ishasdelete = self.deleteArray.count;
                    bar.ishasSelectedAll = self.deleteArray.count == self.msgMuArray.count;
                    return;
                }
                 [weakSelf.deleteArray removeAllObjects];
                for (int i = 0; i < weakSelf.msgMuArray.count; i ++) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                    MessageItem * item = self.msgMuArray[i];
                    [weakSelf.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                    
                    [weakSelf.deleteArray addObject:item];
                }
                bar.ishasdelete = self.deleteArray.count;
                bar.ishasSelectedAll = self.deleteArray.count == self.msgMuArray.count;
            }else{//删除
                
                if (weakSelf.deleteArray.count == 0) {
                    return;
                }
                
            KKMessageAlertView *alert = [KKMessageAlertView ShowTitle:@"Are you sure to delete?" Sure:^{
                
                    NSString * sessionId = [NSString stringWithFormat:@"%@_list",[NSString stringWithFormat:@"%@",[KKUserModel sharedUserModel].userId]];
                
                    if (self.deleteArray.count == 0) {
                        
                        return;
                        
                    }
                    for (MessageItem * item in weakSelf.deleteArray) {
                        NSString * sessionId1 = [NSString stringWithFormat:@"%@_%@",[KKUserModel sharedUserModel].userId,item.userId];
                        [[KKChatManager sharedChatManager] cornerMarkZero:item.userId];
                        [self deleteChatList:sessionId withItem:item];
                        [self deleteChatDetailData:sessionId1 withItem:item];
                        [self deleteChatDetail:sessionId1];
                        [weakSelf.msgMuArray removeObject:item];
                    }
                
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageTab" object:nil];
                    bar.ishasdelete = self.deleteArray.count;
                
                    if (weakSelf.msgMuArray.count == 0) {
                        [weakSelf Manage:self->_selectBtn];
                    }
                
                    [weakSelf.deleteArray removeAllObjects];
                    [weakSelf loadDataSource];
                    bar.ishasdelete = self.deleteArray.count;
                    bar.ishasSelectedAll = self.deleteArray.count == self.msgMuArray.count;
                
                } Cancel:^{
                   bar.ishasdelete = self.deleteArray.count;
                   bar.ishasSelectedAll = self.deleteArray.count == self.msgMuArray.count;
                }];
                [alert show];
            }
        }];
        _chooseBar.xy_x = 0;
        _chooseBar.hidden = YES;
        [weakSelf.view addSubview:_chooseBar];
    }
    return _chooseBar;
}

-(NSMutableArray *)deleteArray{
    
    if (!_deleteArray) {
        _deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataSource];
    [self logManager];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageTab" object:nil];
}
//加载刷新数据
-(void)loadDataSource{
    
    NSString * listDbName = [NSString stringWithFormat:@"%@_list",[NSString stringWithFormat:@"%@",[KKUserModel sharedUserModel].userId]];
    [[SqliteManager sharedInstance] queryChatLogTableWithType:DBChatType_Private sessionID:listDbName userInfo:nil fuzzyUserInfo:nil complete:^(BOOL success, id obj) {
        NSLog(@"obj---%@",obj);
        self.msgMuArray = obj;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //            self.msgMuArray = [NSMutableArray arrayWithArray:[[HomeViewModel new] loadMessages]];
            
            //按照时间先后顺序排序
            [self.msgMuArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return  ((MessageItem *)obj1).createDate < ((MessageItem *)obj2).createDate;
            }];
            
            //置顶排序
            [self.msgMuArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return  ((MessageItem *)obj1).updateDate < ((MessageItem *)obj2).updateDate;
            }];
            
            //置顶按照实际排序排序
            [self.msgMuArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return  ((MessageItem *)obj1).updateDate &&  ((MessageItem *)obj2).updateDate && ((MessageItem *)obj1).createDate < ((MessageItem *)obj2).createDate;
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    // 允许在编辑模式下进行多选操作
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
   
    
    self.msgMuArray = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKMessageCell class]) bundle:nil] forCellReuseIdentifier:kCellID];
    [self setSearchView];
    [self setRightItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource) name:@"MessageListLoad" object:nil];

    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"dingyue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(subscribe)];
    
    [self notifity];
    [self addSubscribeButton];
}

-(void)notice:(id)sender{
    NSLog(@"%@",sender);
    [self addSubscribeButton];
}
-(void)notifity
{
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:kPaymentSuccessNotificationName object:nil];
}
- (void)addSubscribeButton{
    
    if (![KKUserModel sharedUserModel].isVip) {
        UIBarButtonItem *subscribeBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"dingyue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(subscribe)];
        self.navigationItem.leftBarButtonItem = subscribeBtn;
    }
    else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)subscribe{
    [[XYLogManager shareManager] addLogKey1:@"premium" key2:@"entrance" content:@{@"result":@(5)} userInfo:nil upload:YES];
    [self showPaymentViewController];
}
-(void)setRightItem{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Manage" forState: UIControlStateNormal];
    [btn setTitle:@"Cancel" forState:UIControlStateSelected ];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
    [btn addTarget:self action:@selector(Manage:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    _selectBtn = btn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
- (void)setSearchView {
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KKMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    MessageItem *item = self.msgMuArray[indexPath.row];
    cell.tintColor = [UIColor colorWithHexString:@"#F8438B"];
    cell.selectedBackgroundView = self.tableView.isEditing?[UIView new]:nil;
    [cell setMessageContent:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     MessageItem *item = self.msgMuArray[indexPath.row];
    if (self.tableView.isEditing) {
        [self.deleteArray addObject:item];
        self.chooseBar.ishasdelete = self.deleteArray.count;
        self.chooseBar.ishasSelectedAll = self.deleteArray.count == self.msgMuArray.count;
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KKMessageDetailController * messageDetail = [[KKMessageDetailController alloc]initWithNibName:NSStringFromClass([KKMessageDetailController class]) bundle:nil];
    messageDetail.msgItem = item;
    [self.navigationController pushViewController:messageDetail animated:YES];
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
   
    if (self.tableView.isEditing == YES) {
         MessageItem *item = self.msgMuArray[indexPath.row];
        [self.deleteArray removeObject:item];
        self.chooseBar.ishasdelete = self.deleteArray.count;
        self.chooseBar.ishasSelectedAll = self.deleteArray.count == self.msgMuArray.count;
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.msgMuArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * sessionId = [NSString stringWithFormat:@"%@_list",[NSString stringWithFormat:@"%@",[KKUserModel sharedUserModel].userId]];
    MessageItem * item = self.msgMuArray[indexPath.row];
    NSString * content = [item.message stringByReplacingOccurrencesOfString:@"'" withString:@"\'\'"];
    item.message = content;
    
    NSString * sessionId1 = [NSString stringWithFormat:@"%@_%@",[KKUserModel sharedUserModel].userId,item.userId];
    // 添加一个删除按钮
    UITableViewRowAction * deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString(@"delete", nil) handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [self deleteChatList:sessionId withItem:item];
        [self deleteChatDetailData:sessionId1 withItem:item];
        [self deleteChatDetail:sessionId1];
        
        [self.msgMuArray removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = @[indexPath];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [[KKChatManager sharedChatManager] cornerMarkZero:item.userId];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageTab" object:nil];
        
    }];
    deleteRowAction.backgroundColor = [UIColor colorWithHexString:@"#ff3b32"];
    
    NSString * title = NSLocalizedString(@"stack", nil);
    if (item.updateDate > 0) {
        title  = NSLocalizedString(@"canel stack", nil);
    }
    
    // 置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:title handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        if (item.updateDate > 0) {
            item.updateDate = 0;
        }else{
           item.updateDate = [NSDate date].timeIntervalSince1970 * 1000;
        }
        [[SqliteManager sharedInstance] updateOneChatLogWithType:DBChatType_Private sessionID:sessionId aChatLog:item updateItems:nil complete:^(BOOL success, id obj) {
            NSLog(@"obj---%@",obj);
        }];
        
        [self loadDataSource];
    }];
    topRowAction.backgroundColor = [UIColor colorWithHexString:@"#c7c6cb"];
    
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, topRowAction];
    
}

-(void)deleteChatList:(NSString *)sessionId withItem:(MessageItem *)item{
    [[SqliteManager sharedInstance] deleteOneChatLogWithType:DBChatType_Private sessionID:sessionId msgID:item.userId complete:^(BOOL success, id obj) {
    }];
}
-(void)deleteChatDetail:(NSString *)sessionId{
    [[SqliteManager sharedInstance] deleteChatLogTableWithType:DBChatType_Private sessionID:sessionId complete:^(BOOL success, id obj) {
        NSLog(@"deleteSucess---%d",success);
    }];
}
-(void)deleteChatDetailData:(NSString *)sessionId withItem:(MessageItem *)item{
    [[SqliteManager sharedInstance] queryChatLogTableWithType:DBChatType_Private sessionID:sessionId userInfo:nil fuzzyUserInfo:nil complete:^(BOOL success, id obj) {
        for (MessageItem * item in obj) {
            if ([item.userId integerValue] == [[KKUserModel sharedUserModel].userId integerValue]) {
                NSString * file = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),item.message];
                if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
                    [NSString removeItemAtPath:file error:nil];
                }
                
            }
        }
    }];
}

-(void)Manage:(UIButton*)sender{
    sender.selected = !sender.selected;
     [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    if (self.tableView.isEditing) {
        [self.deleteArray removeAllObjects];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.xy_height = self.tableView.isEditing?kScreenHeight - kTabBarHeight - kNavBarHeight - CHooseBarHieght:kScreenHeight - kTabBarHeight - kNavBarHeight;
        self.chooseBar.xy_y =self.tableView.isEditing?kScreenHeight - kTabBarHeight -kNavBarHeight- CHooseBarHieght :kScreenHeight;
        
    } completion:^(BOOL finished) {
        self.chooseBar.hidden = !self.tableView.isEditing;
        if (!self.tableView.isEditing) {
            [self.chooseBar Clean];
           
        }
        self.chooseBar.ishasdelete = self.deleteArray.count;
        [self.tableView reloadData];
    }];
    
    
    
}

-(void)logManager
{
    [[XYLogManager shareManager] addLogKey1:@"message" key2:@"show" content:@{@"type":@"0"} userInfo:[NSDictionary new] upload:YES];
}

@end
