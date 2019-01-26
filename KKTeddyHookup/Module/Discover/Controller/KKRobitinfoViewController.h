//
//  XTRobotinfoViewController.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/25.
//  Copyright © 2018 KK. All rights reserved.
//

#import "BaseViewController.h"
#import "KKDiscoverModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnPeopleBlock)(BOOL peopleIndex);

typedef NS_ENUM (NSInteger, RobotinfofromType)   {

    RobotinfofromDis = 0,
    RobotinfofromActive = 1,
    RobotinfofromLiked = 2,
    RobotinfofromShake = 3
};

@interface KKRobitinfoViewController : BaseViewController
@property (nonatomic,strong) KKDiscoverModel *model;
@property (nonatomic, copy) ReturnPeopleBlock returnPeopleBlock;
@property (nonatomic,assign) RobotinfofromType type;
@end

NS_ASSUME_NONNULL_END
