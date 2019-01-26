//
//  XTShowsubscribeModel.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKShowsubscribeModel.h"
#import "TimerGet.h"


@implementation KKShowsubscribeModel

+ (instancetype)sharedShowsubModel{
    static KKShowsubscribeModel *_showsubModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showsubModel = [[KKShowsubscribeModel alloc]init];
    });
    return _showsubModel;
} 


/**
 sayhi
 
 @return sayhi 次数判断
 */
-(BOOL)sayhinumberClick
{
    if ([KKUserModel sharedUserModel].isVip) {
        return YES;
    }
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:sayhiNumber];
    NSString *day0 = [NSString new];
    
    day0 = [[NSUserDefaults standardUserDefaults] objectForKey:sayhiDay];
    NSString *day1 = [TimerGet getNowTimer];
    
    if (![day0 isEqualToString:day1]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:sayhiNumber];
        [[NSUserDefaults standardUserDefaults] setObject:day1 forKey:sayhiDay];
        numberStr = [NSString new];
        
    }
    else
    {
        numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:sayhiNumber];
        
    }
    
    if ([numberStr integerValue]>=[self.say_hi integerValue]) {
        
        return NO;
    }
    else
    {
        return YES;
    }
    return YES;
}

/**
 活跃的人
 
 @return 刷新次数判断
 */
-(BOOL)activepeopleCanShow
{
    if ([KKUserModel sharedUserModel].isVip) {
        
        return YES;
    }
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:activeNumber];
    NSString *day0 = [NSString new];
    day0 = [[NSUserDefaults standardUserDefaults] objectForKey:activeDay];
    
    NSString *day1 = [TimerGet getNowTimer];
    if (![day0 isEqualToString:day1]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:activeNumber];
        [[NSUserDefaults standardUserDefaults] setObject:day1 forKey:activeDay];
        numberStr = [NSString new];
    }
    else
    {
        numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:activeNumber];
    }

    NSString *day2 = [NSString new];
    
    NSString *newStr1 = [[NSUserDefaults standardUserDefaults] objectForKey:AddactiveDay];
    if (newStr1.length!=0) {
        day2 = [[NSUserDefaults standardUserDefaults] objectForKey:AddactiveDay];;
    }
    else
    {
        day2 = [TimerGet getNowTimer];
        [[NSUserDefaults standardUserDefaults] setObject:day2 forKey:AddactiveDay];
    }
    
    NSString *day3 = [TimerGet getNowTimer];

    int addNumint = 0;

    if (![day2 isEqualToString:day3]) {
        [[NSUserDefaults standardUserDefaults] setObject:day3 forKey:AddactiveDay];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:ADDactiveNumber];
    }
    else
    {
        NSString *addNumber = [[NSUserDefaults standardUserDefaults] objectForKey:ADDactiveNumber];
        addNumint = [addNumber intValue];
    }
    
    if ([numberStr integerValue]>=([self.alive_refresh integerValue]+addNumint)) {
        return NO;
    }
    else
    {
        return YES;
    }
    return YES;
}

/**
 摇一摇
 
 @return 摇一摇次数判断
 */
-(BOOL)shakeCanShow
{
    if ([KKUserModel sharedUserModel].isVip) {
        
        return YES;
    }
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:shakeNumber];

    NSString *day0 = [NSString new];

    day0 = [[NSUserDefaults standardUserDefaults] objectForKey:getShakeday];
    
    NSString *day1 = [TimerGet getNowTimer];
    if (![day0 isEqualToString:day1]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:shakeNumber];
        [[NSUserDefaults standardUserDefaults] setObject:day1 forKey:getShakeday];
        numberStr = [NSString new];
    }
    else
    {
        numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:shakeNumber];
    }
    
    
    NSString *day2 = [NSString new];
    NSString *newStr1 = [[NSUserDefaults standardUserDefaults] objectForKey:AddshakeDay];
    if (newStr1.length!=0) {
        day2 = [[NSUserDefaults standardUserDefaults] objectForKey:AddshakeDay];;
    }
    else
    {
        day2 = [TimerGet getNowTimer];
        [[NSUserDefaults standardUserDefaults] setObject:day2 forKey:AddshakeDay];
    }
    
    NSString *day3 = [TimerGet getNowTimer];
    
    int addNumint = 0;
    if (![day2 isEqualToString:day3]) {
        addNumint = 0;
        [[NSUserDefaults standardUserDefaults] setObject:day3 forKey:AddshakeDay];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:ADDshakeNumber];
    }
    else
    {
        NSString *addNumber = [[NSUserDefaults standardUserDefaults] objectForKey:ADDshakeNumber];
        addNumint = [addNumber intValue];
    }
    if ([numberStr integerValue]>=([self.shake integerValue]+addNumint)) {

        return NO;
    }
    else
    {
        
        return YES;
    }
    return YES;
}


/**
 捡瓶子
 
 @return 捡瓶子次数判断
 */
-(BOOL)getbottleCanShow
{
    if ([KKUserModel sharedUserModel].isVip) {
        
        return YES;
    }
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlegetNumber];
    NSString *day0 = [NSString new];

    day0 = [[NSUserDefaults standardUserDefaults] objectForKey:getBottleday];
    NSString *day1 = [TimerGet getNowTimer];
    
    if (![day0 isEqualToString:day1]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:bottlegetNumber];
        [[NSUserDefaults standardUserDefaults] setObject:day1 forKey:getBottleday];
        numberStr = [NSString new];
    }
    else
    {
        numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlegetNumber];
    }
    NSString *day2 = [NSString new];
    NSString *newStr1 = [[NSUserDefaults standardUserDefaults] objectForKey:AddgetbottleDay];
    if (newStr1.length!=0) {
        day2 = [[NSUserDefaults standardUserDefaults] objectForKey:AddgetbottleDay];;
    }
    else
    {
        day2 = [TimerGet getNowTimer];
        [[NSUserDefaults standardUserDefaults] setObject:day2 forKey:AddgetbottleDay];
    }
    
    NSString *day3 = [TimerGet getNowTimer];
    
    int addNumint = 0;
    
    if (![day2 isEqualToString:day3]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:ADDgetbottleNumber];
        [[NSUserDefaults standardUserDefaults] setObject:day3 forKey:AddgetbottleDay];
    }
    else
    {
        NSString *addNumber = [[NSUserDefaults standardUserDefaults] objectForKey:ADDgetbottleNumber];
        addNumint = [addNumber intValue];
    }

    if ([numberStr integerValue]>=([self.drifter_reply integerValue]+addNumint)) {
      

        return NO;
    }
    else
    {
        return YES;
    }
    return YES;
}


/**
 扔瓶子
 
 @return 扔瓶子次数判断
 */
-(BOOL)putbottleCanShow
{
    if ([KKUserModel sharedUserModel].isVip) {
        
        return YES;
    }
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlesetNumber];

    NSString *day0 = [NSString new];

    day0 = [[NSUserDefaults standardUserDefaults] objectForKey:setBottleday];
    NSString *day1 = [TimerGet getNowTimer];
    if (![day0 isEqualToString:day1]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:bottlesetNumber];
        [[NSUserDefaults standardUserDefaults] setObject:day1 forKey:setBottleday];
        numberStr = [NSString new];
    }
    else
    {
        numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlesetNumber];
    }
    
    NSString *day2 = [NSString new];
    NSString *newStr1 = [[NSUserDefaults standardUserDefaults] objectForKey:AddsetbottleDay];
    if (newStr1.length!=0) {
        day2 = [[NSUserDefaults standardUserDefaults] objectForKey:AddsetbottleDay];;
    }
    else
    {
        day2 = [TimerGet getNowTimer];
        [[NSUserDefaults standardUserDefaults] setObject:day2 forKey:AddsetbottleDay];
    }
    
    NSString *day3 = [TimerGet getNowTimer];
    
    int addNumint = 0;
  
    
    if (![day2 isEqualToString:day3]) {
        [[NSUserDefaults standardUserDefaults] setObject:day3 forKey:AddsetbottleDay];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:ADDsetbottleNumber];
    }
    else
    {
        NSString *addNumber = [[NSUserDefaults standardUserDefaults] objectForKey:ADDsetbottleNumber];
        addNumint = [addNumber intValue];
    }
    
    if ([numberStr intValue]>=([self.drifter_throw integerValue]+addNumint)&&[day0 isEqualToString:day1]) {
      
        return NO;
    }
    return YES;
}


/**
 喜欢
 
 @return 喜欢 滑动判断
 */
-(BOOL)likedCanShow
{
    if ([KKUserModel sharedUserModel].isVip) {
        
        return YES;
    }
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:likedNumber];

    NSString *day0 = [NSString new];

    day0 = [[NSUserDefaults standardUserDefaults] objectForKey:likedDay];
    NSString *day1 = [TimerGet getNowTimer];
    if (![day0 isEqualToString:day1]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:likedNumber];
        [[NSUserDefaults standardUserDefaults] setObject:day1 forKey:likedDay];
         numberStr = [NSString new];
    }
    else
    {
         numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:likedNumber];
    }
    
    NSString *day2 = [NSString new];
    NSString *newStr1 = [[NSUserDefaults standardUserDefaults] objectForKey:AddlivedDay];
    if (newStr1.length!=0) {
        day2 = [[NSUserDefaults standardUserDefaults] objectForKey:AddlivedDay];;
    }
    else
    {
        day2 = [TimerGet getNowTimer];
        [[NSUserDefaults standardUserDefaults] setObject:day2 forKey:AddlivedDay];
    }
    
    int addNumint = 0;
   
    NSString *day3 = [TimerGet getNowTimer];
    
    if (![day2 isEqualToString:day3]) {
        [[NSUserDefaults standardUserDefaults] setObject:day3 forKey:AddlivedDay];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:ADDlikedNumber];
    }
    else
    {
        NSString *addNumber = [[NSUserDefaults standardUserDefaults] objectForKey:ADDlikedNumber];
        addNumint = [addNumber intValue];
    }
    
    if ([numberStr integerValue]>=([self.like integerValue]+addNumint)) {
        return NO;
    }
    else
    {
        
        return YES;
    }
    return YES;
}

/**
 Say_hi number
 */
-(void)addSayhiNumberClick
{
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:sayhiNumber];
    NSInteger intnumber = 0;
    if ([numberStr isKindOfClass:[NSNull class]]) {
        intnumber = 0;
    }
    else
    {
        intnumber = [numberStr integerValue];
    }
    intnumber  = intnumber+1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",intnumber] forKey:sayhiNumber];
    numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:sayhiNumber];
}


/**
 Active refresh number
 */
-(void)addrefreshActivePeopleClick
{
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:activeNumber];
    NSInteger intnumber = 0;
    if ([numberStr isKindOfClass:[NSNull class]]) {
        intnumber = 0;
    }
    else
    {
        intnumber = [numberStr integerValue];
    }
    intnumber  = intnumber+1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",intnumber] forKey:activeNumber];
    numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:activeNumber];
}


/**
 摇一摇 Number
 */
-(void)shakecountClick
{
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:shakeNumber];
    NSInteger intnumber = 0;
    if ([numberStr isKindOfClass:[NSNull class]]) {
        intnumber = 0;
    }
    else
    {
        intnumber = [numberStr integerValue];
    }
    intnumber  = intnumber+1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",intnumber] forKey:shakeNumber];
    numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:shakeNumber];
}

/**
 捞瓶子 Number
 */
-(void)addGetbottleClick
{
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlegetNumber];
    NSInteger intnumber = 0;
    if ([numberStr isKindOfClass:[NSNull class]]) {
        intnumber = 0;
    }
    else
    {
        intnumber = [numberStr integerValue];
    }
    intnumber  = intnumber+1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",intnumber] forKey:bottlegetNumber];
    numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlegetNumber];
}

/**
 扔瓶子 Number
 */
-(void)addSetbottleClick
{
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlesetNumber];
    NSInteger intnumber = 0;
    if ([numberStr isKindOfClass:[NSNull class]]) {
        intnumber = 0;
    }
    else
    {
        intnumber = [numberStr integerValue];
    }
    intnumber  = intnumber+1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",intnumber] forKey:bottlesetNumber];
    numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:bottlesetNumber];
}

/**
 新的订阅界面
 
 @return 是否选择新的订阅界面
 */
-(BOOL)isNewSub
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    NSDate *newDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstDay"];
    
    NSDateComponents* comp1 = [gregorian components: unitFlags
                                           fromDate:newDate];
    int dayint = [self.subscribe_day intValue];

    dayint = -1;
    int dayints = (int)comp.day-(int)comp1.day;
    if (comp1.year!=comp.year) {
        return YES;
    }
    if (comp1.month!=comp.month) {
        return YES;
    }
    if (dayints>dayint) {
        return YES;
    }
    return NO;
}

/**
 滑动撤回 增加次数
 */
-(void)addSlideRecallClick{
    NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:sliderRecallsetNumber];
    NSInteger intnumber = 0;
    if ([numberStr isKindOfClass:[NSNull class]]) {
        intnumber = 0;
    }
    else
    {
        intnumber = [numberStr integerValue];
    }
    intnumber  = intnumber+1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",intnumber] forKey:sliderRecallsetNumber];
    numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:sliderRecallsetNumber];
}
/**
 滑动撤回
 */
-(BOOL)slideRecallCanShow{
    
    if ([KKUserModel sharedUserModel].isVip) {
        
        return YES;
    }
    
    NSNumber *addNumber = [[NSUserDefaults standardUserDefaults] objectForKey:AddsliderRecallNumber];
    
    return [addNumber boolValue];
    
}

/**
 第一次启动
 */
-(void)firstchoose
{
    /** App判断第一次启动的方法 */
    NSString *key = @"isFirst";
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if (!isFirst) {
        NSLog(@"是第一次启动");
        NSDate *date = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"firstDay"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"不是第一次启动");
    }
}


@end
