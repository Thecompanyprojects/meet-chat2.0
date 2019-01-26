//
//  XTDiscoversqlManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/11/13.
//  Copyright © 2018 KK. All rights reserved.
//



#import "KKDiscoversqlManager.h"
#import "KKDiscoverModel.h"

@interface KKDiscoversqlManager()
@property(nonatomic,strong) FMDatabase *db;
@property(nonatomic,strong) NSString * dbPath;
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation KKDiscoversqlManager

+ (instancetype)sharedClient
{
    static KKDiscoversqlManager *_sqlManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sqlManager = [[KKDiscoversqlManager alloc]init];
    });
    return _sqlManager;
}

/**
 建表
 */
-(void)creatTable
{
    //获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"userData.sqlite"];
    self.dbPath = fileName;
    
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:self.dbPath];
    //3.打开数据库
    if ([db open]) {
        //4.创表
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_discoverData (id INTEGER PRIMARY KEY , name TEXT NOT NULL, age TEXT , signature TEXT , horoscope TEXT , city TEXT , single TEXT , photo VARCHAR , photopreview VARCHAR , video VARCHAR , videopreview VARCHAR , issayHi INTEGER);"];
        if (result){
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
    }
    self.db=db;
}

/**
 插入数据
 */
-(void)instrtmymodel
{
    if (![self iscanInsert]) {
        
        return;
    }
    
    BOOL isSuccess=[self.db open];
    if (!isSuccess) {
        NSLog(@"打开数据库失败");
    }
    [self.db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i<self.dataSource.count; i++) {
            KKDiscoverModel *model = [self.dataSource objectAtIndex:i];
            NSString *newId = model.Newid;
            NSInteger idinter = [newId integerValue];
            NSString *name = model.name;
            NSString *age = model.age?:@"0";
            NSString *signature = model.signature?:@"";
            NSString *horoscope = model.horoscope?:@"0";
            NSString *city = model.city?:@"0";
            NSString *single = model.single?:@"0";
            
            NSArray *photoArr = model.photo;
            NSArray *photopreviewArr = model.photopreview;
            NSArray *videoArr = model.video;
            NSArray *videopreviewArr = model.videopreview;
            
            NSString *photo = [photoArr componentsJoinedByString:@","]?:@"0";
            NSString *photopreview = [photopreviewArr componentsJoinedByString:@","]?:@"0";
            NSString *video = [videoArr componentsJoinedByString:@","]?:@"0";
            NSString *videopreview = [videopreviewArr componentsJoinedByString:@","]?:@"0";
            
            int say = 0;
            
            NSString *sql = @"INSERT INTO t_discoverData (id,name,age,signature,horoscope,city,single,photo,photopreview,video,videopreview,issayHi) VALUES (?,?,?,?,?,?,?,?,?,?,?,?);";
            
            BOOL a = [self.db executeUpdate:sql,@(idinter),name,age,signature,horoscope,city,single,photo,photopreview,video,videopreview,@(say)];
            if (!a) {
                NSLog(@"插入失败1");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [self.db rollback];
    }
    @finally {
        if (!isRollBack) {
            [self.db commit];
        }
    }
    NSLog(@"add-------%@",self.dbPath);
    [self.db close];
    
    NSString *day0 = [TimerGet getNowTimer];
    [[NSUserDefaults standardUserDefaults] setObject:day0 forKey:@"Discoverday"];
    
}


/**
 清空数据库内容
 */
-(void)deletefromData
{

    BOOL result = [self.db executeUpdate:@"DELETE FROM t_discoverData"];
    if (result) {
        NSLog(@"delete from 't_student' success");
      
    } else {

    }
    [self.db close];

}


/**
 读取数据

 @return 读取表中数据
 */
-(NSMutableArray *)loaddata
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"userData.sqlite"];
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    if (![dataBase open]) {
        NSLog(@"打开数据库失败");
        return [NSMutableArray new];
    }
    
    FMResultSet *resultSet = [dataBase executeQuery:@"select * from t_discoverData"];
    self.dataArray = [NSMutableArray array];
    while ([resultSet next]) {
        
        KKDiscoverModel *model = [[KKDiscoverModel alloc] init];
        model.Newid = [resultSet stringForColumn:@"id"];
        model.name = [resultSet stringForColumn:@"name"];
        model.age = [resultSet stringForColumn:@"age"];
        model.signature = [resultSet stringForColumn:@"signature"];
        model.horoscope = [resultSet stringForColumn:@"horoscope"];
        model.single = [resultSet stringForColumn:@"single"];
        model.city = [resultSet stringForColumn:@"city"];
        NSString *histr = [resultSet stringForColumn:@"issayHi"];
        if ([histr isEqualToString:@"0"]) {
            model.issayHi = NO;
        }
        else
        {
            model.issayHi = YES;
        }
        NSString *photoStr = [resultSet stringForColumn:@"photo"];
        model.photo = [photoStr componentsSeparatedByString:@","];
        
        NSString *videoStr = [resultSet stringForColumn:@"video"];
        model.video = [videoStr componentsSeparatedByString:@","];
        
        NSString *videopreviewStr = [resultSet stringForColumn:@"videopreview"];
        model.videopreview = [videopreviewStr componentsSeparatedByString:@","];
        
        NSString *photopreviewStr = [resultSet stringForColumn:@"photopreview"];
        model.photopreview = [photopreviewStr componentsSeparatedByString:@","];
        [self.dataArray addObject:model];
    }
    
    [dataBase close];

    return self.dataArray;
}

/**
 建表
 */

-(void)firstchoose
{
    /** App判断第一次启动的方法 */
    NSString *key = @"isFirstDiscover";
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if (!isFirst) {
        NSLog(@"是第一次启动");
        [self creatTable];
    } else {
        NSLog(@"不是第一次启动");
    }
}

-(BOOL)iscanInsert
{
    NSString *day0 = [NSString new];
    NSString *day1 = [TimerGet getNowTimer];
    NSObject *obj = [[NSUserDefaults standardUserDefaults] objectForKey:Discoverday];
    
    if ([obj isKindOfClass:[NSNull class]]) {
        day0 = [TimerGet getNowTimer];
        [[NSUserDefaults standardUserDefaults] setObject:day0 forKey:Discoverday];
    }
    else
    {
        day0 = [[NSUserDefaults standardUserDefaults] objectForKey:Discoverday];
    }
 
    if ([day0 isEqualToString:day1]) {
        return NO;
    }
    return YES;
}

// 更新数据

- (void)updateDataWithuserId:(NSString *)newId {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"userData.sqlite"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    if ([dataBase open]) {
        NSString *sql = @"UPDATE t_discoverData SET issayHi = ? WHERE  id = ?";
        NSInteger idinter = [newId integerValue];
        BOOL res = [dataBase executeUpdate:sql, @(1), @(idinter)];
        if (!res) {
            NSLog(@"数据修改失败");
        }
        [dataBase close];
    }
}

@end
