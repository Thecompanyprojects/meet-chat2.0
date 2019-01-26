//
//  peopleCell.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDiscoverModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UICollectionViewCell *)cell;

@end
@interface KKpeopleCell : UICollectionViewCell
@property (nonatomic,strong) KKDiscoverModel *model;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end

NS_ASSUME_NONNULL_END
