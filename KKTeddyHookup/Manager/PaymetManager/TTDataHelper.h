//
//  KKDataHelper.h
//  KKTeddyHookup
//
//  Created by PanZhi on 2018/4/20.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTDataHelper : NSObject
+(void)saveDataToKeyChainWithKey:(NSString *)key value:(id)value;
+(NSString *)readDataFromKeyChainWithKey:(NSString *)key;
+(NSArray *)readMonthArray;
+(NSString *)readPrivacyStr;
+(NSString *)readUUIDFromKeyChain;
+(void)saveUUIDToKeyChain;
+(void)saveZodiacIndex:(NSString *)indexStr;
+(NSString *)readZodiacIndex;
//+(NSArray *)readCharacteristicData;
+(NSString *)readTipsImageStrIndex:(NSInteger)index;
+(void)saveLatestReceiptStr:(NSString *)ReceiptStr;
+(NSString *)readLatestReceipt;
+(void)saveReceiptInfo:(NSString *)ReceiptInfo;
+(void)saveTransactionInfo:(NSDictionary *)dic;
+(long long)getExpiresDate_ms;
+(NSDictionary *)getLatestReceiptInfo;
+(NSDictionary *)getTransactionInfo;
+(NSString *)getUUIDString;

#pragma mark - 非消耗型内购
//+(void)saveFilterAvailableInfo;
+(void)saveStickerAvailableInfo;
+(void)saveWatermaskAvailableInfo;
+(BOOL)readFilterAvailable;
+(BOOL)readStickerAvailable;
+(BOOL)readWatermaskAvailable;

+(void)unusablePayProduck;
//---------------

//保存home页背景图  url
+(void)saveHomeImageUrl:(NSString *)imageUrl;
//读取home页背景图  url
+(NSString *)readHomeImageUrl;
//保存home页背景图模糊  url
+(void)saveVagueHomeImageUrl:(NSString *)imageUrl;
//读取home页背景图模糊  url
+(NSString *)readVagueHomeImageUrl;




//+(void)updateRedDot;
//+(BOOL)readRedDotShow;
@end
