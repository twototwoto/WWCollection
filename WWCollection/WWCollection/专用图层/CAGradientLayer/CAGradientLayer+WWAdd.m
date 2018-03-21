//
//  CAGradientLayer+WWAdd.m
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//学习核心动画高级技巧之CAGradientLayer

#import "CAGradientLayer+WWAdd.h"

@implementation CAGradientLayer (WWAdd)

+ (CAGradientLayer *)wyw_gradientLayerColorsArray:(NSArray *)colorsArr startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint locationsArray:(NSArray *)locationsArr{
    //注意locationsArr的数组中元素的个数要和colorsArr中的元素的个数一定要相同 否则的话会得到一个空白渐变 不过经过了我的测试发现并不是 测试的结果是显示的渐变的效果是没有应用locations的样式 只有在locations为空数组的时候是出不来渐变的效果的 只显示colors的第一个元素的颜色
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = startPoint;
    //设置layer的终点位置
    layer.endPoint = endPoint;
    //设置颜色数组
    layer.colors = colorsArr;
    //设置颜色的分布的比例数组
    layer.locations = locationsArr;
    
    return layer;
}

@end
