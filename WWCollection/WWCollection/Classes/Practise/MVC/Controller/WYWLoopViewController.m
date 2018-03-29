//
//  WYWLoopViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWLoopViewController.h"
#import "WYWPraciseLoopView.h"

@interface WYWLoopViewController ()

@end

@implementation WYWLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    //CGRectMake(0, 0, self.view.frame.size.width / 3.0f, self.view.frame.size.height)
    WYWPraciseLoopView *loopView = [[WYWPraciseLoopView alloc]initWithFrame:self.view.bounds];
    loopView.backgroundColor = [UIColor blueColor];
//    loopView.frame = self.view.bounds;  loopView.imageURLStringArray
    [self.view addSubview:loopView];
    NSArray *imageURLStringArray;
    NSArray *titleStringArray;
    titleStringArray = @[@"0",@"1",@"2"];
    imageURLStringArray = @[@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png",
    @"http://img.zcool.cn/community/01690955496f930000019ae92f3a4e.jpg@2o.jpg",
      @"http://pic30.nipic.com/20130620/2531170_083003138000_2.jpg"];
    NSMutableArray *tempArrM = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 3; i ++) {
        WYWPractiseLoopViewModel *loopViewModel = [WYWPractiseLoopViewModel new];
        loopViewModel.imageURLString = imageURLStringArray[i];
        loopViewModel.titleString = titleStringArray[i];
        [tempArrM addObject:loopViewModel];
        
    }
    loopView.loopViewModelArray = [tempArrM copy];
   
    
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
