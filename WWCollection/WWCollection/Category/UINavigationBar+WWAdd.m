//
//  UINavigationBar+WWAdd.m
//  WWCollection
//
//  Created by WYW on 2018/3/16.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//学习网址：http://tech.glowing.com/cn/change-uinavigationbar-backgroundcolor-dynamically/#
//https://github.com/ltebean/LTNavigationBar
#import "UINavigationBar+WWAdd.h"
#import <objc/runtime.h>

@implementation UINavigationBar (WWAdd)
static char overlaykey;

- (UIView *)overlay{
    //    return objc_getAssociatedObject(self,&overlaykey);
    return objc_getAssociatedObject(self,&overlaykey);
    
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlaykey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)wyw_setBackgroundColor:(UIColor *)backgroundColor{
    if(!self.overlay){
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20.0f)];
        
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self insertSubview:self.overlay atIndex:1];
        [self.subviews.firstObject insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

@end
