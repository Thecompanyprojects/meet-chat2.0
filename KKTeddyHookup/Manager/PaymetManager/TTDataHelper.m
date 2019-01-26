//
//  KKDataHelper.m
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/4/20.
//  Copyright © 2018年 KK. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincomplete-implementation"

#import "TTDataHelper.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
#import <FCUUID/FCUUID.h>
#import <Security/Security.h>


@interface TTDataHelper ()

@property (nonatomic, strong) dispatch_queue_t serQueue;

@end
@implementation TTDataHelper
+ (instancetype) shareInstance{
    static TTDataHelper* _instance = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    }) ;
    return _instance ;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _serQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}


+(void)saveDataToKeyChainWithKey:(NSString *)key value:(id)value{//Receipt_data
    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStoreWithService:@"com.teddy.hookup.chat"];
    [keyChain setString:value forKey:key];
}

+(NSString *)readDataFromKeyChainWithKey:(NSString *)key{
    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStoreWithService:@"com.teddy.hookup.chat"];
    NSString *uuid = (NSString *)[keyChain stringForKey:key];
    return uuid;
}

+(NSDictionary *)getLatestReceiptInfo{
    if ([TTDataHelper getTransactionInfo]) {
        NSArray *arr = [TTDataHelper getTransactionInfo][@"latest_receipt_info"];
        return arr.lastObject;
    }else{
        return nil;
    }
}

+(void)saveTransactionInfo:(NSDictionary *)dic{
    [kUserDefaults setObject:dic forKey:@"TransactionInfo_key"];
    [kUserDefaults synchronize];
}

+(NSDictionary *)getTransactionInfo{
    return  [kUserDefaults objectForKey:@"TransactionInfo_key"];
}

//保存index
+(void)saveZodiacIndex:(NSString *)indexStr{
    [kUserDefaults setObject:indexStr forKey:@"zodiac_index_key"];
    [kUserDefaults synchronize];
}

+(NSString *)readZodiacIndex{
    return [kUserDefaults objectForKey:@"zodiac_index_key"];
}

#pragma mark - 保存和读取UUID

+ (NSString *)getUUIDString
{
    return [FCUUID uuidForDevice];
    
//    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
//    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    CFRelease(strRef);
//    CFRelease(uuidRef);
//    return uuidString;
    
}



//保存最新的收据
+ (void)saveLatestReceiptStr:(NSString *)ReceiptStr{
    dispatch_async([TTDataHelper shareInstance].serQueue, ^{
        [self saveDataToKeyChainWithKey:@"latest_receipt" value:ReceiptStr];
    });
}

+ (NSString *)readLatestReceipt{
    return [self readDataFromKeyChainWithKey:@"latest_receipt"];
}

+(void)saveReceiptInfo:(NSString *)ReceiptInfo{
    [self saveDataToKeyChainWithKey:@"Receipt_data" value:ReceiptInfo];
}


+(long long)getExpiresDate_ms{
    if ([self getLatestReceiptInfo]) {
        NSNumber *dateNum = [self getLatestReceiptInfo][@"expires_date_ms"];
        return dateNum.longLongValue;
    }
    return 0;
}


+(void)saveHomeImageUrl:(NSString *)imageUrl{
    [kUserDefaults setObject:imageUrl forKey:@"homeImage_key"];
}

+(NSString *)readHomeImageUrl{
    NSString *str = [kUserDefaults objectForKey:@"homeImage_key"];
    if (!str) {
        str = @"http://";
    }
    return str;
}


+(void)saveVagueHomeImageUrl:(NSString *)imageUrl{
    [kUserDefaults setObject:imageUrl forKey:@"VaguehomeImage_key"];
}

+(NSString *)readVagueHomeImageUrl{
    return [kUserDefaults objectForKey:@"VaguehomeImage_key"];
}



//vague
#pragma clang diagnostic pop

@end
