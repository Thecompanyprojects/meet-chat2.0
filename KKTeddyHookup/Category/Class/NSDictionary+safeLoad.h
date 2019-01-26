//
//  NSDictionary+safeLoad.h
//  QuestionBank
//
//  Created by meng on 15/4/13.
//  Copyright (c) 2015年 wangshuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safeLoad)

- (id)safeObj:(id)key;
-(NSString*) getNSString : (id)key;


@end

@interface NSMutableDictionary(safe)
-(void) safeSetObject : (id)obj
                forKey:(NSString*)key;
@end