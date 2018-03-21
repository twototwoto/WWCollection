//
//  CAGradientLayer+WWAdd.h
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAGradientLayer (WWAdd)
+ (CAGradientLayer *)wyw_gradientLayerColorsArray:(NSArray *)colorsArr startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint locationsArray:(NSArray *)locationsArr;
@end
