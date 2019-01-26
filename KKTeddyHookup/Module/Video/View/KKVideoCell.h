//
//  XTVideoCell.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KKVideolistModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UICollectionViewCell *)cell;

@end
@interface KKVideoCell : UICollectionViewCell
@property (nonatomic,strong) KKVideolistModel *model;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
-(void)newSetmodel:(KKVideolistModel *)model;
@end

NS_ASSUME_NONNULL_END
