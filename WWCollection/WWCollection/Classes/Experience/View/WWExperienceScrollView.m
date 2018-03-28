//
//  WWExperienceScrollView.m
//  WWCollection
//
//  Created by WYW on 2018/3/28.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WWExperienceScrollView.h"

@implementation WWExperienceScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    //最近遇到的一个关于响应者对应的视图的问题 如果这么写的话 只有UIScrollView上的某些类别的视图 可以响应事件处理 这个处理有的时候 对我们有用 有的时候又可能会对后期的功能的扩展埋下忘记的隐患从而以为发生了某些bug
    if ([view isMemberOfClass:[UIButton class]]) {
        return view;
    }
    return nil;
}

@end
