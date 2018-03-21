//
//  CAShapeLayer+WWAdd.h
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
//导入了UIColor
#import <UIKit/UIColor.h>

@interface CAShapeLayer (WWAdd)
+ (CAShapeLayer *)wyw_lineWidth:(CGFloat)lineW strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineCap:(NSString *)lineCap lineJoin:(NSString *)lineJoin;
@end
