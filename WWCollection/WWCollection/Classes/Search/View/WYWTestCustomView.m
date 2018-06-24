//
//  WYWTestCustomView.m
//  WWCollection
//
//  Created by WYW on 2018/6/23.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWTestCustomView.h"

@implementation WYWTestCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
 写这个类的初衷是因为有人问到我
 自定义的视图后 使用Masonry 布局怎么没有起到作用
 对方是用new 来创建的自定义视图 这样的话 只是会调用init方法
 而不会调用initWithFrame 方法
 所以如果想用new  或者说init的方式来创建 就需要在init方法中有对应的约束调用 这样自己的那些子视图 才能够正常地创建 包括之后的布局
 */
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 100,100)];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    
}

@end
