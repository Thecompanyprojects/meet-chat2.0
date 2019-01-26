//
//  ChatDownload.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/11/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Progress)(NSString * key,CGFloat progress);


@interface KKChatDownload : NSObject
+ (instancetype)sharedChatManager;
@property(nonatomic,strong)NSMutableDictionary * downloadModelsDic;
@property (nonatomic, copy)Progress sprogress;
-(void)downloadUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
