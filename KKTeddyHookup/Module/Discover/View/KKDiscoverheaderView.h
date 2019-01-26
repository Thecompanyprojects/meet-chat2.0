//
//  discoverheaderView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/17.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol myHeadVdelegate <NSObject>

-(void)myheaderClick:(NSString *)typeStr;

@end

@interface KKDiscoverheaderView : UIView

@property(assign,nonatomic)id<myHeadVdelegate>delegate;
@end

NS_ASSUME_NONNULL_END
