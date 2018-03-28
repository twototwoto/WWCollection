//
//  WYWTestViewController.m
//  WWCollection
//
//  Created by WYW on 2018/3/22.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWTestViewController.h"
#import "WYWCollectionView.h"
#import "WYWCollectionViewCell.h"
#import "WWExperienceScrollView.h"

#import "UIButton+WWAdd.h"



#import <objc/runtime.h>

static void *EOCMyAlertViewKey = @"EOCMyAlertViewKey";

@interface WYWTestViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

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
    [self testUIButtonNormalSelectedHighlighted];
    [self testUIButtonTextImagePosition];
    
    [self testAssociateObject];
    
//    [self testUICollectionView];
    
    [self testUIScrollViewHitTest];

    
}

- (void)testUIScrollViewHitTest{
    WWExperienceScrollView *experienceScrollV = [[WWExperienceScrollView alloc]initWithFrame:CGRectMake(0, 100, 300, 300)];
    [self.view addSubview:experienceScrollV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = experienceScrollV.center;
    [btn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBtnClick:(UIButton *)sender{
    WWLog(@"btnClick");
}

- (void)testUICollectionView{
    return;
    self.view.backgroundColor = [UIColor whiteColor];
    //Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'UICollectionView must be initialized with a non-nil layout parameter'

//    WYWCollectionView *collectionV = [WYWCollectionView new];
    CGFloat itemW = (self.view.frame.size.width - 15 * 2.0)/3.0f;
    CGFloat itemH = 210.f + 20.f+ 24.f;
    CGFloat verticalMargin = 15.f;
    CGFloat horizontalMargin = 15.0f;
    
    
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
//    flowLayout.minimumLineSpacing = verticalMargin;
//    flowLayout.minimumInteritemSpacing = horizontalMargin;
    
    
//    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 3.0f, self.view.frame.size.height / 3.0f);
//    flowLayout.minimumLineSpacing = 100.0f;
//    flowLayout.minimumInteritemSpacing = 50.f;
//    flowLayout.itemSize = CGSizeMake(100.0f, 100.f);
//    WYWCollectionView *collectionView = [[WYWCollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuseID"];
//    [collectionView registerClass:[WYWCollectionViewCell class] forCellWithReuseIdentifier:@"reuseID"];
//
    [self.view addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15.0f;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WYWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseID" forIndexPath:indexPath];
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor blueColor];
    }else{
        cell.backgroundColor = [UIColor yellowColor];
    }
    return cell;
}

#pragma mark - 关于关联对象的内容
- (void)testAssociateObject{
    //学习内容：Effective Objective-C 2.0编写高质量iOS 与OSX代码的52个有效方法
    /*
     对象关联类型
     OBJC_ASSOCIATION_ASSIGN    assign
     OBJC_ASSOCIATION_RETAIN_NONATOMIC      nonatomic retain
     OBJC_ASSOCIATION_COPY_NONATOMIC    nonatomic copy
     OBJC_ASSOCIATION_RETAIN    retain
     OBJC_ASSOCIATION_COPY  copy
     //    objc_AssociationPolicy
     
     
     objc_setAssociatedObject
     objc_getAssociatedObject
     objc_removeAssociatedObjects
     */
//    [self askUserAQuestion];
    [self askUserAQuestionWithAssociatedObject];
    
}

- (void)askUserAQuestionWithAssociatedObject{
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"Question" message:@"What do you want to do" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续", nil];
    void (^block)(NSInteger) = ^(NSInteger buttonIndex){
        if (buttonIndex == 0) {
            WWLog(@"do cancel")
        }else{
            WWLog(@"do continue");
        }
    };
    objc_setAssociatedObject(alertV, EOCMyAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    [alertV show];
//    objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
//    objc_getAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>)
    /*
     使用关联对象的方式可以使得创建警告视图和处理操作结果放在一起了
     不过要注意循环引用
     给分类添加属性 也会用到关联对象
     objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
     相当于
     把object 源对象
     通过key
     和value 关联了起来
     最后是指定的关联的策略
     
     objc_getAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>)
     相当于是把
     源对象object
     通过关联的key
     取出来
     
     这样确实是有点类似于字典的 key value 这种键值对了
     
     */
}

- (void)askUserAQuestion{
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"Question" message:@"What do you want to do" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    [alertV show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//NS_DEPRECATED_IOS(2_0, 9_0)
    
    void(^block)(NSInteger) = objc_getAssociatedObject(alertView, EOCMyAlertViewKey);
    block(buttonIndex);
    
    
    return;
    if (buttonIndex == 0) {
        WWLog(@"do cancel");
    }else{
        WWLog(@"do continue");
    }
}






#pragma mark - 改变UIButton的文字图片位置
- (void)testUIButtonTextImagePosition{
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [btn setTitle:@"title" forState:UIControlStateNormal];
    [btn setTitle:@"titlee" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    btn.titleLabel.backgroundColor = [UIColor blackColor];
//    [btn sizeToFit];
    btn.frame = CGRectMake(0, 0, 240, 240);
    
    WWLog(@"%@--%@",NSStringFromCGRect(btn.imageView.frame),NSStringFromCGRect(btn.titleLabel.frame));
    [btn wyw_buttonCenterImageAndTitle];
    
    [self.view addSubview:btn];
    btn.center = self.view.center;
    
}

#pragma mark -
- (void)btnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
//    if (sender.selected) {
//        return;
//    }
//    sender.selected = YES;
    
}

#pragma mark - 关于选中的button 的再次点击的问题
- (void)testUIButtonNormalSelectedHighlighted{
    //学习网址：https://www.jianshu.com/p/57b2c41448bf
    UIButton *btn = [UIButton new];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 50, 50);
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"button" forState:UIControlStateNormal];
    [btn setTitle:@"button" forState:UIControlStateHighlighted];
    [btn setTitle:@"selected" forState:UIControlStateSelected|UIControlStateHighlighted];
    [btn setTitle:@"selected" forState:UIControlStateSelected];
    WWLog(@"%zd--%zd---------%zd-%zd",UIControlStateNormal,UIControlStateHighlighted,UIControlStateSelected|UIControlStateHighlighted,UIControlStateSelected);//0-----1---5---4
    //话说这个和位移枚举有关系
    
    [self.view addSubview:btn];
    btn.center = self.view.center;
    
    
//    [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    btn setBackgroundImage:[] forState:<#(UIControlState)#>
    
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
