//
//  WYWLayerViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//学习核心动画高级技巧之CAShapeLayer

#import "WYWLayerViewController.h"
#import "CAGradientLayer+WWAdd.h"
#import "WYWDrawingView.h"

#import "CAShapeLayer+WWAdd.h"

#import "WWCycleView.h"

@interface WYWLayerViewController ()

@end

@implementation WYWLayerViewController{
    CAShapeLayer *_shapeLayer;
    WWCycleView *_cycleView;
}



- (void)testCycleView{
    
    WWCycleView *cycleV = [WWCycleView new];
    //注意cycleV内部的未知的圆环的中心
    cycleV.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:cycleV];
    cycleV.backgroundColor = [UIColor redColor];
    cycleV.progress = 100.f;
    _cycleView = cycleV;
    //单独地运行一次也没有什么内存问题
    
//    [cycleV setNeedsDisplay];
    return;
//    WWCycleView *cycleV = [WWCycleView new];
//    [self.view addSubview:cycleV];
//    cycleV.frame = CGRectMake(0, 0, 100, 100);
//    cycleV.progress = 100.f;
//    cycleV.backgroundColor = [UIColor redColor];
//    [cycleV setNeedsDisplay];
}

- (void)sliderClick:(UISlider*)slider{
    NSLog(@"%f",slider.value);
    if (slider.value < 0.2) {
        _cycleView.progress = 0.5;
    }else if(slider.value < 0.4){
        _cycleView.progress = 1.0f;
    }else if(slider.value < 0.6){
        _cycleView.progress = 1.5;
    }else if(slider.value < 0.8){
        _cycleView.progress = 2.0f;
    }else{
        _cycleView.progress = 2.5f;
    }
    _cycleView.progress *= 0.2;
//    _cycleView.progress = slider.value;
    [_cycleView setNeedsDisplay];
}
- (void)setupSlider{
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(100, 300, 300, 100)];
    [slider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:slider];
}

- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [self testCAGradientLayer];
            break;
        case 1:
            [self testCAShapeLayer];
            break;
        case 2:
            [self testCycleView];
            break;
            
        default:
            break;
    }
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *titleStr = self.title;
    NSArray *arr = @[@"CAGradientLayer",@"CAShapeLayer",@"testCycleProgressView"];
    NSInteger index = [arr indexOfObject:titleStr];
    NSArray *selectorArr = @[@"testCAGradientLayer",@"testCAShapeLayer",@"testCycleView"];
    NSString *selectorStr = selectorArr[index];
    
    [self performSelector:NSSelectorFromString(selectorStr) withObject:self afterDelay:0];
    
    return;
    
    NSMutableArray <UIButton *>*btnArrM = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSInteger i = 0; i < arr.count; i ++) {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor yellowColor];
        btn.tag = i;
        
        if (btn.tag % 2) {
            btn.backgroundColor = [UIColor blueColor];
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnArrM addObject:btn];
    }
    UIStackView *stackView = [[UIStackView alloc]initWithArrangedSubviews:btnArrM];

    stackView.distribution = UIStackViewDistributionFillEqually;
//    stackView.alignment = UIStackViewAlignmentBottom;
    stackView.backgroundColor = [UIColor redColor];
    stackView.frame = CGRectMake(0, self.view.bounds.size.height - 200, CGRectGetWidth(self.view.frame), 200);
    [self.view addSubview:stackView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSSelectorFromString(@"")
    
    [self setupUI];
    
    return;
    
    [self setupSlider];
    [self testCycleView];
    
    return;
    [self testCAShapeLayer];
    return;
    [self testCAGradientLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    _shapeLayer.strokeEnd = arc4random() % 1;
    //下边的strokeEnd这个属性很给力 在刷新相关的进度的时候算是比较便捷的
    _shapeLayer.strokeEnd = (arc4random() % 1000) / 1000.0f;
    _cycleView.progress = (arc4random()%1000)/1000.f;
    NSLog(@"%f",_cycleView.progress);
    [_cycleView setNeedsDisplay];
}

#pragma mark - 测试CAShapeLayer
- (void)testCAShapeLayer{
    WYWDrawingView *drawingView = [WYWDrawingView new];
    drawingView.frame = self.view.bounds;
    //要用下边的方式 上边的方式 在drawingview的内部后去self.bounds的时候获取不到会出现问题
    drawingView = [[WYWDrawingView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:drawingView];
    //开始看出不来颜色 好尴尬 设置的背景色和渲染的颜色是一样的
//    drawingView.backgroundColor = [UIColor redColor];
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""] highlightedImage:nil];
    imgV.frame = CGRectMake(50, 50, 170, 170);
    imgV.backgroundColor = [UIColor blueColor];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer wyw_lineWidth:12.f strokeColor:[UIColor redColor] fillColor:[UIColor clearColor] lineCap:kCALineCapRound lineJoin:kCALineJoinRound];
    //注意添加到谁的layer上以后 在设置center的时候只需要设置相应的宽度或者高度的一般即可
    //而且还要注意半径部分的相关的问题
    CGPoint center = CGPointMake(85, 85);
    UIBezierPath *bezierpath = [UIBezierPath bezierPathWithArcCenter:center radius:77.0 startAngle:0 + M_PI_2 / 3.0 endAngle:M_PI_2 clockwise:YES];
    _shapeLayer = shapeLayer;
    
    //这两个属性挺好用的
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1.0f;
    //使用strokeStart 和 startEnd的方式 会在多次测试的情况下 内存都是很稳定的 单独测试的时候只有7.9MB
    //如果是采用在drawRect的方法中来写呢 有待测试是一个什么情况
    
    
    shapeLayer.path = bezierpath.CGPath;
    shapeLayer.frame = imgV.bounds;
    [imgV.layer addSublayer:shapeLayer];
    
    [self.view addSubview:imgV];
    
    
    UIProgressView *progreessView = [UIProgressView new];
    progreessView.backgroundColor = [UIColor blueColor];
    progreessView.trackTintColor = [UIColor redColor];
    [self.view addSubview:progreessView];
    progreessView.frame = imgV.frame;
    progreessView.frame = CGRectMake(0, 0, 100, 100);
    progreessView.backgroundColor = [UIColor yellowColor];
    
    
    
}

- (void)testCAGradientLayer{
    
    //    @[
    //      (__bridge id)[UIColor redColor].CGColor,
    //      (__bridge id)[UIColor greenColor].CGColor),
    //      ];
    NSArray *colorsArray =
    @[
      (__bridge id)([UIColor redColor].CGColor),
      (__bridge id)[UIColor greenColor].CGColor,
      (__bridge id)[UIColor blueColor].CGColor
      ];
    NSArray *locationsArr = @[@0,@0.3,@0.6];
    //    NSArray *locationsArr = @[@0,@0.1];
//    locationsArr = @[];
    CAGradientLayer *gradientLayer = [CAGradientLayer wyw_gradientLayerColorsArray:colorsArray startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1) locationsArray:locationsArr];
    
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
