//
//  VideoPlayController.h
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "BaseViewController.h"
#import "KKVideolistModel.h"
#import "KKDiscoverModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnPeopleBlock)(BOOL isSayHi);

typedef NS_ENUM (NSInteger, RobotvideofromType)   {
    
    RobotvideofromList = 0,
    RobotvideofromDis = 1,
    RobotvideofromActive = 2,
    RobotvideofromLiked = 3,
    RobotvideofromShake = 4,
};

@interface KKVideoPlayController : BaseViewController
@property (nonatomic,strong) KKVideolistModel *model;
@property (nonatomic,copy) NSString *videoUrl;
@property (nonatomic, copy) ReturnPeopleBlock returnPeopleBlock;
@property (nonatomic,strong) KKDiscoverModel *disModel;
@property (nonatomic,assign) BOOL isfromDis;
@property (nonatomic,assign) BOOL issayHi;
@property (nonatomic,assign) BOOL isfromlikedme;

@property (nonatomic,assign) RobotvideofromType type;
-(void)returnPeopleindex:(ReturnPeopleBlock)block;
@end

NS_ASSUME_NONNULL_END
