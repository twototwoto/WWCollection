//
//  ViewController.m
//  WWCollection
//
//  Created by 王永旺永旺 on 2017/11/30.
//  Copyright © 2017年 ITCoderW. All rights reserved.
//

#import "ViewController.h"

#import "WYWSearchResultViewController.h"
#import "UINavigationBar+WWAdd.h"

#define PYSEARCH_MARGIN 10
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>

/**主tableView*/
@property (nonatomic,strong) UITableView *mainTableView;

/**搜索框*/
@property (nonatomic,strong) UISearchBar *searchBar;
@end

static NSString *kCellReuseIDStr = @"kCellReuseIDStr";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏的背景色
    [self.navigationController.navigationBar wyw_setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.1f]];
    
    [self testSearchController];
//    [self.view addSubview:self.mainTableView];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}




#pragma mark - 测试搜索控制器相关的内容
- (void)testSearchController{
    
    UISearchController *searchC = [[UISearchController alloc]initWithSearchResultsController:[WYWSearchResultViewController new]];
    searchC.searchResultsUpdater = self;
    
    //可以修改UISearchBar的位置尺寸 那也得在父视图上才能够响应事件处理
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.delegate = self;
//    searchBar.frame = CGRectMake(100, 0, 100, 44);
    //设置占位文字
    searchBar.placeholder = @"搜索 某时 某地 某人 某事 ";
//     searchBar.backgroundColor = [UIColor redColor]; //大背景色
    //searchBar的背景色
    searchBar.barTintColor = [UIColor redColor];
    //修改右侧取消的文字的颜色
    searchBar.tintColor = [UIColor blackColor];
    
    
    //方法一：简单的设置方法右侧的 "Cancel" 改为 "取消" 可以使用的办法 在info.plist中Localization native development region 中选择China 还可以通过获取到右侧的私有属性的方式来进行
    //参考网址：https://www.jianshu.com/p/328330e88be6
    //http://blog.csdn.net/zhuming3834/article/details/51111763
    
    //方法二：改变右侧的取消的文字 在这个位置 在下边设置需要一直都展示着取消 否则的话会造成取消文字又改变回去的问题 或者是在开始编辑的代理方法中
//    searchBar.showsCancelButton = YES;
//    for (UIView *subView in [searchBar.subviews objectAtIndex:0].subviews) {
//        if ([subView isMemberOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
//
//            UIButton *cancelBtn = (UIButton *)subView;
//            [cancelBtn setTitle:@"取消取消" forState: UIControlStateNormal];
//        }
//    }
    
    //获取到私有属性 并且对相关的值进行修改
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    //改变searchBar的输入的文字颜色
    searchTextField.textColor = [UIColor yellowColor];
    
    UIImage *img = [UIImage imageNamed:@"slice2"];
    //修改搜索框的背景图片
    [searchBar setSearchFieldBackgroundImage:img forState:UIControlStateNormal];
//    [searchBar setBackgroundImage:img forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
//    searchBar.frame = self.navigationItem.titleView.frame;
    UIView *titleView = [UIView new];
    titleView.frame = self.navigationController.navigationBar.bounds;
    //下边的修改方式也有效
//    titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 24);
    
    searchBar.frame = titleView.bounds;
    [titleView addSubview:searchBar];
    
    self.navigationItem.titleView = titleView;
    //下边的设置方式会导致搜索框底部偏出导航栏的问题 要用上边的方式
//    self.navigationItem.titleView = searchBar;
    //而且如果是设置成了添加的titleView的方式 改下边的内容才会生效
//    searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44.f);
//    searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 24);
    
    _searchBar = searchBar;
    
    //可以修改搜索放大镜为其他的图片或者是修改为无图https://www.jianshu.com/p/15de605c1c4f
    [searchBar setImage:[UIImage new] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    btn.titleLabel.text = @"左侧";
    [btn setTitle:@"左侧" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setTitle:@"右侧" forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor blueColor];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView: btn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    //关于prompt 这个还不了解:https://www.jianshu.com/p/328330e88be6
    searchBar.prompt = @"Prompt";
}




#pragma mark - UISearchbarDeelgate相关内容----------
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    return YES;
}                     // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    //只不过这里的问题可能出现对 self.navigationItem.rightBarButtonItem有影响 导致它展示不出来了
    for (UIView *subView in [_searchBar.subviews objectAtIndex:0].subviews) {
        if ([subView isMemberOfClass:[NSClassFromString(@"UINavigationButton") class]]) {

            UIButton *cancelBtn = (UIButton *)subView;
            [cancelBtn setTitle:@"取消取消" forState: UIControlStateNormal];
        }
    }
    
}                   // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{

    return YES;
}                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}                      // called when text ends editing
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}   // called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0){
    return YES;
    
}// called before text changes

#pragma mark - 搜索框的点击取消Delegate-------
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"搜索");
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // called when search results button pressed
{
    //当点击搜索的时候调用

}

#pragma mark - UISearchControllerDelegate-------
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"%@",searchController);
}




#pragma mark - UITableViewDelegate --------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)
        return 300.0f;
    return 100.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headV = [UIView new];
    headV.backgroundColor = [UIColor redColor];
    return headV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIDStr];
    return cell;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorInset = UIEdgeInsetsZero;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReuseIDStr];
        _mainTableView.tableHeaderView.frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
        
    }
    return _mainTableView;
}

- (void)wwReadMe{
    /*
     style为UITableViewStylePlain的UITableView组头滚动过程中默认悬停
     style为UITableViewGrouped的UITableView组头默认不会悬停可以自己设置
     
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
