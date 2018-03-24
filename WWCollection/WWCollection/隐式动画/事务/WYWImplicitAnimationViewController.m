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

- (void)changeColorBtnClick:(UIButton *)sender{
    //随机展示layer的背景色
//    CGFloat redValue = arc4random() /(CGFloat)INTMAX_MAX;
//    CGFloat greenValue = arc4random() /(CGFloat)INTMAX_MAX;
//    CGFloat blueValue = arc4random() /(CGFloat)INTMAX_MAX;
//    self.colorLayer.backgroundColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f].CGColor;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0f green:(arc4random() % 255)/255.0f blue:(arc4random() % 255)/255.0f alpha:1.0f].CGColor;
}

- (void)testRoutineAnimation{
    self.layerView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.layerView];
    self.layerView.backgroundColor = [UIColor whiteColor];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.layerView.layer addSublayer:self.colorLayer];
    
    
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
