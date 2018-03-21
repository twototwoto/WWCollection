//
//  WYWLayerViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWLayerViewController.h"
#import "CAGradientLayer+WWAdd.h"

@interface WYWLayerViewController ()

@end

@implementation WYWLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCAGradientLayer];
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
