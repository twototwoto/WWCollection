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
    
    UIButton *leftBtn = [UIButton new];
    leftBtn.frame = CGRectMake(0, 0, 100, 40);
    leftBtn.backgroundColor = [UIColor blueColor];
    textField.leftView = leftBtn;
    //其实这个leftView可以算是一种实现 左侧像淘宝那样的显示+86>那样的信息的一种方式
    //当然有的更复杂的有的是用的TableViewCell来实现也是一种办法
    [leftBtn setTitle:@"+86 >" forState:UIControlStateNormal];
    //下方的代码可以保证leftView可以正常显示 UITextFieldViewModeWhileEditing
    textField.leftViewMode = UITextFieldViewModeAlways;
    _textField = textField;
    
    
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
