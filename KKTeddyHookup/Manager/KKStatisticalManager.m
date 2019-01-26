//
//  XTStatisticalManager.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKStatisticalManager.h"
#import "KKShowadModel.h"
#import "KKShowsubscribeModel.h"
#import "MJExtension.h"
#import <XTOOLAPP_LIBRARY/NSDictionary+DeleteNull.h>
#import "TTUpdateView.h"

@interface KKStatisticalManager ()

@end

@implementation KKStatisticalManager

+ (instancetype)shareTools {
    static KKStatisticalManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KKStatisticalManager alloc] init];
    });
    return _sharedClient;
}

-(void)loadData
{
    [XYLoadingHUD show];
    [self loadDataWithComplete:^(NSDictionary *requset) {
        NSLog(@"response----%@",requset);
        NSDictionary *data = [requset objectForKey:@"data"];
        NSDictionary *cloud = [data objectForKey:@"cloud"];
        NSDictionary *show_ad = [cloud objectForKey:@"show_ad"];
        NSDictionary *show_subscribe = [cloud objectForKey:@"show_subscribe"];
        NSArray * tabbars = [cloud objectForKey:@"tabbar"];
        NSArray * discovers = [cloud objectForKey:@"discover"];
        KKShowadModel *showadModel = [KKShowadModel sharedShowadModel];
        KKShowsubscribeModel *showsubModel =  [KKShowsubscribeModel sharedShowsubModel];
        showsubModel = [KKShowsubscribeModel yy_modelWithDictionary:show_subscribe];
        showadModel= [KKShowadModel yy_modelWithDictionary:show_ad];
        [[KKShowadModel sharedShowadModel] mj_setKeyValues:showadModel];
        [[KKShowsubscribeModel sharedShowsubModel] mj_setKeyValues:showsubModel];

        NSDictionary *advideo_number = [cloud objectForKey:@"advideo_number"];
        KKadvideoModel *adnumModel = [KKadvideoModel sharedadVideoModel];
        adnumModel = [KKadvideoModel yy_modelWithDictionary:advideo_number];
        [[KKadvideoModel sharedadVideoModel] mj_setKeyValues:advideo_number];
        
        NSLog(@"-------%@",[KKShowadModel sharedShowadModel].say_hi);
        
        [[NSUserDefaults standardUserDefaults] setObject:tabbars forKey:@"tabbar"];
        [[NSUserDefaults standardUserDefaults] setObject:discovers forKey:@"discover"];
        
        NSDictionary *start_push = [cloud objectForKey:@"start_push"];
        [[NSUserDefaults standardUserDefaults] setObject:start_push forKey:@"start_push"];
        
        NSLog(@"chat_robot_reply-----%@",showsubModel.chat_robot_reply);
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self bookVersionUpdate:requset];
        });
        [XYLoadingHUD dismiss];
    } error:^(NSError *error) {
        [XYLoadingHUD dismiss];
    }];
}


-(void)bookVersionUpdate:(NSDictionary *)dic{
    if (!dic) {
        return;
    }
    NSNumber *code = dic[@"code"];
    if (code.integerValue != 1) {
        return;
    }
    
    NSDictionary *data = dic[@"data"];
    NSNumber *blackip = data[@"blackip"];
    //1 命中黑名单
    //-1 错误
    //0 未命中
    if (blackip.integerValue == 1) {
        return;
    }
    /*
    "version_update": {
        "version_build": 3,        最新版本号
        "constraint_update": 1,    是否弹强制更新框 否则弹建议更新
        "isShow_update": 1         是否弹出更新框
        "update_info": 1           更新内容,可为空,弹窗有默认字段
        "update_btn_text": 1       按钮文字,可为空,有默认字段
        "update_header_image":     图片,可为空,有默认图片
        "update_info_aliment":0~2  对齐方式:0左1中2右,可为空,默认居中
    }*/
    NSDictionary *cloud = data[@"cloud"];
    NSDictionary *version_update = cloud[@"version_update"];
    
    NSNumber *version_build = version_update[@"version_build"];
    //获取build
    NSString *bundleVersion =  (NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (bundleVersion.integerValue >= version_build.integerValue) {
        
        [[XYLogManager shareManager] addLogKey1:@"update" key2:@"show" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:YES];
        return;
    }
    
    NSNumber *isShow_update = version_update[@"isShow_update"];
    if (!isShow_update.integerValue) {
        
        [[XYLogManager shareManager] addLogKey1:@"update" key2:@"show" content:@{@"type":@(1)} userInfo:[NSDictionary new] upload:YES];
        return;
    }

    NSNumber *constraint_update = version_update[@"constraint_update"];
    NSString *content_info = version_update[@"update_info"];
    NSString *update_btn_text = version_update[@"update_btn_text"];
    NSString *update_header_image = version_update[@"update_header_image"];
    NSNumber *update_info_aliment = version_update[@"update_info_aliment"];
    if (!update_info_aliment) {
        update_info_aliment = @(1);
    } else {
        if (update_info_aliment.integerValue < 0 || update_info_aliment.integerValue > 2) {
            update_info_aliment = @(1);
        }
    }

    if (constraint_update.integerValue) {
        [TTUpdateView showUpdateViewWithInfo:content_info infoTextAlignment:update_info_aliment.integerValue headerImageURL:update_header_image updateButtonText:update_btn_text shouldUpdate:YES handleBlock:^(BOOL update) {
            if (update) {
                [TTUpdateTool openAppStoreWithAppID:kAppStoreID];
            }
        }];
    }else{
        //建议更新
        [TTUpdateView showUpdateViewWithInfo:content_info infoTextAlignment:update_info_aliment.integerValue headerImageURL:update_header_image updateButtonText:update_btn_text shouldUpdate:NO handleBlock:^(BOOL update) {
            if (update) {
                [TTUpdateTool openAppStoreWithAppID:kAppStoreID];
            }
        }];
    }
}

- (void)loadDataWithComplete:(void (^)(NSDictionary * _Nonnull))successAction error:(void (^)(NSError * _Nonnull))errorAction {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString * time = [formatter stringFromDate:date];
    NSString * bundleVersion =  (NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countrycode = [locale localeIdentifier];
    NSString *country_code = [countrycode substringFromIndex:countrycode.length - 2];
    
    NSString *url = POST_CONGIG;
    
    [[AFNetAPIClient sharedClient] requestUrl:url cParameters:@{@"time":time,@"app_version":bundleVersion,@"country_code":country_code} success:^(NSDictionary * _Nonnull requset) {
        if ([[requset objectForKey:@"code"] intValue]==1) {
        
            // 保存配置信息
            [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary changeType:requset] forKey:kConfigInfoName];
            
            if (successAction) {
                successAction(requset);
            }
        } else {
            if (errorAction) {
                errorAction([NSError errorWithDomain:NSCocoaErrorDomain code:[[requset objectForKey:@"code"] intValue] userInfo:@{NSLocalizedDescriptionKey:@"data error"}]);
            }
        }
       
    } failure:^(NSError * _Nonnull error) {
        if (errorAction) {
            errorAction(error);
        }
    }];
}

- (NSDictionary *)getLocalConfigInfoDict {
    return (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kConfigInfoName];
}

- (NSString *)getLocalPrivacyPolicyUrl {
    NSDictionary *dict = [self getLocalConfigInfoDict];
    if (!dict) {
        return nil;
    }
    
    NSString *url = dict[@"data"][@"cloud"][@"subscribe"][@"privacy_policy"];
    return url?:nil;
}

- (NSString *)getLocalTermsSeveiceUrl {
    NSDictionary *dict = [self getLocalConfigInfoDict];
    if (!dict) {
        return nil;
    }
    
    NSString *url = dict[@"data"][@"cloud"][@"subscribe"][@"terms_of_services"];
    return url?:nil;
}

@end
