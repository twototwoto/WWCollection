//
//  WWTestAutomaticFitCellViewController.m
//  WWCollection
//
//  Created by WYW on 2018/5/14.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WWTestAutomaticFitCellViewController.h"
#import "WYWAutomaticFitTableViewCell.h"

static NSString* const kAutomaticFitTableViewCellReuseIDString = @"kAutomaticFitTableViewCellReuseIDString";
@interface WWTestAutomaticFitCellViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *automaticFitCellTableView;
@end

@implementation WWTestAutomaticFitCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.automaticFitCellTableView];
    [self.automaticFitCellTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _automaticFitCellTableView.delegate = self;
    _automaticFitCellTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里只是先简单的测试下：
    WYWAutomaticFitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAutomaticFitTableViewCellReuseIDString forIndexPath:indexPath];
    if (indexPath.row % 2) {
//        cell.contentLabel.text = @"asdfajdkfjakl;djfjasdjfla;sdkjfkasdjfjasdkjflkjalsdjfl;asdfjlas;dfjalk;sdjf;ljasdfj;asdjf;ajsdfljasl;dkfjlaskdjflk;sadjf;ajdsfl;jasdl;fjasd;fkj;asdkfj";
        cell.contentLabel.attributedText = [[NSAttributedString alloc]initWithString:@"asdfajdkfjakl;djfjasdjfla;sdkjfkasdjfjasdkjflkjalsdjfl;asdfjlas;dfjalk;sdjf;ljasdfj;asdjf;ajsdfljasl;dkfjlaskdjflk;sadjf;ajdsfl;jasdl;fjasd;fkj;asdkfj" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
        
    }else{
//        cell.contentLabel.text = @"content";
        cell.contentLabel.attributedText = [[NSAttributedString alloc]initWithString:@"content" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
    }
    
    return cell;
}



- (UITableView *)automaticFitCellTableView{
    if (!_automaticFitCellTableView) {
        _automaticFitCellTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _automaticFitCellTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _automaticFitCellTableView.estimatedRowHeight = 100.f;
        _automaticFitCellTableView.rowHeight = UITableViewAutomaticDimension;
        _automaticFitCellTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _automaticFitCellTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _automaticFitCellTableView.backgroundColor = [UIColor grayColor];
        _automaticFitCellTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _automaticFitCellTableView.separatorInset = UIEdgeInsetsZero;
        _automaticFitCellTableView.showsVerticalScrollIndicator = NO;
        [_automaticFitCellTableView registerClass:[WYWAutomaticFitTableViewCell class] forCellReuseIdentifier:kAutomaticFitTableViewCellReuseIDString];
    }
    return _automaticFitCellTableView;
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
