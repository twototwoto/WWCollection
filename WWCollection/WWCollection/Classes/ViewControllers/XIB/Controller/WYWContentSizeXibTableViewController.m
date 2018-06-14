//
//  WYWContentSizeXibTableViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/14.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWContentSizeXibTableViewController.h"
#import "WYWTableViewCellXib.h"

@interface WYWContentSizeXibTableViewController ()

@end

@implementation WYWContentSizeXibTableViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    self.tableView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200.f)];
//    UIView *tableHeadView = [[UIView alloc]init];
    tableHeadView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = tableHeadView;
//    [tableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.right.equalTo(self.view).mas_offset(-20.f);
//        make.height.mas_equalTo(200.f);
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionHeaderV = [UIView new];
    sectionHeaderV.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.f green:(arc4random() % 256)/255.f blue:(arc4random() % 256)/255.f alpha:1.0f];
    return sectionHeaderV;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WYWTableViewCellXib *xibCell = [tableView dequeueReusableCellWithIdentifier:WYWTableViewCellXibReuseID];
    if (!xibCell) {
        xibCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([WYWTableViewCellXib class]) owner:nil options:nil] firstObject];
        
    }
    return xibCell;
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
