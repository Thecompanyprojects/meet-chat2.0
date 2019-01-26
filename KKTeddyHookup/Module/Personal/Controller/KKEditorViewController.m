//
//  XTEditorViewController.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKEditorViewController.h"
#import "KKEditorheaderView.h"
#import "KKEditorCell0.h"
#import "KKEditorCell1.h"
#import "KKPersonalCell2.h"
#import "KKEditorCell2.h"
#import "KKEditoralertView.h"
#import "KKConstellationJudge.h"
#import "CGXPickerView.h"
#import "CGXPickerViewManager.h"
#import "TZImagePickerController.h"

@interface KKEditorViewController ()<UITableViewDataSource,UITableViewDelegate,TZImagePickerControllerDelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) KKEditorheaderView *headerView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger chooseNumber;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,copy) NSString *single;
@end

static NSString *editoridentfity0 = @"editoridentfity0";
static NSString *editoridentfity1 = @"editoridentfity1";
static NSString *editoridentfity2 = @"editoridentfity2";
static NSString *editoridentfity3 = @"editoridentfity3";

@implementation KKEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Profile";
    
    if (self.personModel.single.length!=0) {
        self.single = self.personModel.single;
    }
    else
    {
        self.single = @"1";
    }
    self.chooseNumber = 6;
    self.dataSource = [NSMutableArray array];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"000000"];
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
    self.table.tableHeaderView = self.headerView;
    [self.headerView setheader:self.personModel];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ((self.returnTextBlock!=nil)) {
        self.returnTextBlock([NSString new]);
    }
}

-(void)addSubscribeButton
{
    UIBarButtonItem *subscribeBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"whiteback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(subscribeButtonAction:)];
    self.navigationItem.leftBarButtonItem = subscribeBtn;
}

- (void)subscribeButtonAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
        _table.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight);
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] init];
        _footView.frame = CGRectMake(0, 0, kScreenWidth, 90);
        [_footView addSubview:self.saveBtn];
    }
    return _footView;
}

-(UIButton *)saveBtn
{
    if(!_saveBtn)
    {
        _saveBtn = [[UIButton alloc] init];
        _saveBtn.frame = CGRectMake(20, 30, kScreenWidth-40, 40);
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius = 20;
        [_saveBtn setTitle:@"Save" forState:normal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _saveBtn.backgroundColor = MainColor;
        [_saveBtn addTarget:self action:@selector(savebtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

-(KKEditorheaderView *)headerView
{
    if(!_headerView)
    {
        _headerView = [[KKEditorheaderView alloc] init];
        _headerView.delegate = self;
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
        [_headerView.imgView0.addBtn addTarget:self action:@selector(imgchooseClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.imgView1.addBtn addTarget:self action:@selector(imgchooseClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.imgView2.addBtn addTarget:self action:@selector(imgchooseClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.imgView3.addBtn addTarget:self action:@selector(imgchooseClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.imgView4.addBtn addTarget:self action:@selector(imgchooseClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.imgView5.addBtn addTarget:self action:@selector(imgchooseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 4;
    }
    else
    {
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        KKEditorCell0 *cell = [tableView dequeueReusableCellWithIdentifier:editoridentfity0];
        cell = [[KKEditorCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:editoridentfity0];
        cell.model = self.personModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        KKEditorCell1 *cell = [tableView dequeueReusableCellWithIdentifier:editoridentfity1];
        cell = [[KKEditorCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:editoridentfity1];
        if (self.personModel.signature.length==0) {
            [cell.addImg setHidden:NO];
            cell.contentLab.textColor = [UIColor colorWithHexString:@"D6D6D6"];
            cell.contentLab.text = @"Add your personal signature";
        }
        else
        {
            [cell.addImg setHidden:YES];
            cell.contentLab.text = self.personModel.signature?:@"";
            cell.contentLab.textColor = [UIColor darkGrayColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        KKPersonalCell2 *cell = [tableView dequeueReusableCellWithIdentifier:editoridentfity2];
        cell = [[KKPersonalCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:editoridentfity2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
        return cell;
    }
    if (indexPath.section==3) {
        KKEditorCell2 *cell = [tableView dequeueReusableCellWithIdentifier:editoridentfity3];
        cell = [[KKEditorCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:editoridentfity3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
        switch (indexPath.row) {
            case 0:
                cell.typeImg.image = [UIImage imageNamed:@"address"];
                if (self.personModel.city.length==0) {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                else
                {
                    cell.contentLab.text = self.personModel.city?:@"";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                }
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                break;
            case 1:
                cell.typeImg.image = [UIImage imageNamed:@"barthday"];
                if (self.personModel.birthday.length==0) {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                else
                {
                    cell.contentLab.text = self.personModel.birthday?:@"";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                }
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                break;
            case 2:
                cell.typeImg.image = [UIImage imageNamed:@"feelings"];
                if (self.personModel.single.length!=0) {
                    if ([self.personModel.single isEqualToString:@"1"]) {
                        cell.contentLab.text = @"Single";
                        cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                    }
                    else
                    {
                        cell.contentLab.text = @"Live alone";
                        cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                    }
                }
                else
                {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width+200, 0.f, 0.f);
                break;
            case 3:
                cell.typeImg.image = [UIImage imageNamed:@"constellation"];
                if (self.personModel.horoscope.length==0) {
                    cell.contentLab.text = @"Unfilled";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"E1E1E1"];
                }
                else
                {
                    cell.contentLab.text = self.personModel.horoscope?:@"";
                    cell.contentLab.textColor = [UIColor colorWithHexString:@"333333"];
                }
                break;
            default:
                break;
        }
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 65;
    }
    if (indexPath.section==1) {
        return 94;
    }
    if (indexPath.section==2) {
        return 45;
    }
    if (indexPath.section==3) {
        return 50;
    }
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self logeditManager];
    if (indexPath.section==0) {
        KKEditoralertView *alert = [[KKEditoralertView alloc] init];
        alert.titleLab.text = @"Username";
        alert.editorText.placeholder = @"Add your personal username";
        [alert withrepylClick:^(NSString * _Nonnull string) {
            NSLog(@"reply%@",string);
            if ([[APIResult sharedClient ]isContainsEmoji:string]) {
                [SVProgressHUD showInfoWithStatus:@"No emoji input"];
            }
            else
            {
                if (string.length!=0) {
                    self.personModel.name = string;
                    [self.table reloadData];
                }
            }
        }];
    }
    if (indexPath.section==1) {
        KKEditoralertView *alert = [[KKEditoralertView alloc] init];
        alert.titleLab.text = @"Signature";
        alert.editorText.placeholder = @"Add your personal signature";
        
        [alert withrepylClick:^(NSString * _Nonnull string) {
            NSLog(@"reply%@",string);
            if ([[APIResult sharedClient ]isContainsEmoji:string]) {
                [SVProgressHUD showInfoWithStatus:@"No emoji input"];
            }
            else
            {
                self.personModel.signature = string;
                [self.table reloadData];
            }
        }];
        
    }
    if (indexPath.section==3&&indexPath.row==0) {
        KKEditoralertView *alert = [[KKEditoralertView alloc] init];
        if (indexPath.row==0) {
            alert.titleLab.text = @"City";
            alert.editorText.placeholder = @"Add your city";
            [alert withrepylClick:^(NSString * _Nonnull string) {
                NSLog(@"reply%@",string);
                if ([[APIResult sharedClient ]isContainsEmoji:string]) {
                    [SVProgressHUD showInfoWithStatus:@"No emoji input"];
                }
                else
                {
                    self.personModel.city = string;
                    [self.table reloadData];
                }
               
            }];
        }
        
    }
    if (indexPath.row==2) {
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"Message" message:@"Are you single" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Single" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.single = @"1";
            self.personModel.single = @"1";
            [self.table reloadData];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Live alone" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.single = @"0";
            self.personModel.single = @"0";
            [self.table reloadData];
        }];
        [control addAction:action0];
        [control addAction:action1];
        [control addAction:action2];
        [self presentViewController:control animated:YES completion:nil];
    }
    if (indexPath.section==3&&indexPath.row==1)
     {
        __weak typeof(self) weakSelf = self;
        NSDate *now = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *nowStr = [fmt stringFromDate:now];
         
        CGXPickerViewManager *manager = [[CGXPickerViewManager alloc] init];
        manager.leftBtnBGColor = [UIColor whiteColor];
        manager.rightBtnBGColor = [UIColor whiteColor];
        manager.leftBtnTitleColor = [UIColor colorWithHexString:@"B1B1B1"];
        manager.rightBtnTitleColor = MainColor;
        manager.titleLabelColor = [UIColor colorWithHexString:@"333333"];
        manager.leftBtnborderColor = [UIColor whiteColor];
        manager.rightBtnborderColor = [UIColor whiteColor];
        
        [CGXPickerView showDatePickerWithTitle:@"Birthday" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01" MaxDateStr:nowStr IsAutoSelect:NO Manager:manager ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakSelf.personModel.birthday = selectValue;
            NSArray *array = [selectValue componentsSeparatedByString:@"-"];
            NSLog(@"array:%@",array);
            NSString *month = [array objectAtIndex:1];
            NSString *day = [array lastObject];
            NSString *year = [array firstObject];
            int yeari = [year intValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            NSDate *date = [NSDate date];
            [formatter setDateFormat:@"yyyy"];
            int currentYear=[[formatter stringFromDate:date] intValue];
            int newyear = currentYear-yeari;
            self.personModel.age = [NSString stringWithFormat:@"%d",newyear];
            self.personModel.horoscope =  [KKConstellationJudge calculateConstellationWithMonth:[month integerValue] day:[day integerValue]];
            [weakSelf.table reloadData];
        }];
    }
}

#pragma mark - 选择图片

-(void)imgchooseClick
{
    self.chooseNumber = 6-self.personModel.photos.count;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.chooseNumber delegate:nil];
    imagePickerVc.oKButtonTitleColorNormal = MainColor;
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor whiteColor];
    imagePickerVc.preferredLanguage = @"en";
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowCameraLocation = NO;
    
    [self.dataSource removeAllObjects];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self logeditManager];
        [self uploaddatawithmodelphotos:self.personModel.photos andchooseimg:(NSMutableArray*)photos];
       
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)uploaddatawithmodelphotos:(NSArray *)modelphoto andchooseimg:(NSMutableArray *)imgArray
{
    int photoint = (int)modelphoto.count;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<imgArray.count; i++) {
        int k = photoint+i+1;
        [arr addObject:[NSString stringWithFormat:@"%d",k]];
    }
    
    NSInteger num = [[KKUserModel sharedUserModel].userId integerValue];
    NSNumber * nums = @(num);
    NSDictionary *newdic = @{@"id":nums,@"photoid":arr};
    NSString *defaultApi = [ServerIP stringByAppendingString:UPLoadphoto];
    NSDictionary *para = @{@"data":newdic};
    NSDictionary *dic = [XYNetworkTools handleParameter:para];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                          nil];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[KKUserModel sharedUserModel].token ? [KKUserModel sharedUserModel].token:@""] forHTTPHeaderField:@"Authorization"];
    [XYLoadingHUD show];
    [self logManagerwithpicturetype:@{@"type":@"0"}];
    [manager POST:defaultApi parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [imgArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *image = obj;
            
            NSData *imageData =UIImageJPEGRepresentation(image,0.2);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%ld.jpg", str, (unsigned long)idx];
            [formData appendPartWithFileData:imageData
                                        name:@"photo"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];

        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [XYLoadingHUD dismiss];
        // 需要先转十六进制的data
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [XYNetworkTools stringToHexData:responseString];
        // 解密需要时Base64的字符串
        NSString *base64Str = [data base64EncodedStringWithOptions:0];
        // 使用秘钥进行解密,得到的是结果字符串
        NSString *resultStr = [base64Str xy_blowFishDecodingWithKey:xy_BlowFishKey];
        // 解密完成后转成Data以便之后进行序列化
        NSData *data_dec = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
        if (data_dec) {
            NSError* serializeError;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data_dec options:0 error:&serializeError];
            NSLog(@"%@",responseDict)
            if (!serializeError) {
                NSLog(@"序列化成功");
                if ([[responseDict objectForKey:@"code"] intValue]==1) {
                    [[APIResult sharedClient] getUserInfo];
                    if ((self.returnTextBlock!=nil)) {
                        self.returnTextBlock([NSString new]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                NSLog(@"序列化失败");
            }
        }else{
            NSError* error_dec = [NSError errorWithDomain:NSCocoaErrorDomain code:-999 userInfo:@{@"reason":@"Decrypt Failed"}];
            NSLog(@"ERROR-----%@",error_dec);
            NSLog(@"解密失败")
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"Please Chech Your Network"];
        [XYLoadingHUD dismiss];
    }];
}

#pragma mark - myTabVdelegate

-(void)myTabVClick:(NSString *)typeStr
{
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"Message" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        int typeint = [typeStr intValue]+1;
        NSMutableArray *arr = [NSMutableArray new];
        [arr addObject:@(typeint)];
        [self logchangeManager];
        [self logManagerwithpicturetype:@{@"type":@"2"}];
        NSInteger num = [[KKUserModel sharedUserModel].userId integerValue];
        NSNumber * nums = @(num);
        NSDictionary *newdic = @{@"id":nums,@"photoid":arr};
        [[AFNetAPIClient sharedClient] requestUrl:Deletephoto cParameters:newdic success:^(NSDictionary * _Nonnull requset) {
            if ([[requset objectForKey:@"code"] intValue]==1) {
                [SVProgressHUD showInfoWithStatus:@"Delege success！"];

                if ((self.returnTextBlock!=nil)) {
                    self.returnTextBlock([NSString new]);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Replace" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowCameraLocation = NO;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.oKButtonTitleColorNormal = MainColor;
        imagePickerVc.barItemTextColor = [UIColor blackColor];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            if (photos.count!=0) {
               [self logchangeManager];
               [self replyImgfrom:[photos firstObject] andwithtypestr:typeStr];
            }
           
        }];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }];
    [control addAction:action0];
    [control addAction:action1];
    [control addAction:action2];
    [self presentViewController:control animated:YES completion:^{
        
    }];
}

-(void)replyImgfrom:(UIImage *)img andwithtypestr:(NSString *)type
{
    NSInteger num = [[KKUserModel sharedUserModel].userId integerValue];
    NSNumber * nums = @(num);
    int typeint = [type intValue];
    [XYLoadingHUD show];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@(typeint+1)];
    NSDictionary *newdic = @{@"id":nums,@"photoid":arr};
    NSString *defaultApi = [ServerIP stringByAppendingString:UPLoadphoto];
    NSDictionary *para = @{@"data":newdic};
    NSDictionary *dic = [XYNetworkTools handleParameter:para];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[KKUserModel sharedUserModel].token ? [KKUserModel sharedUserModel].token:@""] forHTTPHeaderField:@"Authorization"];
     [self logManagerwithpicturetype:@{@"type":@"1"}];
    [manager POST:defaultApi parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            UIImage *image = img;
            NSData *imageData =UIImageJPEGRepresentation(image,0.2);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData
                                        name:@"photo"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
            
      
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [XYLoadingHUD dismiss];
        // 需要先转十六进制的data
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [XYNetworkTools stringToHexData:responseString];
        // 解密需要时Base64的字符串
        NSString *base64Str = [data base64EncodedStringWithOptions:0];
        // 使用秘钥进行解密,得到的是结果字符串
        NSString *resultStr = [base64Str xy_blowFishDecodingWithKey:xy_BlowFishKey];
        // 解密完成后转成Data以便之后进行序列化
        NSData *data_dec = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
        if (data_dec) {
            NSError* serializeError;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data_dec options:0 error:&serializeError];
            NSLog(@"%@",responseDict)
            if (!serializeError) {
                NSLog(@"序列化成功");
                if ([[responseDict objectForKey:@"code"] intValue]==1) {
                    
                  
                    [[APIResult sharedClient] getUserInfo];
                    if ((self.returnTextBlock!=nil)) {
                        self.returnTextBlock([NSString new]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                NSLog(@"序列化失败");
            }
        }else{
            NSError* error_dec = [NSError errorWithDomain:NSCocoaErrorDomain code:-999 userInfo:@{@"reason":@"Decrypt Failed"}];
            NSLog(@"ERROR-----%@",error_dec);
            NSLog(@"解密失败")
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [XYLoadingHUD dismiss];
    }];
}

#pragma mark - 提交信息

-(void)savebtnClick
{
//    "id": 12, # id
//    "name": "xxx", # 姓名
//    "birthday": "2000-01-01", # 生日
//    "signature": "xxx", # 签名
//    "city": "beijing", # 城市
//    "single": 1 # 是否单身,1:单身,0:非单身

    [self logsaveManager];
    
    NSDictionary *dic = [NSDictionary new];
    if (self.personModel.birthday.length==0) {
        dic = @{@"name":self.personModel.name?:@"",@"id":[KKUserModel sharedUserModel].userId?:@"",@"signature":self.personModel.signature?:@"",@"city":self.personModel.city?:@"",@"single":self.single?:@([self.single intValue])};
    }
    else
    {
        dic = @{@"name":self.personModel.name?:@"",@"id":[KKUserModel sharedUserModel].userId?:@"",@"birthday":self.personModel.birthday?:@"",@"signature":self.personModel.signature?:@"",@"city":self.personModel.city?:@"",@"single":self.single?:@([self.single intValue])};
    }

    [[AFNetAPIClient sharedClient] requestUrl:INPutedituserinfo cParameters:dic success:^(NSDictionary * _Nonnull requset) {
        if ([[requset objectForKey:@"code"] intValue]==1) {
            [SVProgressHUD showInfoWithStatus:@"Success"];

            [[APIResult sharedClient] getUserInfo];
            if ((self.returnTextBlock!=nil)) {
                self.returnTextBlock([NSString new]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 打点上报

-(void)logManagerwithpicturetype:(NSDictionary *)keyDic
{
    [[XYLogManager shareManager] addLogKey1:@"profile" key2:@"picture" content:keyDic userInfo:[NSDictionary new] upload:YES];
    
}

-(void)logsaveManager
{
     [[XYLogManager shareManager] addLogKey1:@"profile" key2:@"save" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
}

-(void)logeditManager
{
    [[XYLogManager shareManager] addLogKey1:@"profile" key2:@"edit" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
}

-(void)logchangeManager
{
    [[XYLogManager shareManager] addLogKey1:@"profile" key2:@"picture" content:[NSDictionary new] userInfo:[NSDictionary new] upload:YES];
}


- (void)returnText:(ReturnTextBlock)block
{
     self.returnTextBlock = block;
}

@end
