//
//  WYWImplicitAnimationViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/24.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//学习隐式动画事务部分

#import "WYWImplicitAnimationViewController.h"

@interface WYWImplicitAnimationViewController ()
@property (nonatomic,strong) UIView *layerView;
@property (nonatomic,strong) CALayer *colorLayer;

@end

@implementation WYWImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testRoutineAnimation];
    [self setupUI];
    
}

- (void)setupUI{
    UIButton *changeColorBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    changeColorBtn.backgroundColor = [UIColor grayColor];
    [changeColorBtn setTitle:@"改变颜色" forState:UIControlStateNormal];
    [self.view addSubview:changeColorBtn];
    changeColorBtn.center = self.view.center;
    
    [changeColorBtn addTarget:self action:@selector(changeColorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //呈现与模型
    //获取到触摸点
    CGPoint point = [[touches anyObject]locationInView:self.view];
    //检查是否我们点击了移动的layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        self.colorLayer.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255/255.0f alpha:1.0f].CGColor;
    }else{
        //慢慢地移动图层到新的位置
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0f];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

#pragma mark - 呈现与模型
- (void)presentationModel{
    
}

#pragma mark - 图层行为
- (void)wwLayerMotion{
    //如果是直接那UIView相关联的图层来做处理的话
    NSLog(@"%@",[self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    //在Xcode9.2的情况下 发现 使用上边的代码设置 还是说相关的layerView的部分的相关layer为nil 的时候都可以正常地响应相关动画 不像书上写的会因为是相关的layer的backgroundColor 为nil而禁用了图层行为
//    [CATransaction setAnimationDuration:1.0f];
//    换作
    NSLog(@"%@",[self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]); // <null>
    [UIView beginAnimations:nil context:nil];
    NSLog(@"%@",[self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]); // <CABasicAnimation: 0x151915670>
    self.layerView.layer.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0f green:(arc4random() % 255)/255.0f blue:(arc4random() % 255)/255.0f alpha:1.0f].CGColor;
//    [UIView commitAnimations];
    
    
    [CATransaction commit];
    
}

- (void)changeColorBtnClick:(UIButton *)sender{
//    [self wwLayerMotion];
//    return;
    //随机展示layer的背景色
//    CGFloat redValue = arc4random() /(CGFloat)INTMAX_MAX;
//    CGFloat greenValue = arc4random() /(CGFloat)INTMAX_MAX;
//    CGFloat blueValue = arc4random() /(CGFloat)INTMAX_MAX;
//    self.colorLayer.backgroundColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f].CGColor;
//    self.colorLayer.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0f green:(arc4random() % 255)/255.0f blue:(arc4random() % 255)/255.0f alpha:1.0f].CGColor;
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    INTMAX_MAX; INT_MAX;
//    [UIView animateWithDuration:1.0f animations:^{
//        self.colorLayer .backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
//    } completion:^(BOOL finished) {
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        self.colorLayer.affineTransform = transform;
//    }];
    
    //使用动画块的方式和下边是一样的 只不过直觉上感觉下边的方式更有动画的感觉 更平滑
//    return;
    [CATransaction begin];
    //设置动画时长
    [CATransaction setAnimationDuration:1.0f];
   
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    //设置完成块
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformMakeRotation(M_PI_2); //这个只是在第一次的时候转动一次
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
        
    }];
    
    [CATransaction commit];
    
    
}

- (void)testRoutineAnimation{
    self.layerView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.layerView];
    self.layerView.backgroundColor = [UIColor whiteColor];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.layerView.layer addSublayer:self.colorLayer];
    
    
    
    return;
    //自定义图层行为补充
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor":transition};
    
    
}

- (void)readMe{
    /*
     隐式动画之所以叫隐式动画是因为没有指定动画的类型 而只是改变了动画的一个属性 然后CoreAnimation 来决定如何以及何时去做动画
     
     */
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
