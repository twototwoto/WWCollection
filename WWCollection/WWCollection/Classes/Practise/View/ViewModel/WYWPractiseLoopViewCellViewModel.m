//
//  WYWPractiseLoopViewCellViewModel.m
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWPractiseLoopViewCellViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation WYWPractiseLoopViewCellViewModel

- (UIImage *)backgroundImage{
    UIImage *backgroundImg = [UIImage new];
    NSURL *backgroundImgURL = nil;
    if (!self.loopViewmodel.imageURLString) {
        //占位图的图片
        backgroundImg = [UIImage imageNamed:@""];
    }
    else{
        if ([self.loopViewmodel.imageURLString isKindOfClass:[NSString class]]) {
            backgroundImgURL = [NSURL URLWithString:self.loopViewmodel.imageURLString];
        }
        
        NSData *backgroundImgData = [[NSData alloc]initWithContentsOfURL:backgroundImgURL];
       backgroundImg = [UIImage imageWithData:backgroundImgData];
    }
    
    return backgroundImg;
}

- (NSString *)titleString{
    return self.loopViewmodel.titleString ? self.loopViewmodel.titleString : @"";
}

/*
 其实就是相当于是model 中什么处理都没有 只放置了和服务端对接的数据对应的字段
 在ViewModel中放置的是把model加工处理后的viewModel  这个ViewModel 在传递给View或者是ViewController的时候 直接就可以使用
 
 再次的理解是view方面 存在着一个viewModel
 Controller方面也存在着一个ViewModel
 这两个ViewModel 都是做了一些逻辑处理的分担工作
 相关部分的内容要结合着数据绑定来看：
 可参考内容：
 https://runningyoung.github.io/2015/06/30/2015-07-20-ReactiveCocoa/
 http://gracelancy.com/blog/2016/01/06/ape-ios-arch-design/
 
 
 */

@end
