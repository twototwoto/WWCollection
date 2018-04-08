//
//  ReadMe.h
//  WWCollection
//
//  Created by WYW on 2018/3/25.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#ifndef ReadMe_h
#define ReadMe_h
/*
    *could not read data from '.../SupportFiles/Info.plist': The file “Info.plist” couldn’t be opened because there is no such file.
 之前都是在设置pch文件的时候可能出现路径错误的问题
 这次是挪动了info.plist文件的位置导致了上边的这个问题
 其实解决的办法和prefixheader的文件路径有误的方法是一样的
 在选中Targets 后 在右边搜索 infoplist 之后设置好目前的info.plist 文件的位置即可
 $(SRCROOT)/相应的文件路径
 //参考网址：https://blog.csdn.net/u011439689/article/details/27089979
 
 *另外的一个问题是在设置prefixHeader 文件的内容后出现了类似Unterminated conditional directive in Xcode 的问题
 在这里看到了答案：https://stackoverflow.com/questions/8883818/unterminated-conditional-directive-in-xcode
 其实就是对应的#ifdef 和#endif不配对 导致的
 
 2018-03-29的时候因为在命名的时候一个WYWCollectionView和一个WYWCollectionViewCell的命名的冲突的问题相关的引用已经被删除了暂时
 
 2018-03-31 CocoaPods 1.5.0.beta.1 is available.
 To update use: `sudo gem install cocoapods --pre`
 使用这个命令更新了Cocoapods
 起因是pod search 不到MJRefresh 的3.15.4 search 到3.15.3 不过后来用了beta版的Cocoapods 仍然只能搜索到3.15.3
 
 2018-04-02 有的时候设置合适的约束 也会给程序意想不到的效果 设置一个视图的上左下右 和 父视图都一样跟单纯的设置frame的方式是不同的 尤其在操作可以滚动的时候的时候这一点会有不一样的收获
 轮播图的SDCycleScrollView还是挺好用的 设置挺简单的 自己在写相关内容的时候如果是全屏宽度的CollectionViewCell的时候总是会有中间的间隙去不掉 还需要看看究竟
 基类的合适使用有利于代码的复用 尤其像背景色 背景图 导航栏的部分的某些图标
 
 2018-04-02 一点点收获是 如果对于一个 mainScrollView 承载着多个TableView
 
|-                headView                    -|
 |TableView|  |TableView|   |TableView|   |TableView|
 
 解决方案：
    * 可以考虑一个mainScrollView 承载着多个UITableView 可以以添加子控制器的方式添加
 给每个控制器设置代理 来传递到 TableView的滚动
    * 多个UITableView每个都设置TableHeaderView 而且高度是顶部的headView的高度 不过只是留着做占位使用而已
    * 顶部的headView选择最后添加 添加的时候添加到self.view上
    * 在各个TableView滚动的时候如果想让headView也滚动 则在相关的滚动的代理方法中根据滚动的偏移量来改变顶部的headView
    * 在滚动某一个UITableView的时候
    ！！注意适当更改其他的UITableView的偏移！！
        这样才可以适当避免闪动 其实自己就卡在了这一步过
 参考地址：https://github.com/liuzhongning/NNJaneBookView
 
 2018-04-04
 初步考虑UITableView的Cell上的文字展开和收起的问题：
 查看了相关资料后 对于比较简单的cell上主要组成部分为展示文字的UILabel的这种情况
 
 比如说我们要一个cell最多展示4行的文字的Label
    * 那么如果是不要求行间距的情况下 其实UIFont有一个lineHeight的属性 乘以行数就是cell中的文字label的收缩状态下 要展示的高度
    * 这个我还没试 如果是考虑文字的行间距的情况下 结合上边的lineHeight再加上对应的行间距来计算 或者换种方式计算 参考着字符串和NSMutableParagraphStyle 使用boundingRect来做相关的计算
    * 那么在heightForRow的代理方法里边需要注意的是
        * 判断要展示的文字内容的高度 如果高度高于了限制的最大的高度 那么只显示4行数据
        * 如果是要展示的文字的内容的高度 低于限制的最大的高度 那么就只返回对应的字符串的高度
    * 在点击cell 的时候展开内容需要注意的是 选用的方式可以是直接改变对应的cell的文字Label 的numberofLines 为 0 ，然后调用到了heightForRow的时候cell就展开了
        当再次点击label的时候cell的numberofLines 再恢复为限制的行数
    * 在对cell的内容展开的时候 可以给cell的模型数据一个是否展开的标记 防止重用cell的时候出现问题
 相关问题正在探索中 有更多发现再改善
 参考的网址有：https://blog.csdn.net/Lotheve/article/details/51011646
 https://github.com/gsdios/GSD_WeiXin
 
 2018-04-05
 复习Effective Objective-C 2.0 编写高质量 iOS 与 OSX的52个有效方法
 尽量不要使用宏 像时间相关的
 可以使用static const NSTimerInterval kDurationTime = 3.0f;
 const 常量修饰符号 不能够在同一个项目中定义同样的名称的变量（这个时候会生成外部符号 如果是在不同类文件中定义了同名的常量 那么会编译后生成相关类名的.o 文件 并且报错链接错误） 除非是和static结合着使用的时候就可以起到和宏类似的效果 而且还能够清楚看出定义的常量的类型 这种时候是不会创建外部符号的
 对于外部可见的类型常量 可以使用的方式是在.h 文件中使用extern 变量类型 变量
 在.m 文件中给相应的变量赋值 这样其他的文件就能够看到对应的常量了 并且可以使用
 尽量延后引入头文件 可以在头文件中使用@class 类名; 在.m 文件中有需要的话再#import
 
 
 2018-04-06
 @autoreleasepool{
    //内存消耗比较大的代码
 }
 用自动释放块降低内存峰值
 每个自动释放池都有其范围 可以避免无意间误用了那些清空池后已为系统回收的对象
 typedef NSInteger (^EOCMyBlock)(NSInteger value,BOOL flag) //typedef为常用的类型起别名
 
 
 2018-04-07
 关于UIPageViewController:http://www.theappguruz.com/blog/uipageviewcontroller-in-ios
 
 组件化：https://blog.cnbang.net/tech/3080/
 https://casatwy.com/iOS-Modulization.html
 
2018-04-08
 学习内容：http://es6.ruanyifeng.com/#docs/style
 https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000
 关于继承的内容：最近项目中倒是有界面相似的程度比较大 像背景图片 背景色 导航的返回 这些使用继承的方式可能便于处理了 不过有的视图控制器在继承的时候感觉控制的还是不大好接下来要看看这部分相关内容 相关内容还要消化一下
 https://www.cnblogs.com/JackieHoo/p/5445549.html
 https://casatwy.com/tiao-chu-mian-xiang-dui-xiang-si-xiang-yi-ji-cheng.html
 
 
 */


#endif /* ReadMe_h */
