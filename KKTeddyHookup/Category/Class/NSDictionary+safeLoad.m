//
//  NSDictionary+safeLoad.m
//  QuestionBank
//
//  Created by YangShuai on 2018/10/25.
//  Copyright © 2018 KK. All rights reserved.
//

#import "NSDictionary+safeLoad.h"

@implementation NSDictionary (safeLoad)

- (id)safeObj:(id)key
{
    if (self.count == 0) {
        return nil;
    }
    id obj = nil;
    if (![self isKindOfClass:[NSNull class]] && nil != key) {
        obj = self[key];
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = @"";
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
//            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
//            obj =[numberFormatter stringFromNumber:obj];
            obj = [NSString stringWithFormat:@"%@",obj];
        }

    }
    return obj;
    
}
-(NSString*) getNSString : (id)key{
    if (key == nil) {
        return @"";
    }
    id dataTmp = [self safeObj:key];
    if ([dataTmp isKindOfClass:[NSString class]] == YES) {
        return dataTmp;
    }
    if ([dataTmp isKindOfClass:[NSNumber class]] == YES) {
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:dataTmp];
    }
    
    if (dataTmp == nil) {
        return @"";
    }

    return nil;
}
@end

@implementation NSMutableDictionary (safeLoad)
-(void) safeSetObject : (id)obj
                forKey:(NSString*)key{
    if (obj == nil || key == nil) {
        return;
    }
    
    [self setObject : obj
             forKey : key];
}
@end
