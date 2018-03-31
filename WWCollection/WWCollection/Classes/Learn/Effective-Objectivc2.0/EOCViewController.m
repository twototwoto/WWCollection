//
//  EOCViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/31.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "EOCViewController.h"

#import "EOCClassB.h"
#import "EOCSubClass.h"


@interface EOCViewController ()

@end

@implementation EOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testLoadInitialize];
    
}

- (void)testLoadInitialize{
    
//    [EOCClassB new];
//    [EOCClassB new];
//    [EOCClassB new];
    [EOCSubClass new];
    [EOCSubClass new];
    [EOCSubClass new];
    
    /*
     测试过程是EOCClassB 继承自 EOCClassA
     
     测试情景是：Xcode9.2 iPhone6 EOCSubClass 继承自 EOCBaseClass
     +[EOCBaseClass initialize] [Line 17] EOCBaseClass
     +[EOCBaseClass load] [Line 13] EOCBaseClass
     +[EOCSubClass initialize] [Line 17] EOCSubClass
     +[EOCSubClass load] [Line 13] EOCSubClass
     +[NSObject(WWAdd) load] [Line 13] NSObject
     看起来每次initialize的执行顺序要早于load
     
     
     
     如果子类 父类 分类 都实现了load方法那么load方法调用顺序是
     父类 -> 子类 -> 分类 load
     +[EOCClassA load] [Line 13]
     +[EOCClassB load] [Line 14] EOCClassB
     +[NSObject(WWAdd) load] [Line 13] NSObject
     
     
     如果是子类父类
     输出内容
     +[EOCClassA load] [Line 13]
     +[EOCClassB load] [Line 14] EOCClassB
     
     如果子类没有实现load方法
     也会调用父类的相关方法 +[EOCClassA load] [Line 13] 这一点和参考书上说的不同
     
     
     initialize 方法调用顺序
     父类->子类
     +[EOCClassA initialize] [Line 17] EOCClassA
     +[EOCClassB initialize] [Line 18] EOCClassB
     
     
     load 和 initialize 都是调用一次
     
     测试来看她们都是正常的继承
        如果是子类先调用父类的方法再执行自己的实现的方法
        如果是子类没实现相关方法 会执行父类相关方法
        load方法执行顺序 父类 -> 子类 -> 分类
        initialize 执行顺序 父类 -> 子类
     从测试上来看加载顺序上来说 load方法要早于initialize方法
     load方法是应用一启动 不管有没有调用相关的类 就开始调用load方法了 所以这可能也是书上说她处于脆弱状态的原因吧
     initialize 方法只有在被实例化的之前被调用
     
     */
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
