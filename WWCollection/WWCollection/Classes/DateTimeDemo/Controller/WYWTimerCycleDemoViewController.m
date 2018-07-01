//
//  WYWTimerCycleDemoViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/30.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWTimerCycleDemoViewController.h"
#import "NSTimer+WWAdd.h"

@interface WYWTimerCycleDemoViewController ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation WYWTimerCycleDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self timerDemo];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
}

- (void)dealloc{
    WWLog(@"dealloc");
    [_timer invalidate];
}

- (void)timerAction:(id)sender{
    WWLog(@"fdsa");
}

- (void)timerDemo{
    /*
    //使用非循环引用的方式
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer eoc_scheduledTimerWithTimeInterval:1.f block:^{
//        WWLog(@"abcdef");
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return ;
        }
        [strongSelf changeBackgroundColor];
    } repeats:YES];
    
    return;
     */
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

- (void)changeBackgroundColor{
    self.view.backgroundColor = WWRandomColor;
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
