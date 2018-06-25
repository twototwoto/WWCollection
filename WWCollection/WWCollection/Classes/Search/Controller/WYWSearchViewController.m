//
//  WYWSearchViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/22.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWSearchViewController.h"
#import "WYWNavSearchResultViewController.h"

#import "WYWSearchBarTitleView.h"

#import "WYWCustomResultViewController.h"

@interface WYWSearchViewController ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate>
@property (nonatomic,strong) UISearchController *searchVC;

@property (nonatomic,strong) UITableView *tableView;
//崩溃测试
//@property (nonatomic,copy) NSMutableArray *arrM;

@end

@implementation WYWSearchViewController{
    UISearchController *_searchC;
}

//- (void)viewDidLayoutSubviews{
//    _searchVC.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200.f);
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    _searchVC.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200.f);
//}


//- (void)didPresentSearchController:(UISearchController *)searchController{
////    [self.view addSubview:self.searchVC.searchBar];
//    self.searchVC.searchBar.frame = CGRectMake(0, 100, 375, 100);
//}


//- (void)viewDidLayoutSubviews {
//    
//    if(self.searchVC.active) {
//        self.searchVC.searchBar.frame = CGRectMake(self.searchVC.searchBar.frame.origin.x, 20, self.searchVC.searchBar.frame.size.width, 44.0);
//        [UIView animateWithDuration:0.1 animations:^{
//            [self.view layoutIfNeeded];
//            [self.searchVC.searchBar layoutIfNeeded];
//        }];
//    }
//}


- (NSString *)transformToPinyin:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    /*
     下边这里相当于 我已经有了一个 数组 如@[@"si",@"fang",@"iOS"]
     想要按照顺序分组拼接到一起
     si#fangiOS sifang#iOS
     其中三个 以2个一组 另外的一个自成一组的形式
     其中的一个count是用于记录第几个的
     
     */
    NSInteger count = 0;
    for (NSInteger  i = 0; i < pinyinArray.count; i++)
    {
        for(NSInteger j = 0; j < pinyinArray.count;j++)
        {
            if (j == count) {
                [allString appendString:@"#"];
                //区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[j]];
        }
        
        [allString appendString:@","];
        count ++;
    }
    
    NSMutableString *perFirstStr = [NSMutableString new];
    //拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [perFirstStr appendString:  [s substringToIndex:1]];
        }
    }
    //拼接 划分开的字符串 的每个首字母
    [allString appendFormat:@"#%@",perFirstStr];
    
    //拼接上最原始传入的字符串
    [allString appendFormat:@",#%@",aString];
    return allString;
}


- (void)testNSScaner{
    [NSScanner scannerWithString:@""];
    
    NSInteger value = 2;
    BOOL exist = [[NSScanner scannerWithString:@"ac"]scanInteger:&value];
    BOOL notExist = [[NSScanner scannerWithString:@"2220"]scanInteger:&value];
    NSScanner *scan = [NSScanner scannerWithString:@"ad"];
    
    [scan isAtEnd];//可以用于判断是否是扫描的最后一个了
    NSScanner *scane = [NSScanner scannerWithString:@"1"];
    NSInteger valuee;
    //下列式子 用于判断一个字符是否是NSInteger类型的数字
    ([scane scanInteger:&valuee] && [scane isAtEnd]);
    /*isAtEnd 适用于检测当前的scan中是否还有数据 如果都scan完了 就是没数据了 否则就是还有数据 scan 有点类似于是一个队列 这个队列里边放着内容 一个一个的扫描 当扫描完了的时候scan isAtEnd 即为true了
     
     Flag that indicates whether the receiver has exhausted all significant characters.
     
     当有数据的时候 scanInteger就能够扫描出来数据 否则就不能
     po scane.string
     1
     
     (lldb) po [scane scanInteger:&value]
     YES
     
     (lldb) po [scane scanInteger:&value]
     NO
     如果能够访问到数据的话就返回YES否则为NO
     */
    [scane scanInteger:&valuee]&&[scane isAtEnd] ;
    WWLog(@"%zd-%zd",exist,notExist);
    //输出结果
    /*注意这个&value 这种形式
     - (BOOL)scanInteger:(nullable NSInteger *)result
     其中result 的类型是NSInteger * 可能很久没有写过指向常量的指针这种形式 看到这种会有些不习惯
     https://stackoverflow.com/questions/1014053/why-dont-i-declare-nsinteger-with-a
     
     //相关：
     po [NSScanner scannerWithString:@"acd"].string
     acd
     */
    
    NSString *testStr = @"abc\ndef\n";
    NSScanner *scannerNextLine = [NSScanner scannerWithString:testStr];
    [scannerNextLine scanCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:NULL];
    
    
    NSString *recordString = @"\t\t\tHello\t\tGoodbye\tHello";
        // 1 2 3456789 1012345678 90123
        //0102034567890A0BCDEF
    NSScanner* theScanner = [NSScanner scannerWithString: recordString];
    theScanner.charactersToBeSkipped = nil;
    
    NSRange asciiTabRange;
    asciiTabRange.location = 0x09;
    asciiTabRange.length   = 1;
    NSCharacterSet* asciiTab = [NSCharacterSet characterSetWithRange: asciiTabRange];
    
    NSString *tabString;
    unsigned long indexOfFirstTabInRun = 0;
    unsigned long tabsInRun = 0;
    
    while (!theScanner.isAtEnd) {
        indexOfFirstTabInRun = (unsigned long)theScanner.scanLocation;
        if ([theScanner scanCharactersFromSet: asciiTab intoString: &tabString]) {
            tabsInRun = (unsigned long) theScanner.scanLocation - indexOfFirstTabInRun;
            WWLog(@"tabCount: %lu - starting at index %lu", tabsInRun, indexOfFirstTabInRun);
        } else {
            [theScanner scanCharactersFromSet:asciiTab.invertedSet intoString:nil];
        }
    }
}

- (void)setupStatusBarStyle{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStatusBarStyle];
    
    [self setupCustomViewNavSearchBar];
    return;
    [self setupNavSearchBar];
    
    return;
    /*
     [self.view addSubview:self.tableView];
     self.tableView.frame = self.view.bounds;
     self.tableView.dataSource = self;
     self.tableView.delegate = self;
     
     [self setupTableViewSearchBar];
     */
   
    [self testNSScaner];
    NSString *abcStr = [self transformToPinyin:@"abc"];
    NSString *numStr = [self transformToPinyin:@"123"];
    NSString *numAbcStr = [self transformToPinyin:@"123Abc"];
    NSString *numAbcCharacterStr = [self transformToPinyin:@"四方iOS"];
    [numAbcStr rangeOfString:@"aa"];
    NSStringCompareOptions option;
    [numAbcStr rangeOfString:@"a" options:NSDiacriticInsensitiveSearch];
    
    /*
     NSString *numAbcCharacterStr = [self transformToPinyin:@"四方iOS"];
     
     输出结果：
     #sifangiOS,si#fangiOS,sifang#iOS,#sfi,#四方iOS
     */
    
    WWLog(@"%@--%@--%@--%@",abcStr,numStr,numAbcStr,numAbcCharacterStr);
    //崩溃测试
//    self.arrM = [NSMutableArray array];
//    [self.arrM addObject:@1];
//    WWLog(@"%@",self.arrM);
    /*至于为什么这个会崩溃
     是因为 copy修饰的属性 在执行setter的方法的时候 有一个先release 后 copy的操作 就是说执行了深拷贝 虽然右边是NSMutableArray 但是执行了setter方法后 左边所得到的赋值并不是期望的了
     而strong修饰符 是做的一个先release 后retain的操作 就是说引用计数加一了 但是还是原来的对象地址
     
     */
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.translucent = NO;
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    _searchVC.searchBar.backgroundImage = [UIImage new];
//    _searchVC.searchBar.backgroundColor = [UIColor yellowColor];
//}

- (void)setupTableViewSearchBar{
    WYWNavSearchResultViewController *navSearchResultVC = [WYWNavSearchResultViewController new];
    navSearchResultVC.view.backgroundColor = [UIColor yellowColor];
    
    _searchVC = [[UISearchController alloc]initWithSearchResultsController:navSearchResultVC];
    _searchVC.view.backgroundColor = [UIColor redColor];
    _searchVC.delegate = self;
    _searchVC.searchBar.delegate = navSearchResultVC;
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

- (void)setupCustomViewNavSearchBar{
    //CGRectGetWidth(self.view.frame)
    self.navigationController.navigationBar.translucent = YES;
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右侧" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick:)];
    
    WYWSearchBarTitleView *titleView = [[WYWSearchBarTitleView alloc] initWithFrame:CGRectMake(15.f, 0, 310.f, 28.f)];
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 310.f, 28.f)];
    //其实使用自定义类 并没有什么用
    titleView.layer.cornerRadius = 14.f;
    titleView.backgroundColor = [UIColor colorWithRed:232.f/255.f green:232.0f/255.f blue:232.f/255.f alpha:1.0f];
    
//    _searchC = [[UISearchController alloc]initWithSearchResultsController:nil];
//    _searchC.view.backgroundColor = [UIColor redColor];
//    self.definesPresentationContext = YES;
//    UISearchBar *searchBar = _searchC.searchBar;
//    searchBar.frame = titleView.bounds;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
    
    searchBar.frame = CGRectMake(15.f, 0, 310.f, 28.f);
    searchBar.delegate = self;
    searchBar.placeholder = @"自定义searchBar";
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    if (searchTextField) {
        searchTextField.backgroundColor = [UIColor colorWithRed:232.f/255.f green:232.0f/255.f blue:232.f/255.f alpha:1.0f];
    }
    [titleView addSubview:searchBar];
    
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
//    self.navigationItem.titleView = titleView;
    self.navigationItem.titleView = searchBar;
    /*
    [self.navigationController.navigationBar addSubview:titleView];

    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationController.navigationBar).mas_offset(15.f);
        make.centerY.equalTo(self.navigationController.navigationBar);
//        make.right.equalTo(self.navigationController.navigationBar).mas_offset(-50.f);
        make.width.mas_equalTo(310.f);
        make.height.mas_equalTo(28.f);
        
    }];
     */
    
    
    /*
     导航栏上的titleView 在布局方面还是不大好控制的
     感觉想更好的控制位置尺寸等 内容还是使用 UITableView的tableHeaderView 比较好控制
     */
    
   
    WWLog(@"");
    
}


- (void)rightBarButtonItemClick:(id)sender{
    
}


- (void)setupNavSearchBar{
    
//    WYWSearchResultViewController *searchResultVC = [WYWSearchResultViewController new];
    self.navigationController.navigationBar.translucent = YES;
    WYWNavSearchResultViewController *navSearchResultVC = [WYWNavSearchResultViewController new];
//    UISearchController *searchVC 需要使用全局的UISearchController
    _searchVC = [[UISearchController alloc]initWithSearchResultsController:navSearchResultVC];
    _searchVC.delegate = self;
    _searchVC.view.backgroundColor = [UIColor redColor];
//    searchVC.searchResultsUpdater = self;
    _searchVC.searchResultsUpdater = navSearchResultVC;
    _searchVC.searchBar.placeholder = @"搜索";
//    self.navigationItem.titleView = _searchVC.searchBar;
    
    UIView *customTitleV = [UIView new];
    customTitleV.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, CGRectGetWidth(self.view.frame), self.navigationController.navigationBar.frame.size.height);
    customTitleV.backgroundColor = [UIColor yellowColor];
    _searchVC.searchBar.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, CGRectGetWidth(self.view.frame), self.navigationController.navigationBar.frame.size.height);
    [customTitleV addSubview:_searchVC.searchBar];
    _searchVC.searchBar.frame = customTitleV.bounds;
//    [self.navigationItem.titleView addSubview:customTitleV];
    self.navigationItem.titleView = customTitleV;
    //不论是直接设置searchBar 还是设置customTitleV 都是会在点击后消失
//    _searchVC.hidesNavigationBarDuringPresentation = YES;
    self.definesPresentationContext = YES;
}


- (void)setupSearchBar{
    //注意：这句代码写在这里是因为不写的话会导致下边的textField为空 看来是懒加载
    
    /*
    self.testSearchController.searchBar.tintColor = WWbackgroundGrayColor;;
    self.testSearchController.searchBar.placeholder = @"";
    self.testSearchController.searchBar.layer.cornerRadius = WW_PX_Width(28.f);
    self.testSearchController.searchBar.backgroundColor = [UIColor colorWithRed:242.0/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
    
    UITextField *searchTextField = [self.testSearchController.searchBar valueForKey:@"_searchField"];
    searchTextField.textColor = [UIColor blackColor];
    searchTextField.backgroundColor = [UIColor colorWithRed:242.0/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
    
    NSDictionary *attriDict = @{NSForegroundColorAttributeName:[UIColor colorWithRed:153.0/255.f green:153.0/255.0f blue:153.0f/255.0f alpha:1.0f]};
    NSAttributedString *attriStr = [[NSAttributedString alloc]initWithString:@"  搜索  " attributes:attriDict];
    searchTextField.attributedPlaceholder = attriStr;
    
    UIToolbar *cancelToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, WW_WIDTH, WW_PX_Height(60.f))];
    [cancelToolBar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //取消
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    //    cancelBarButtonItem.tintColor = [UIColor whiteColor];
    
    [cancelToolBar setItems:@[spaceBarButtonItem,cancelBarButtonItem]];
    self.testSearchController.searchBar.inputAccessoryView = cancelToolBar;
    //    self.testSearchController.searchBar.frame = CGRectMake(0, WW_Status_Nav_Height, WW_WIDTH, WW_PX_Height(56.f));
     */
}

- (void)presentToSearchController{
    /*
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self showViewController:vc sender:nil];
    [self showDetailViewController:vc sender:nil];
     */
    WYWCustomResultViewController *customResultVC = [WYWCustomResultViewController new];
    [self showDetailViewController:customResultVC sender:nil];

}

#pragma mark - Delegate --

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self presentToSearchController];
    return NO;
    /*
     其实只是简单地设置searchBar到titleView 那么不会出现searchBar消失的情况
     如果是以
     [[UISearchController alloc] initWithSearchResultsController:resultsController];
     这种形式创建的UISearchController的searchBar添加到导航栏的情况下 searchBar就确实会消失掉
     
     其实如果是分析喜马拉雅 点击searchBar后的效果的话可以 视觉上看起来我感觉他们不是用的UISearchResultController的方式 他们应该是用的简单地searchBar设置到titleView 之后在searchBar成为第一响应者的时候(注意这个时候不弹出键盘) modal出来的控制器 然后在新的控制器中进行的搜索相关的操作
     而且modal出来新的控制器后 可以设置新的界面的 UISearchController* 类型的对象_searC 的active 强制使得searchResultController出现
     或者是也得让键盘先弹出 类似的办法
     [_searchVC.searchBar becomeFirstResponder];
     */
}

//学习网址：https://blog.csdn.net/seiven009/article/details/52127782
- (void)willDismissSearchController:(UISearchController *)searchController{
    ((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)willPresentSearchController:(UISearchController *)searchController{
    
    ((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
}



#pragma mark - Delegate------

//
//#pragma mark - UISearchBarDelegate --
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    //点击取消的时候还需要再次展示出来内容
//     ((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).tabBar.hidden = NO;
//}

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
