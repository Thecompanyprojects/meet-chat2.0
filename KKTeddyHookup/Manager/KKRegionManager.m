//
//  KKRegionManager.m
//  KKTeddyHookup
//
//  Created by 王俊钢 on 2018/11/29.
//  Copyright © 2018 小叶科技. All rights reserved.
//

#import "KKRegionManager.h"

@implementation KKRegionManager

-(void)getcountryStr
{
    //    NSLocale *currentLocale = [NSLocale currentLocale];
    //    NSLog(@"Country Code is %@", [currentLocale objectForKey:NSLocaleCountryCode]);
    /// 国家
    //
    //    NSLocale *locale = [NSLocale currentLocale];
    //
    //    NSString *country = [locale localeIdentifier];
}

-(void)getTimezoneStr
{
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSString *strZoneName = [zone name];
    NSString *strZoneAbbreviation = [zone abbreviation];
    NSLog(@"名称 是 %@",strZoneName);
    NSLog(@"缩写 是 %@",strZoneAbbreviation);
}



@end
