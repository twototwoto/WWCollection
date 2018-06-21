//
//  TestMJTableViewController.m
//  WWCollection
//
//  Created by WYW on 2018/4/28.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "TestMJTableViewController.h"

#import <MJRefresh/MJRefreshHeader.h>
#import <MJRefresh/MJRefreshFooter.h>
#import <MJRefresh/MJRefreshNormalHeader.h>
#import <YYCache/YYCache.h>

#import "TestCycleAViewController.h"
#import "TestCycleBViewController.h"


@interface TestMJTableViewController ()

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,copy) NSString *str;
@property (nonatomic,copy) void(^block)(NSString *str);

@end

@implementation TestMJTableViewController

- (void)testCycleVC{
//    TestCycleAViewController *aVC = [TestCycleAViewController new];
//    TestCycleBViewController *bvc = [TestCycleBViewController new];
//    [aVC addChildViewController:bvc];
//    [bvc addChildViewController:aVC];
    TestCycleAViewController *cycleAVC = [TestCycleAViewController new];
    [self.navigationController pushViewController:cycleAVC animated:YES];
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self testCycleVC];
}

- (void)testChangePlistData{
    NSMutableArray *arrM = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"locaModePlist" ofType:@"plist"]]mutableCopy];
    WWLog(@"%@",arrM);
    arrM[1] = @(YES);
    [arrM writeToFile:[[NSBundle mainBundle]pathForResource:@"locaModePlist" ofType:@"plist"] atomically:YES];
    WWLog(@"%@",arrM);
    arrM = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"locaModePlist" ofType:@"plist"]]mutableCopy];
    /*
     其中plist文件中的值
     如果使用模拟器则可以修改
     如果使用真机的话 修改失败
     */
    
    WWLog(@"%@",arrM);
    //NSDocumentDirectory  NSDocumentationDirectory 注意他们两个是不同的 真机上边看不到文件了
    /*
     如果是写成 NSDocumentationDirectory 生成的文件在Library下的Documentation下 像这种情况下如果想要生成在相应的路径下创建文件 那么需要先有了Documentation 才能够正常地创建文件 其中文件中的内容
     如果写成NSDocumentDirectory 生成的文件在Documents 下
     
     */
    NSString *plistPath =  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"mode.plist"];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
        [[NSFileManager defaultManager]createFileAtPath:plistPath contents:nil attributes:nil];
        //        [[NSFileManager defaultManager]createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [arrM writeToFile:plistPath atomically:YES];
    arrM = [[[NSArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    WWLog(@"%@",arrM);
    arrM[2] = @YES;
    [arrM writeToFile:plistPath atomically:YES];
    arrM = [[[NSArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    WWLog(@"%@",arrM);
    
    /*
     上述的方式
     NSString *errorTag = @"Error: ";
     NSString *errorString = @"premature end of file.";
     NSString *errorMessage = [errorTag stringByAppendingString:errorString];
     produces the string “Error: premature end of file.”.
     */
    
    NSString *str = NSHomeDirectory();
    str = [str stringByAppendingPathComponent:@"mode.plist"];
    WWLog(@"%@--%@",plistPath,str);
}

- (void)testYYCache{
    YYCache *cache = [YYCache cacheWithName:@"cacheName"];
    //NSCache 虽然提供了name属性 可是却没有看见根据name获取到相应的cache的方法
    
    NSCache *cachee;
    cachee.name;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    [self testMJ];
    [self testYYCache];
    return;
    [self testCycleVC];
    
    
    /*
    __weak typeof(self) weakSelf = self;
    self.block = ^(NSString *str) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //使用weakstrong的方式确实是一种解决方式
        strongSelf.str = str;
        WWLog(@"%@",strongSelf.str);
    };
    self.block(@"strstr");
    */
    
//    return;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    [self testMJ];
    WWLog(@"");
//    [self testCycleUse];
    //但是有调用dealloc确是只能够说明当前的self释放了，却不能够说明有没有循环引用 像这个testCycleUse 调用的时候仍然会调用dealloc但是还是有循环引用
}

- (void)dealloc{
    //通过dealloc来查看是否有self捕获
    WWLog(@"dealloc");
}

- (void)testCycleUse{
    NSMutableArray *arrA = [NSMutableArray array];
    NSMutableArray *arrBM = [NSMutableArray array];
    [arrBM addObject:arrA];
    [arrA addObject:arrBM];
}

- (void)testMJ{
    //使用weak strong的方式才能够正常的释放掉 这部分的内容 所以说之前的KVO的时候可能也是因为当时的那个控制器没有正常的释放造成的一定的影响导致的崩溃
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ((arc4random() % 10)%2) {
                strongSelf.dataArray = @[@"000",@"789",@"123"];
//                self.dataArray = @[@"000",@"789",@"123"];
            }else{
                strongSelf.dataArray = @[@"789",@"123",@"000"];
//                self.dataArray = @[@"789",@"123",@"000"];
            }
            [strongSelf.tableView reloadData];
            [strongSelf.tableView.mj_header endRefreshing];
//            [self.tableView reloadData];
//            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    //隐藏掉最后刷新时间
//    ((MJRefreshStateHeader *)self.tableView.mj_header).lastUpdatedTimeLabel.hidden = YES;
//    ((MJRefreshStateHeader *)self.tableView.mj_header).stateLabel.hidden = YES;
    
    //修改最后刷新时间
    ((MJRefreshStateHeader *)(self.tableView.mj_header)).lastUpdatedTimeText = ^NSString *(NSDate *lastUpdatedTime) {
        return [NSString stringWithFormat:@"%@",lastUpdatedTime];
    };
    
//    self.tableView.mj_header = header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self testCycleVC];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    WWLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"123",@"456",@"789",@"000"];
        
    }
    return _dataArray;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
