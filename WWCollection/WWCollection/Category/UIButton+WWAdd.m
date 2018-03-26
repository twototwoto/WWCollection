//
//  UIButton+WWAdd.m
//  WWCollection
//
//  Created by WYW on 2018/3/26.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//学习网址：https://my.oschina.net/sayonala/blog/198376

#import "UIButton+WWAdd.h"
static const CGFloat kDefaultSpacing = 6.0f;
@implementation UIButton (WWAdd)
- (void)wyw_buttonCenterImageAndTitle{
    [self wyw_buttonCenterImageAndTitleWithSpace:kDefaultSpacing];
}

- (void)wyw_buttonCenterImageAndTitleWithSpace:(CGFloat)space{
    //获取到图片尺寸 文字label尺寸
    CGSize imgSize = self.imageView.image.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    //获取总高度 图片 titleLabel 以及 space
    CGFloat totalHeight = imgSize.height + titleSize.height + kDefaultSpacing;
    //图片的设置偏移部分比较容易理解 相当于图片占到了顶部的位置 右边想要占满的话又需要往右扩充titleLabel 的宽度
    //对于titleLabel来说 左侧比较容易确定是偏移一个图片的宽度 就左对齐了
    //上边的位置要向下偏移一个图片的高度 外加一个间隙的高度 或者是整体的高度 减去 titleLabel 的高度
    
    /*
     偏移位置的部分还有待更多的思考 感觉这都算是那种 图片和文字高度一致的情况下 比较使用的范围
     水平排列的时候是：
        图片 文字
     垂直排列的时候是：
        图片
        间隙
        文字
     */
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imgSize.height), 0, 0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imgSize.width, -(totalHeight - titleSize.height), 0);
    
    
    
    
    
}

//发现重写了下边的方法后 不能够正常显示了 问题有待查证
#pragma mark - TODO: - 发现重写了下边的方法后 不能够正常显示了 问题有待查证
//- (void)layoutSubviews{
////    return;
//    //图片中心确定的时候 x方向以 button的宽度来参考 y方向的中心以自己的imageView的中心位置来确定
//    CGPoint center = self.imageView.center;
//    center.x = self.frame.size.width / 2.0f;
//    center.y = self.imageView.frame.size.height / 2.0f;
//    self.imageView.center = center;
//
//    CGRect titleFrame = self.titleLabel.frame;
//    titleFrame.origin.x = 0;
//    titleFrame.origin.y = self.imageView.frame.size.height + kDefaultSpacing;
//    titleFrame.size.width = self.frame.size.width;
//    self.titleLabel.frame = titleFrame;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//}
@end
