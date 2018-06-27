//
//  WYWSliderViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/27.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWSliderViewController.h"
#import "WYWSlider.h"
#import "WYWEnlargeClickAreaButton.h"

@interface WYWSliderViewController ()<WYWSliderTapDelegate>

@end

@implementation WYWSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSlider];
    [self someCorner];
    [self sliderCommonProblem];
    [self enlargeButtonTest];
}

- (void)enlargeButtonTest{
    WYWEnlargeClickAreaButton *enlargeClickAreaBtn = [WYWEnlargeClickAreaButton new];
    enlargeClickAreaBtn.frame = CGRectMake(20.f, 400.f, 5.f, 5.f);
    [self.view addSubview:enlargeClickAreaBtn];
    enlargeClickAreaBtn.backgroundColor = [UIColor redColor];
    [enlargeClickAreaBtn addTarget:self action:@selector(enlargeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)someCorner{
    /*
    //简单地处理圆角的方式
    UIImageView *cornerImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ITCoderW"]];
    cornerImgV.frame = CGRectMake(20, 100, 100, 100);
    [self.view addSubview:cornerImgV];
    cornerImgV.layer.cornerRadius = 20.f;
    cornerImgV.layer.masksToBounds = YES;
    cornerImgV.center = self.view.center;
     */
    
    //如果是要控制 左上 坐下 右上 右下 的圆角选择性显示 下边展示控制左上和右下圆角 左下右上为直角
    UIImageView *cornerImgV = [UIImageView new];
    cornerImgV.image = [UIImage imageNamed:@"ITCoderW"];
    cornerImgV.frame = CGRectMake(20, 100, 100, 100);
    [self.view addSubview:cornerImgV];
    cornerImgV.center = self.view.center;
    cornerImgV.backgroundColor = [UIColor redColor];
    
    /**
     * rect 指定path的形状的矩形
        The rectangle that defines the basic shape of the path.
     * corners 指定要哪些显示圆角
        A bitmask value that identifies the corners that you want rounded. You can use this parameter to round only a subset of the corners of the rectangle.
     * cornerRadii 每个圆角的半径
        The radius of each corner oval. Values larger than half the rectangle’s width or height are clamped appropriately to half the width or height.
     */
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:cornerImgV.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = bezierPath.CGPath;
    cornerImgV.layer.mask = shapeLayer;
    
}

- (void)sliderCommonProblem{
    WYWSlider *slider = [WYWSlider new];
    slider.tapSliderDelegate = self;
    [self.view addSubview:slider];
}

- (void)setupSlider{
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(20, 100, 300, 30)];
    
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [slider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [slider addTarget:self action:@selector(sliderTouchDownRePeat:) forControlEvents:UIControlEventTouchDownRepeat];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [slider addTarget:self action:@selector(sliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [slider addTarget:self action:@selector(sliderTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [slider addTarget:self action:@selector(sliderTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    /*
     UIControlEventTouchDown                                         = 1 <<  0,      // on all touch downs
     UIControlEventTouchDownRepeat                                   = 1 <<  1,      // on multiple touchdowns (tap count > 1)
     UIControlEventTouchDragInside                                   = 1 <<  2,
     UIControlEventTouchDragOutside                                  = 1 <<  3,
     UIControlEventTouchDragEnter                                    = 1 <<  4,
     UIControlEventTouchDragExit                                     = 1 <<  5,
     UIControlEventTouchUpInside                                     = 1 <<  6,
     UIControlEventTouchUpOutside                                    = 1 <<  7,
     UIControlEventTouchCancel                                       = 1 <<  8,
     
     UIControlEventValueChanged
     */
    
    /*
     UISlider 一般在拖动的时候
     * 都是这种 显示调用了一次sliderValueChanged(UIControlEventValueChanged)
     * 然后调用一次sliderValueTouchDown:(UIControlEventTouchDown)
     * 最后松手的时候调用的sliderTouchUpInside:(UIControlEventTouchUpInside)
     2018-06-27 22:23:52.438766+0800 WWCollection[77695:17823752] -[WYWSliderViewController sliderValueChanged:] [Line 104]
     2018-06-27 22:23:52.439106+0800 WWCollection[77695:17823752] -[WYWSliderViewController sliderTouchDown:] [Line 92]
     2018-06-27 22:23:52.756046+0800 WWCollection[77695:17823752] -[WYWSliderViewController sliderValueChanged:] [Line 104]
     2018-06-27 22:23:52.756256+0800 WWCollection[77695:17823752] -[WYWSliderViewController sliderTouchUpInside:] [Line 108]
     */
    
}

#pragma mark - Action
- (void)sliderTouchDown:(UISlider *)slider{
    WWLog(@"");
}

- (void)sliderDragEnter:(UISlider *)slider{
    WWLog(@"");
}

- (void)sliderTouchDownRePeat:(UISlider *)slider{
    WWLog(@"");
}

- (void)sliderValueChanged:(UISlider *)slider{
    WWLog(@"");
}

- (void)sliderTouchUpInside:(UISlider *)slider{
    WWLog(@"");
}

- (void)sliderTouchUpOutside:(UISlider *)slider{
    WWLog(@"");
}

- (void)sliderTouchCancel:(UISlider *)slider{
    WWLog(@"");
}

#pragma mark - WYWSliderTapDelegate
- (void)sliderTapDelgateGesture:(UITapGestureRecognizer *)tapGes{
    WWLog(@"");
}

#pragma mark - enlargeButtonClick Action
- (void)enlargeButtonClick:(UIButton *)sender{
    WWLog(@"");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    /*
     UISlider 的changed
     UISlider的touch相关方法的调用顺序：
     测试过程中：
     1.基本都是先调用一次 sliderValueChanged
     2.调用多次sliderValueChanged
     3.最后都是调用sliderTouchUpInside
     
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
