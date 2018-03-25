//
//  WWCycleView.m
//  WWPractise
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 WYW. All rights reserved.
//
//学习网址：https://github.com/twototwoto/SomeCodesAboutSwift.git

#import "WWCycleView.h"

@implementation WWCycleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
    
    CGPoint center = CGPointMake(100.f, 100.f);//设置圆心位置
    CGFloat radius = 90.f;  //设置半径
    CGFloat startAngle = -M_PI_2;   //设置起始角度
    CGFloat endAngle = -M_PI_2 + M_PI_2 * _progress;    //设置终止角度
    
    startAngle = 0;
    endAngle = -M_PI;
    endAngle = -M_PI * self.progress;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGContextSetLineWidth(ctx, 10.f); //设置线条宽度
    [[UIColor blueColor]setStroke]; //设置描边颜色
    CGContextAddPath(ctx, bezierPath.CGPath); //把路径添加到上下文
    CGContextStrokePath(ctx);
    
    
}

@end
