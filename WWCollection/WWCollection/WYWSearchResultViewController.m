//
//  WYWSearchResultViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/16.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWSearchResultViewController.h"

@interface WYWSearchResultViewController ()

@end

@implementation WYWSearchResultViewController



//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = NO;
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)setupUI{
    UIView *redV = [UIView new];
    redV.backgroundColor = [UIColor redColor];
    [self.view addSubview:redV];
    //像这种设置视图的位置和size的 都是使用的 px / scale的值
//    redV.frame = CGRectMake(0, 0, 375, 667);
    redV.frame = self.view.bounds;
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
