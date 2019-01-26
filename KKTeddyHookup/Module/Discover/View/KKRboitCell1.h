//
//  XTRobitCell1.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/26.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDiscoverModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(NSString *)vieoUrl;
    
@end
@interface KKRboitCell1 : UITableViewCell
@property (nonatomic,strong) KKDiscoverModel *model;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end

NS_ASSUME_NONNULL_END
