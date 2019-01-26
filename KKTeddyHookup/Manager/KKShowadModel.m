//
//  XTShowadModel.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKShowadModel.h"

@implementation KKShowadModel

+ (instancetype)sharedShowadModel{
    static KKShowadModel *_showadModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showadModel = [[KKShowadModel alloc]init];
    });
    return _showadModel;
}

-(void)loadAdwithType
{
    switch (self.type) {
        case Showadwithlike:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:KeyLike scene:LOADADlike];
            break;
        case Showadwithsay_hi:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:KeySayhi scene:LOADADsay_hi];
            break;
        case Showadwithalive:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:KeyAlive scene:LOADADalive];
            break;
        case Showadwithshake:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:KeyShake scene:LOADADshake];
            break;
        case Showadwithdrifter:
            [[XYAdBaseManager sharedInstance] loadAdWithKey:KeyDrifter scene:LOADADdrifter];
            break;
        default:
            break;
    }
}


/**
 摇一摇广告内容

 @return 是否显示摇一摇广告内容
 */
-(BOOL)shakeAdisShow
{
    if ([KKUserModel sharedUserModel].isVip)
    {
        return NO;
    }
    NSString *shake = self.shake;
    self.newshake = self.newshake+1;
    NSInteger newintshake=  self.newshake;
    NSInteger intshake = [shake integerValue];
    if (newintshake%intshake==0&&intshake!=0) {
        return YES;
    }
    return NO;
}


/**
 活跃的人广告内容

 @return 是否显示活跃的人广告内容
 */
-(BOOL)activeAdisShow
{
    if ([KKUserModel sharedUserModel].isVip) {
        return NO;
    }
    NSString *alive = self.alive;
    //MARK - 插屏广告
    self.newalive = self.newalive+1;
    NSInteger newintAlive =  self.newalive;
    NSInteger intalive = [alive integerValue];
    
    if (intalive!=0&&newintAlive%intalive==0) {
        return YES;
    }
    return NO;
}

/**
 漂流瓶广告部分

 @return 是否显示漂流瓶部分插屏广告
 */
-(BOOL)drifterADisshow
{
    if ([KKUserModel sharedUserModel].isVip) {
        return NO;
    }
    NSString *drifter = self.drifter;
    //MARK - 插屏广告
    self.newdrifter = self.newdrifter+1;
    NSInteger newintnewdrifter =  self.newdrifter;
    NSInteger intdrifter = [drifter integerValue];
    
    if (intdrifter!=0&&newintnewdrifter%intdrifter==0) {
        return YES;
    }
    return NO;
}


/**
 say_hi广告内容

 @return 是否显示say_hi广告内容
 */
-(BOOL)sayhiADisshow
{
    if ([KKUserModel sharedUserModel].isVip) {
        return NO;
    }
    NSString *sayhi = self.say_hi;
    //MARK - 插屏广告
    self.newsay_hi = self.newsay_hi+1;
    NSInteger intnewsayhi =  self.newsay_hi;
    NSInteger intsayhi = [sayhi integerValue];
    
    if (intsayhi!=0&&intnewsayhi%intsayhi==0) {
        return YES;
    }
    return NO;
}

@end
