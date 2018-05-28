//
//  WYWTextField.m
//  WWCollection
//
//  Created by WYW on 2018/5/28.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWTextField.h"

//偏移量
static CGFloat const kOffsetX = 5.0f;
@implementation WYWTextField

//这种尤其会在UITextField显示了rightView影响输入光标的位置
- (CGRect)textRectForBounds:(CGRect)bounds{
    //使用CGRectInset的时候当使用的缩进的值比较大的时候会崩溃还没有发现问题。。returned NaN for an intrinsicContentSizeDimension. Using UIViewNoIntrinsicMetric instead.

//    return CGRectInset(bounds, 50.f, 0);
    return CGRectMake(bounds.origin.x + kOffsetX, bounds.origin.y, bounds.size.width - kOffsetX, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    //看起来是两侧都会往里边缩进
//        return CGRectInset(bounds, 50.f, 0);
    return CGRectMake(bounds.origin.x + kOffsetX, bounds.origin.y, bounds.size.width - kOffsetX, bounds.size.height);
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
