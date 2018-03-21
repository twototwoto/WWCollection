//
//  WYWDrawingView.m
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWDrawingView.h"
#import "CAShapeLayer+WWAdd.h"

@implementation WYWDrawingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMatchStickMan];
        [self setupCornerSquareShape];
    }
    return self;
}

#pragma mark - 使用CAShapeLayer绘制火柴
- (void)setupMatchStickMan{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(175, 100)];
    [bezierPath addArcWithCenter:CGPointMake(150, 100) radius:25.0f startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    [bezierPath moveToPoint:CGPointMake(150, 125)];
    [bezierPath addLineToPoint:CGPointMake(150, 175)];
    [bezierPath addLineToPoint:CGPointMake(125, 225)];
    
    [bezierPath moveToPoint:CGPointMake(150, 175)];
    [bezierPath addLineToPoint:CGPointMake(175, 225)];
    
    [bezierPath moveToPoint:CGPointMake(100, 150)];
    [bezierPath addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer wyw_lineWidth:20.f strokeColor:[UIColor redColor] fillColor:[UIColor blueColor] lineCap:kCALineCapRound lineJoin:kCALineJoinRound];
    
    shapeLayer.path = bezierPath.CGPath;
    
    shapeLayer.frame = self.bounds;
    [self.layer addSublayer:shapeLayer];
    
}

#pragma mark - 创建一个有圆角有直角视图
- (void)setupCornerSquareShape{
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGSize size = CGSizeMake(20, 20);
    //设置左上角 左下角 右下角 显示为有圆角的形式
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
//    shapeLayer.backgroundColor = [UIColor blueColor].CGColor;
//    shapeLayer.frame = self.bounds;
//    shapeLayer.frame = rect;
//    shapeLayer.frame =  CGRectMake(0, 0, rect.size.width, rect.size.height);
    shapeLayer.frame =  CGRectMake(200, 200, rect.size.width, rect.size.height);
    shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
}





@end
