//
//  WYWCustomResultViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/25.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWCustomResultViewController.h"
#import "WYWNavSearchResultViewController.h"


@interface WYWCustomResultViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate>
@property (nonatomic,strong) UISearchController *searchVC;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation WYWCustomResultViewController

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    _searchVC.active = YES;
//    [_searchVC.searchBar becomeFirstResponder];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.searchVC.active = YES;
}


- (void)setupUI{
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setupTableViewSearchBar];
}



- (void)setupTableViewSearchBar{
    WYWNavSearchResultViewController *navSearchResultVC = [WYWNavSearchResultViewController new];
    navSearchResultVC.view.backgroundColor = [UIColor yellowColor];
    
    _searchVC = [[UISearchController alloc]initWithSearchResultsController:navSearchResultVC];
    _searchVC.view.backgroundColor = [UIColor redColor];
    _searchVC.delegate = self;
    _searchVC.searchBar.delegate = navSearchResultVC;
    [_searchVC.searchBar becomeFirstResponder];
    //此处是可以设置searchBar.delegate = self
    //如果是点击取消的时候就正常地 dismiss掉当前的控制器
    
    //    _searchVC.hidesNavigationBarDuringPresentation = YES;
    
    //    _searchVC.hidesBottomBarWhenPushed = YES;
    //    navSearchResultVC.hidesBottomBarWhenPushed = YES;
    //上述代码无效说明UISearchController 的展示的形式不是使用的push的方式
    
    
    //    searchVC.searchResultsUpdater = self;
    _searchVC.searchResultsUpdater = navSearchResultVC;
    _searchVC.searchBar.placeholder = @"搜索";
    _searchVC.searchBar.backgroundColor = [UIColor redColor];
    _searchVC.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200.f);
    //    self.navigationItem.titleView = _searchVC.searchBar;
    //    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = _searchVC.searchBar;
    _searchVC.searchBar.backgroundImage = [UIImage new];
    //    _searchVC.searchBar.backgroundColor = [UIColor yellowColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchControllerDelegate
- (void)didPresentSearchController:(UISearchController *)searchController{
    [searchController.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDelegate------

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
        cell.backgroundColor = [UIColor blueColor];
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
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
