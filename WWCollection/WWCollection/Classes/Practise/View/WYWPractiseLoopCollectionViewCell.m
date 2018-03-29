//
//  WYWPractiseLoopCollectionViewCell.m
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWPractiseLoopCollectionViewCell.h"


@implementation WYWPractiseLoopCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setLoopViewCellViewModel:(WYWPractiseLoopViewCellViewModel *)loopViewCellViewModel{
    self.backgroundImageView.image = loopViewCellViewModel.backgroundImage;
    
    self.titleLabel.text = loopViewCellViewModel.titleString;
}

- (void)setupUI{
    self.backgroundImageView = [UIImageView new];
    [self.contentView addSubview:self.backgroundImageView];
    self.backgroundImageView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(0, 0, 100, 40);
    self.titleLabel.center = self.contentView.center;
    
//    self.titleLabel.frame = CGRectMake(CGRectGetMidX(self.contentView.frame), CGRectGetMidY(self.contentView.frame), CGRectGetWidth(self.contentView.frame) * 0.5, CGRectGetHeight(self.contentView.frame) * 0.5);
    self.contentView.backgroundColor = [UIColor yellowColor];
    self.titleLabel.textColor = [UIColor blueColor];
    
}


@end
