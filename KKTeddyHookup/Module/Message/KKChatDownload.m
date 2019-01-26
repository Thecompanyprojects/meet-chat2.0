//
//  ChatDownload.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/11/16.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKChatDownload.h"

@implementation KKChatDownload
+ (instancetype)sharedChatManager{
    static KKChatDownload *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[KKChatDownload alloc]init];
    });
    return _manager;
}
- (NSMutableDictionary *)downloadModelsDic {
    
    if (!_downloadModelsDic) {
        _downloadModelsDic = [NSMutableDictionary dictionary];
    }
    return _downloadModelsDic;
}
-(void)downloadUrl:(NSString *)url{
    
    NSString * nameKey = [NSString md5:url];
    NSURLSessionDownloadTask * task = [self.downloadModelsDic objectForKey:nameKey];
    
    if (!task || task.state != 0) { //没有任务活下载任务没有下载
        self.sprogress(nameKey, 0);
        AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
        
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        task = [session downloadTaskWithRequest:request progress:^(NSProgress *  downloadProgress) {
            //下载进度
            NSLog(@"下载进度----%f",downloadProgress.fractionCompleted);
            if (self->_sprogress) {
                self.sprogress(nameKey, downloadProgress.fractionCompleted);
            }
            //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //                self.pro.progress=downloadProgress.fractionCompleted;
            //        }];
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            //下载到哪个文件夹
            NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            
            //        NSString *fileName=[cachePath stringByAppendingPathComponent:response.suggestedFilename];
            
            NSString *fileName=[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",nameKey]];
            return [NSURL fileURLWithPath:fileName];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            if (error == nil) {
                //下载完成了
                [self.downloadModelsDic removeObjectForKey:nameKey];
                NSLog(@"下载完成了 %@",filePath);
            }else{
                NSLog(@"downloadError----%@",error.localizedDescription);
            }
        }];
    }

    [self.downloadModelsDic setObject:task forKey:nameKey];
    [task resume];//开始下载
}
@end
