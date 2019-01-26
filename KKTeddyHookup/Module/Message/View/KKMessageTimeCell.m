//
//  MessageTimeCell.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/24.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKMessageTimeCell.h"
#import "Masonry.h"

@implementation KKMessageTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.timeLable = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLable];
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.height.mas_offset(16);
            make.top.equalTo(self.contentView.mas_top).with.offset(0);
        }];
        self.timeLable.backgroundColor = [UIColor colorWithHexString:@"#D7D7D7"];
        self.timeLable.layer.cornerRadius = 8;
        self.timeLable.clipsToBounds = YES;
        self.timeLable.textAlignment = NSTextAlignmentCenter;
        self.timeLable.textColor = [UIColor whiteColor];
        self.timeLable.font = [UIFont systemFontOfSize:11.0];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
