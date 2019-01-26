//
//  CardView.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "KKCardView.h"
#import "Masonry.h"

@interface KKCardView()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *ageLabel;
// dislike
@property (nonatomic,strong) UIImageView *dislike;
// like
@property (nonatomic,strong) UIImageView *like;

@end

@implementation KKCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
      
        [self setUp];
        
    }
    
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    [self addSubview:self.imageView];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    self.nameLabel.backgroundColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.nameLabel];
    
    
    self.ageLabel = [[UILabel alloc]init];
    self.ageLabel.textColor = [UIColor whiteColor];
    self.ageLabel.backgroundColor = MainColor;
    self.ageLabel.font = [UIFont systemFontOfSize:10.0f];
    self.ageLabel.textAlignment = NSTextAlignmentCenter;
    self.ageLabel.layer.cornerRadius = 4;
    self.ageLabel.layer.masksToBounds = YES;
    [self addSubview:self.ageLabel];
    
    self.dislike = [[UIImageView alloc]init];
    self.dislike.image = [UIImage imageNamed:@"dislike"];
    self.dislike.alpha = 0.0f;
    [self addSubview:self.dislike];

    self.like = [[UIImageView alloc]init];
    self.like.image = [UIImage imageNamed:@"like"];
    self.like.alpha = 0.0f;
    [self addSubview:self.like];
    
    
//    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 30)];
//    self.label.textAlignment = NSTextAlignmentCenter;
//    self.label.textColor = [UIColor redColor];
//    self.label.font = [UIFont systemFontOfSize:30];
//    [self addSubview:self.label];
}

- (void)YFLDragCardViewLayoutSubviews
{
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-65);
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(12);
        make.top.equalTo(self).with.offset(self.imageView.frame.size.height+18);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLabel).with.offset(5);
        make.left.equalTo(self.nameLabel.mas_right).mas_offset(5);
        make.centerY.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(25, 12));
    }];
    self.like.frame = CGRectMake(16, 16, 75, 75);
    self.dislike.frame = CGRectMake(self.frame.size.width-21-75, 16, 75, 75);
}

- (void)setImage:(NSString*)imageName name:(NSString*)name withAge:(NSString *)age
{
    
    NSString * url = [imageName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"backImg"]];
    self.nameLabel.text = name;
    self.ageLabel.text = age;
}
-(void)recoverAnimation{
    self.like.alpha = 1.0f;
    self.like.image = [UIImage imageNamed:@"recover"];
    self.dislike.alpha = 0.0f;
    [UIView animateWithDuration:2.0f animations:^{
        if (self.like) {
            self.like.alpha = 0.0f;
        }
    }];
}
- (void)setAnimationwithDriection:(ContainerDragDirection)direction
{

    
    if (direction == ContainerDragLeft) {
        self.dislike.alpha = 1.0f;
        self.like.alpha = 0.0f;
//        [UIView animateWithDuration:0.2f animations:^{
//            if (self.dislike) {
//                self.dislike.alpha = 1.0f;
//                self.dislike.transform = CGAffineTransformMakeRotation(45*M_PI / 180.0);
//            }
//        }];
    }else if(direction == ContainerDragRight){
        self.like.alpha = 1.0f;
        self.like.image = [UIImage imageNamed:@"like"];
        self.dislike.alpha = 0.0f;
//        [UIView animateWithDuration:0.2f animations:^{
//            if (self.like) {
//                self.like.alpha = 1.0f;
//                self.like.transform = CGAffineTransformMakeRotation(-45*M_PI / 180.0);
//            }
//        }];
    }else{
        
        self.like.alpha = 0.0f;
        self.dislike.alpha = 0.0f;
        [UIView animateWithDuration:0.2 animations:^{
            if (self.like) {
//                self.like.transform = CGAffineTransformMakeRotation(45*M_PI / 180.0);
            }
            if (self.dislike) {
//                self.dislike.transform = CGAffineTransformMakeRotation(-45*M_PI / 180.0);
            }
        }];
    }
}




@end
