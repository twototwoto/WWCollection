//
//  WYWTestViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/22.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWTestViewController.h"

@interface WYWTestViewController ()

@end

@implementation WYWTestViewController{
    UITextField *_textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self testTextField];
    
    [self testCheckBox];
    [self testKVO];

}

- (void)dealloc{
    /*对于KVO没有正常地添加的情况下 removeObserver的时候的问题的一个： Cannot remove an observer <WYWTestViewController 0x7f8cfba05af0> for the key path "kvo" from <WYWTestViewController 0x7f8cfba05af0> because it is not registered as an observer.
     https://www.jianshu.com/p/f339d4f59ce9
     */
    
    @try{
        [self removeObserver:self forKeyPath:@"kvo"];
    }
    @catch(NSException *exception){
        WWLog(@"%@",exception);
    }
    /*https://stackoverflow.com/questions/31708337/ios-kvo-cannot-remove-an-observer  这里也有相关的问题讨论 说到的基本是在ViewDidLoad中来addObserver 然后在dealloc 中removeObserver
    上边的方式其实算是只是一种防止崩溃的方式 但是可能缺掩盖了问题 可能会引发不可推测的问题
     */
    
    
}

- (void)testKVO{
    [self addObserver:self forKeyPath:@"kvo" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)testCheckBox{
    /*
关于自己处理CheckBox的问题    https://github.com/Boris-Em/BEMCheckBox
    https://stackoverflow.com/questions/5368196/how-to-create-a-simple-checkbox-in-ios
    https://stackoverflow.com/questions/650131/checkbox-in-ios-application
    简单的办法就是用一个button 然后处理根据选中与否 设置不同的图片
     
     //有的时候如果项目中有的视图是一样的时候 这个时候可以使用NSKeydArchiver 把视图存储起来 之后再NSKeyedUnarchiver 不过对于有的视图的属性 颜色 等设置 不能够正常的复制 并解档出来
     这个时候目前的想法就是把相关的相似 视图 单独放在某个方法里
     然后根据需要去调用
     
     对于某个视图 左半部分可以响应事件 右半部分不能响应事件处理的想法是
     左半部分在下边的父视图上而右半部分不在 这个有的时候可以算作一种有的有色Label的部分可以点击 部分不可以点击的一种办法
     
     */
    
    
}

#pragma mark - 测试关于TextField的相关内容
- (void)testTextField{
    
    UITextField *textField = [UITextField new];
    textField.frame = CGRectMake(20, 20, 300, 40);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor grayColor];
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    NSAttributedString *attriStr = [[NSAttributedString alloc]initWithString:@"属性占位文字" attributes:dict];
    
    //设置占位文字的属性字符串
    textField.attributedPlaceholder = attriStr;
    [self.view addSubview:textField];
    
    
//    NSLog(@"%@",NSStringFromCGRect(textField.leftView.frame));
    UIButton *leftBtn = [UIButton new];
    leftBtn.frame = CGRectMake(0, 0, 100, 40);
    leftBtn.backgroundColor = [UIColor blueColor];
//    textField.leftView = leftBtn;
    //其实这个leftView可以算是一种实现 左侧像淘宝那样的显示+86>那样的信息的一种方式
    //当然有的更复杂的有的是用的TableViewCell来实现也是一种办法
    [leftBtn setTitle:@"+86 >" forState:UIControlStateNormal];
    //下方的代码可以保证leftView可以正常显示 UITextFieldViewModeWhileEditing
    textField.leftViewMode = UITextFieldViewModeAlways;
    _textField = textField;
    
    //UIButton在设置font的时候 可以参考px / 4 * 3 = pt
    //像UITextField的时候就得用 px/ scale = pt
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
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
