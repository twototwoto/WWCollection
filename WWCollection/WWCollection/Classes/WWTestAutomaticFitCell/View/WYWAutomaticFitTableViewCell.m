//
//  WYWAutomaticFitTableViewCell.m
//  WWCollection
//
//  Created by WYW on 2018/5/14.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWAutomaticFitTableViewCell.h"

@implementation WYWAutomaticFitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    
    UILabel *nameLbl = [UILabel new];
    [self.contentView addSubview:nameLbl];
    nameLbl.text = @"博主";
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
    }];
    
    self.contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLbl.mas_bottom).mas_offset(100.f);
        make.left.right.bottom.equalTo(self.contentView);
//        make.edges.equalTo(self.contentView);
        
    }];
    _contentLabel.numberOfLines = 0;
    
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
