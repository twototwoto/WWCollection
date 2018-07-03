//
//  WYWLearnRuntimeViewController.m
//  WWCollection
//
//  Created by WYW on 2018/7/3.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100 (可以用于查看变量的类型)
//学习地址：https://www.jianshu.com/p/35971a7e8bf6

#import "WYWLearnRuntimeViewController.h"
#import "WYWLearnRuntimeObject.h"
#import "NSObject+WWAdd.h"

#import "NSObject+RuntimeWYWAdd.h"

@interface WYWLearnRuntimeViewController ()

@end

@implementation WYWLearnRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchIvarListTest];
}

#pragma mark - 获取实例变量测试 获取到私有 公有 实例变量 以及 公有 私有属性 注意没有分类中的属性
- (void)fetchIvarListTest{
    NSArray *ivarArr = [WYWLearnRuntimeObject wyw_fetchIvarList];
    //类似的我们还可以查看
    WWLog(@"%@",ivarArr);
    
}


/**
 * po [WYWLearnRuntimeObject wyw_fetchIvarList];
     <__NSArrayI 0x600000074140>(
     {
         ivarName = "_stringVariable1";
         type = "@\"NSString\"";
     },
     {
         ivarName = "_boolVariable2";
         type = B;
     },
     {
         ivarName = "_intergerVariable";
         type = "^q";
     },
     {
         ivarName = "_publicProperty";
         type = "@\"NSString\"";
     },
     {
         ivarName = "_privateProperty";
         type = "@\"NSString\"";
     }
     )
 */

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
