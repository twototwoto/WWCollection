//
//  WWLearnFPSViewController.m
//  WWCollection
//
//  Created by WYW on 2018/5/12.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WWLearnFPSViewController.h"
#import "WWTestFPSTableViewCell.h"

#import <KMCGeigerCounter/KMCGeigerCounter.h>
static NSString* const kTestFPSCellResuseIDString = @"kTestFPSCellResuseIDString";
@interface WWLearnFPSViewController ()<UITableViewDataSource,UITableViewDelegate>

/**FPSTableView*/
@property (nonatomic,strong) UITableView *testFPSTableView;
@end

@implementation WWLearnFPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testFPSTableView];
    _testFPSTableView.delegate = self;
    _testFPSTableView.dataSource = self;
    [KMCGeigerCounter sharedGeigerCounter].enabled = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WWTestFPSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTestFPSCellResuseIDString forIndexPath:indexPath];
    return cell;
}


- (UITableView *)testFPSTableView{
    if (!_testFPSTableView) {
        _testFPSTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _testFPSTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _testFPSTableView.estimatedRowHeight = 100.f;
        [_testFPSTableView registerClass:[WWTestFPSTableViewCell class] forCellReuseIdentifier:kTestFPSCellResuseIDString];
    }
    return _testFPSTableView;
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
