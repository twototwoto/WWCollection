//
//  WYWTableViewCellXib.m
//  WWCollection
//
//  Created by WYW on 2018/6/14.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWTableViewCellXib.h"
NSString* const WYWTableViewCellXibReuseID = @"WYWTableViewCellXibReuseID";
@implementation WYWTableViewCellXib

- (void)awakeFromNib {
    [super awakeFromNib];
    //如果想要改变背景色在这里写 注意设置xib中的子视图的约束的时候注意是参考的safeArea 还是参考的当前的xibView 两者相差20
    self.backgroundColor = [UIColor blueColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
