//
//  WWTestFPSTableViewCell.m
//  WWCollection
//
//  Created by WYW on 2018/5/12.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WWTestFPSTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation WWTestFPSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    UIImageView *avatarImageView = [UIImageView new];
    [self.contentView addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_height);
    }];
    
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526143725577&di=ce27a55ead6a1043461d13d868fe5dae&imgtype=0&src=http%3A%2F%2Fk2.jsqq.net%2Fuploads%2Fallimg%2F1801%2F17_180117093320_6.jpg"]];
    avatarImageView.layer.cornerRadius = 50.f;
    avatarImageView.layer.masksToBounds = YES;
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
