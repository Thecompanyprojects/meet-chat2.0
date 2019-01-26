//
//  NSString+SKYExtension.h
//  TestDemo
//
//  Created by Topsky on 2018/4/24.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SKYExtension)

- (CGSize)contentSizeWithWidth:(CGFloat)width
                          font:(UIFont *)font
                   lineSpacing:(CGFloat)lineSpacing;
//是否只有一行
- (BOOL)contentHaveOneLinesWithWidth:(CGFloat)width
                                font:(UIFont *)font
                         lineSpacing:(CGFloat)lineSpacing;

-(NSString *)filtrationSpecailCharactor;

//MD5加密
+(NSString *)md5:(NSString *)str;



+ (BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error;

+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError *__autoreleasing *)error;
@end
