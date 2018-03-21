//
//  CAShapeLayer+WWAdd.m
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "CAShapeLayer+WWAdd.h"

@implementation CAShapeLayer (WWAdd)
+ (CAShapeLayer *)wyw_lineWidth:(CGFloat)lineW strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineCap:(NSString *)lineCap lineJoin:(NSString *)lineJoin{
    
    //创建CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //线条颜色
    shapeLayer.strokeColor = strokeColor.CGColor;
    //填充颜色
    shapeLayer.fillColor = fillColor.CGColor;
    //线宽
    shapeLayer.lineWidth = lineW;
    shapeLayer.lineJoin = lineJoin;
    //线段的两端的样式
    shapeLayer.lineCap = lineCap;
    
    return shapeLayer;
}
@end
