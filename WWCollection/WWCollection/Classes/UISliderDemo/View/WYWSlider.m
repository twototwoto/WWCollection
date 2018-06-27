//
//  WYWSlider.m
//  WWCollection
//
//  Created by WYW on 2018/6/27.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWSlider.h"

@implementation WYWSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    return [self initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGesture];
    }
    return self;
}

#pragma mark - 添加点击手势
- (void)addTapGesture{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:tapGes];
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGes{
    if (self.tapSliderDelegate && [self.tapSliderDelegate respondsToSelector:@selector(sliderTapDelgateGesture:)]) {
        [self.tapSliderDelegate sliderTapDelgateGesture:tapGes];
        
    }
}

//当想要扩大Slider的点击范围的时候重写的方法
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    rect.origin.y = rect.origin.y - 10;
    rect.origin.x = rect.origin.x - 2;
    rect.size.height = rect.size.height + 20;
    rect.size.width = rect.size.width + 4;
    return CGRectInset([super thumbRectForBounds:bounds trackRect:rect value:value], -2, -10);
}



@end
