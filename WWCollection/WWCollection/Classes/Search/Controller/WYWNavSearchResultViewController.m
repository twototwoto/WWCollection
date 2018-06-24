//
//  WYWNavSearchResultViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/22.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWNavSearchResultViewController.h"

@interface WYWNavSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation WYWNavSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
}


#pragma mark - <UISearchResultsUpdating>
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//    [self.tableView reloadData];
//    ((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).tabBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
//    [[UIApplication sharedApplication]performSelector:@selector(endEditing:) withObject:nil afterDelay:0];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //执行数据搜索
    WWLog(@"执行数据搜索");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseID"];
    }
    cell.backgroundColor = WWRandomColor;
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor purpleColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
    }
    return _tableView;
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
