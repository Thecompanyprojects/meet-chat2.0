//
//  XTEditorheaderView.h
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/19.
//  Copyright © 2018 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKEditorImageView.h"
@class KKPersonModel;
NS_ASSUME_NONNULL_BEGIN
@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(NSString *)typeStr;

@end
@interface KKEditorheaderView : UIView
@property (nonatomic,strong) KKEditorImageView *imgView0;
@property (nonatomic,strong) KKEditorImageView *imgView1;
@property (nonatomic,strong) KKEditorImageView *imgView2;
@property (nonatomic,strong) KKEditorImageView *imgView3;
@property (nonatomic,strong) KKEditorImageView *imgView4;
@property (nonatomic,strong) KKEditorImageView *imgView5;
-(void)setheader:(KKPersonModel *)model;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end

NS_ASSUME_NONNULL_END
