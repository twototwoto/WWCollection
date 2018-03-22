//
//  WYWLayerTableViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWLayerTableViewController.h"

#import "WYWLayerViewController.h"
#import "WYWTestViewController.h"

@interface WYWLayerTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end

//cell重用标识
static NSString* const kCellReuseIDStr = @"kCellReuseIDStr";

@implementation WYWLayerTableViewController{
    NSArray *_dataArr;
    //组数组
    NSArray *_sectionArr;
    //第二组的数组  （indexPath.secion 为1的 ）
    NSArray *_secondSectionArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initialOperation];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 初始化准备工作
- (void)initialOperation{
    self.navigationController.navigationBar.translucent = NO;
    //相关数据内容可以写到plist文件里边从里边取数据
    _dataArr = @[@"CAGradientLayer",@"CAShapeLayer",@"testCyclePRogressView"];
    _secondSectionArr = @[@"测试TextField"];
    _sectionArr = @[@"Layer",@"测试"];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _dataArr.count;
            break;
        case 1:
            return _secondSectionArr.count;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIDStr forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = _dataArr[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = _secondSectionArr[indexPath.row];
            break;
            
            
        default:
            break;
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [UILabel new];
    label.text = _sectionArr[section];
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WYWLayerViewController *layerVC = [WYWLayerViewController new];
        layerVC.title = _dataArr[indexPath.row];
        //    layerVC.titleString = _dataArr[indexPath.row];
        [self.navigationController pushViewController:layerVC animated:YES];
    }else if(indexPath.section == 1){
        WYWTestViewController *testVC = [WYWTestViewController new];
        testVC.title = _secondSectionArr[indexPath.row];
        [self.navigationController pushViewController:testVC animated:YES];
    }
    
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
