//
//  discoverCell.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/17.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDiscoverModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UICollectionViewCell *)cell;

@end

@interface KKdiscoverCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *coverImg;
- (void)setModel:(KKDiscoverModel *)model withIndex:(NSIndexPath *)index;
- (void)newsetModel:(KKDiscoverModel *)model;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end

NS_ASSUME_NONNULL_END
