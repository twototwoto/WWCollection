//
//  WYWLearnRunLoopViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/28.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWLearnRunLoopViewController.h"

#import "WWThread.h"

@interface WYWLearnRunLoopViewController ()
@property (nonatomic,strong) WWThread *thread;
@end

@implementation WYWLearnRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self runLoopTest];
    [self threadLiveTest];
//    [self threadTest];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(subThreadLiveOperation) onThread:self.thread withObject:nil waitUntilDone:NO];
}

/**
 子线程启动后 启动runloop
 */
- (void)subThreadEntryPort{
    @autoreleasepool{
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        WWLog(@"启动RunLoop前%@",runLoop.currentMode);
        [runLoop run];
        //奇怪下边的语句不会打印 不清楚是因为什么
        WWLog(@"启动RunLoop后%@",runLoop.currentMode);
    }
}

#pragma mark - 线程保活测试
- (void)threadLiveTest{
    WWThread *thread = [[WWThread alloc]initWithTarget:self selector:@selector(subThreadEntryPort) object:nil];
    [thread setName:@"WWThread"];
    [thread start];
    self.thread = thread;
}

#pragma mark - 子线程保活操作
- (void)subThreadLiveOperation{
    WWLog(@"启动RunLoop后%@",[[NSRunLoop currentRunLoop]currentMode]);
    WWLog(@"子线程任务开始 %@",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.f];
    WWLog(@"子线程结束%@",[NSThread currentThread]);
//    [NSThread sleepForTimeInterval:3.f];
//    WWLog(@"子线程结束%@",[NSThread currentThread]);
}

/**
 * 01在点击屏幕前的输出结果：
    * 2018-06-28 23:11:17.264958+0800 WWCollection[14713:594193] -[WYWLearnRunLoopViewController subThreadEntryPort] [Line 38] 启动RunLoop前(null)
        * 输出启动RunLoop前
 * 02. 点击屏幕后
     2018-06-28 23:13:17.890276+0800 WWCollection[14713:594193] -[WYWLearnRunLoopViewController subThreadLiveOperation] [Line 55] 启动RunLoop后kCFRunLoopDefaultMode
     2018-06-28 23:13:17.890584+0800 WWCollection[14713:594193] -[WYWLearnRunLoopViewController subThreadLiveOperation] [Line 56] 子线程任务开始 <WWThread: 0x600000276500>{number = 4, name = WWThread}
     2018-06-28 23:13:20.894393+0800 WWCollection[14713:594193] -[WYWLearnRunLoopViewController subThreadLiveOperation] [Line 58] 子线程结束<WWThread: 0x600000276500>{number = 4, name = WWThread}
 * 03. 再次点击屏幕后
     2018-06-28 23:14:31.844276+0800 WWCollection[14713:594193] -[WYWLearnRunLoopViewController subThreadLiveOperation] [Line 55] 启动RunLoop后kCFRunLoopDefaultMode
     2018-06-28 23:14:31.844520+0800 WWCollection[14713:594193] -[WYWLearnRunLoopViewController subThreadLiveOperation] [Line 56] 子线程任务开始 <WWThread: 0x600000276500>{number = 4, name = WWThread}
     2018-06-28 23:14:34.845473+0800 WWCollection[14713:594193] -[WYWLearnRunLoopViewController subThreadLiveOperation] [Line 58] 子线程结束<WWThread: 0x600000276500>{number = 4, name = WWThread}
 看线程的名字 和 地址可以发现 从始至终用的是一个线程

 */


#pragma mark - 线程测试
- (void)threadTest{
    WWThread *thread = [[WWThread alloc]initWithTarget:self selector:@selector(subThreadOperation) object:nil];
    [thread start];
}

#pragma mark - 子线程操作
- (void)subThreadOperation{
    @autoreleasepool{
        WWLog(@"%@ 子线程任务开始",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.f];
        WWLog(@"%@ 子线程任务结束",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.f];
        WWLog(@"%@ 子线程任务结束",[NSThread currentThread]);
    }
    /*
     和sleep多久无关 和sleep几次无关
     2018-06-28 22:41:54.392204+0800 WWCollection[13619:555010] -[WYWLearnRunLoopViewController subThreadOperation] [Line 33] <WWThread: 0x60c000073f40>{number = 4, name = (null)} 子线程任务开始
     2018-06-28 22:41:57.396216+0800 WWCollection[13619:555010] -[WYWLearnRunLoopViewController subThreadOperation] [Line 35] <WWThread: 0x60c000073f40>{number = 4, name = (null)} 子线程任务结束
     2018-06-28 22:42:00.396691+0800 WWCollection[13619:555010] -[WYWLearnRunLoopViewController subThreadOperation] [Line 37] <WWThread: 0x60c000073f40>{number = 4, name = (null)} 子线程任务结束
     2018-06-28 22:42:00.397281+0800 WWCollection[13619:555010] -[WWThread dealloc] [Line 13]
     */
}

- (void)runLoopTest{
//    CFRunLoopStop(<#CFRunLoopRef rl#>) 手动结束RunLoop
//    CFRunLoopRun(); 开启RunLoop
    
    
/**
 * 关于NSRunLoop：
    * https://www.jianshu.com/p/4d5b6fc33519
    * https://www.jianshu.com/p/902741bcf707
    * https://www.jianshu.com/p/902741bcf707
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
