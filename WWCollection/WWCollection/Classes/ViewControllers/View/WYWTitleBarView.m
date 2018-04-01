//
//  WYWTitleBarView.m
//  WWCollection
//
//  Created by WYW on 2018/3/30.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWTitleBarView.h"

static CGFloat const kLineH = 1.0f;
static CGFloat const kMovingLineH = 2.0f;
static NSTimeInterval const kAnimationInterval = 0.5f;

@implementation WYWTitleBarView
{
    //承载所有button的数组
    NSMutableArray <UIButton *>*_buttonArrayM;
    //移动的视图
    UILabel *_movingLineLabel;
}

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
//        [self prepareData];
//        [self setupUI];
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

+ (instancetype)titleBarViewWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray textNormalColor:(UIColor *)textNormalColor textSelectedColor:(UIColor *)textSelectedColor{
    WYWTitleBarView *titleBarV = [[WYWTitleBarView alloc]initWithFrame:frame];
    titleBarV.titleArray = titleArray;
    titleBarV.textNormalColor = textNormalColor;
    titleBarV.textSelectedColor = textSelectedColor;
    return titleBarV;
}

- (void)layoutSubviews{
    [self prepareData];
    [self setupUI];
}

- (void)prepareData{
    _buttonArrayM = [NSMutableArray arrayWithCapacity:_titleArray.count];
}

- (void)setupUI{
    
    [self setupOtherViews];
    [self setupButtons];
}

#pragma mark - 添加的一些辅助性视图
- (void)setupOtherViews{
    if (_titleArray.count < 1) {
        return;
    }
    CGFloat W = CGRectGetWidth(self.frame);
    CGFloat H = CGRectGetHeight(self.frame);
    UILabel *lineLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, H - 1.0f, W, 1.0f)];
    [self addSubview:lineLbl];
    lineLbl.backgroundColor = [UIColor grayColor];
    
    UILabel *movingLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, H - kMovingLineH, W/_titleArray.count, kMovingLineH)];
    [self addSubview:movingLbl];
    movingLbl.backgroundColor = [UIColor blueColor];
    _movingLineLabel = movingLbl;
    movingLbl.backgroundColor = _textSelectedColor;
    
}

#pragma mark - 布局button
- (void)setupButtons{
    if (_titleArray.count < 1) {
        return;
    }
    CGFloat btnW = self.frame.size.width / _titleArray.count;
    CGFloat btnH = self.frame.size.height;
    for (NSInteger i = 0; i < _titleArray.count; i ++) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [_buttonArrayM addObject:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_textNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:_textSelectedColor forState:UIControlStateSelected];
        
    }
    //默认选中
    _buttonArrayM[0].selected = YES;
}

#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    [UIView animateWithDuration:kAnimationInterval animations:^{
        CGRect tempFrame = _movingLineLabel.frame;
        tempFrame.origin.x = sender.tag * (self.frame.size.width / _titleArray.count);
        _movingLineLabel.frame = tempFrame;
        WWLog(@"%f",_movingLineLabel.frame.origin.x);
    }];
    for (UIButton *subBtn in _buttonArrayM) {
        subBtn.selected = NO;
    }
    sender.selected = YES;
    NSAssert(self.btnBlock, @"请写明block回调");
    
    self.btnBlock(sender.tag);
}


@end
