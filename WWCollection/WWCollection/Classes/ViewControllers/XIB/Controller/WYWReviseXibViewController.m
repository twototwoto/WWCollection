//
//  WYWReviseXibViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/13.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWReviseXibViewController.h"
#import "WYWReviseXibView.h"

@interface WYWReviseXibViewController ()

@end

@implementation WYWReviseXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    WYWReviseXibView *reviseXibView = [[NSBundle mainBundle]loadNibNamed:@"WYWReviseXib" owner:nil options:nil][0];
    [self.view addSubview:reviseXibView];
    reviseXibView.titleLabel.text = @"titleLabel titleLabeltitleLabel titleLabel titleLabel titleLabeltitleLabel titleLabel";
    reviseXibView.backgroundColor = [UIColor lightGrayColor];
    reviseXibView.frame = CGRectMake(0, 30.f, CGRectGetWidth(self.view.frame), 100.f);
    
    
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
