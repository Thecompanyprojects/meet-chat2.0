//
//  XTConstellationJudge.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/24.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKConstellationJudge.h"

@implementation KKConstellationJudge

/**
 *  根据生日计算星座
 *
 *  @param month 月份
 *  @param day   日期
 *
 *  @return 星座名称
 */
+(NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day
{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31){
        return @"错误日期格式!";
    }
    
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
//    魔羯座  Capricorn
//    水瓶座  Aquarius
//    双鱼座  Pisces
//    牡羊座  Aries
//    金牛座  Taurus
//    双子座  Gemini
//    巨蟹座  Cancer
//    狮子座  Leo
//    处女座  Virgo
//    天秤座  Libra
//    天蝎座  Scorpio
//    射手座  Sagittarius
    if ([result isEqualToString:@"魔羯"]) {
        
        return [NSString stringWithFormat:@"%@",@"Capricorn"];
    }
    if ([result isEqualToString:@"水瓶"]) {
        
        return [NSString stringWithFormat:@"%@",@"Aquarius"];
    }
    if ([result isEqualToString:@"双鱼"]) {
        
        return [NSString stringWithFormat:@"%@",@"Pisces"];
    }
    if ([result isEqualToString:@"白羊"]) {
        
        return [NSString stringWithFormat:@"%@",@"Aries"];
    }
    if ([result isEqualToString:@"金牛"]) {
        
        return [NSString stringWithFormat:@"%@",@"Taurus"];
    }
    if ([result isEqualToString:@"双子"]) {
        
        return [NSString stringWithFormat:@"%@",@"Gemini"];
    }
    if ([result isEqualToString:@"巨蟹"]) {
        
        return [NSString stringWithFormat:@"%@",@"Cancer"];
    }
    if ([result isEqualToString:@"狮子"]) {
        
        return [NSString stringWithFormat:@"%@",@"Leo"];
    }
    if ([result isEqualToString:@"处女"]) {
        
        return [NSString stringWithFormat:@"%@",@"Virgo"];
    }
    if ([result isEqualToString:@"天秤"]) {
        
        return [NSString stringWithFormat:@"%@",@"Libra"];
    }
    if ([result isEqualToString:@"天蝎"]) {
        
        return [NSString stringWithFormat:@"%@",@"Scorpio"];
    }
    if ([result isEqualToString:@"射手"]) {
        
        return [NSString stringWithFormat:@"%@",@"Sagittarius"];
    }
    return [NSString stringWithFormat:@"%@",result];
}

@end
