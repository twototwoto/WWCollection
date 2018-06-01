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
 
 2018-04-09
 有的时候可能前边的 viewB 在 viewA后边布局 可是还想viewB在ViewA的下边 那么可以考虑下边的方式 平时项目中可能大多是简单地使用addSubView 这种可以适用于后者的滚动视图在前者的头视图的下边滚动的情况
 [self.view insertSubview:viewA belowSubview:viewB];
 [self.view insertSubview:viewA aboveSubview:viewB];
 
 2018-04-10
 cell的模型的数据的展开的位置应该考虑的是使用模型数据来记录cell的展开的状态
 而不是仅仅给某个cell 的属性中添加是否展开的标记
 使用模型数据来记录的话 拿到的数据是可靠的
 如果是使用cell来记录的话 拿到的数据可能会受到cell的重用的影响
 在展开cell的过程中如果只是有文字的展示这种情况 可以考虑是用改变numberofLines的方式
 不过如果是还涉及到有其他的视图的话 那么或者考虑在做约束的操作的时候做处理(其中考虑在做约束的时候做向下的约束处理的话，我还没有试验成功，因为如果是其他的图标参照着cell的底部来做约束的话 那么当动态更新展示文字的label的高度的时候，其他的视图并不能做到相应的变化)
 或者是考虑是用 下边的方式
 [self.tableView beginUpdates];
 [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 [self.tableView endUpdates];
 
 不过还是会有抖动感觉 或许 把cell的选中的方式改为None好像好一点点
 
 今天在写一个音频的工具类的时候发现了一些问题 之前的时候写的单例在有些情况下原来是不对的
 参考文章：https://www.cnblogs.com/JackieHoo/p/5050010.html#undefined
 不仅仅要注意返回的sharedInstance 和 new 和 alloc]init] 的时候返回的实例地址是否相同
 尤其像在sharedInstance的地方 不能单单返回   [[self alloc]init] 那么简单 要加上判断 相互之间的调用一定要注意执行的次数 以及是否又重新创建了实例 否则的话即使可能地址都是一致的 但是创建出来的实例却可能不是同一个了。。。
 此处引发的更多问题是：block内部修改静态变量的话是可以的原因：待分析 http://www.knowsky.com/882097.html
 
 在使用//#import <AVFoundation/AVAudioPlayer.h> 的时候会报警告
 如果使用#import <AVFoundation/AVFoundation.h> 警告就没了
 https://stackoverflow.com/questions/39550857/avfoundation-import-warnings-after-xcode-8-upgrade
 //获取当前时间 的秒数
 CMTimeGetSeconds(player.currentTime);
 
 long long int seconds =  player.currentItem.currentTime.value / player.currentItem.currentTime.timescale;
 NSUInteger seconds = player.currentItem.currentTime.value / player.currentItem.currentTime.timescale;
 
 有两个办法可以快退和快进 其中seekToTime后边的参数 可以填写 我们要操作的秒数
 我们可以获取到当前的秒数 然后让当前的秒数和 想要快退或者是快进的秒数做运算就可以得到想要的结果
 比如说当前时间快进10秒
 CMTimeAdd(当前的时间,CMTimeMake(10,1))
 如果是当前时间快退10秒
 CMTimeAdd(当前的时间,CMTimeMake(-10,1))
 我试过了 如果是seekTime后边的值小于0秒了 那么也会是从0秒开始 当然最好自己做个判断 包括上界的控制 如果是上界超过了就不行了 不能正常播放了
     player seekToTime:<#(CMTime)#> completionHandler:<#^(BOOL finished)completionHandler#>
     player seekToTime:<#(CMTime)#> toleranceBefore:<#(CMTime)#> toleranceAfter:<#(CMTime)#> completionHandler:<#^(BOOL finished)completionHandler#>
 
 
 看起来timeValue好像就是 就相当于是秒数了
 timescale看样子像是一直是1
 
 //关于获取音频长度 以及秒数转换
 - (NSUInteger)audioDurationWithURL:(NSString *)audioURLStr{
 NSURL *audioUrl = [NSURL URLWithString:audioURLStr];
 //    AVURLAsset *audioAsset = [AVURLAsset assetWithURL:audioUrl];
 //    CMTime audioDuration = audioAsset.duration;
 //    return audioDuration.value / audioDuration.timescale;
 //    return CMTimeGetSeconds(audioDuration);
 NSDictionary *dict = [NSDictionary dictionaryWithObject:@"NO" forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
 AVURLAsset *asset = [AVURLAsset URLAssetWithURL:audioUrl options:dict];
 NSUInteger seconds = asset.duration.value / asset.duration.timescale;
 return seconds;
 }
 
 - (NSString *)timeStringWithSeconds:(NSUInteger)seconds{
 NSUInteger minutes = seconds / 60;
 NSUInteger secondsRemainder = minutes % 60;
 return [NSString stringWithFormat:@"%zd:%zd",minutes,secondsRemainder];
 }
 
 在学习https://github.com/DaMingShen/SUMusic 的时候遇到的问题：
   * Command /bin/sh failed with exit code 1
 通过 TARGETS -> Build Phases -> Copy Pos Resources -> 勾选了 run script only in installing
 
   * 还有一个相关的报错是：友盟的相关的xib的内容有问题 在指定了Pods下的 UMSocial -> Resources 中的xib的内容 设置了 builds for 后可以正常的Run起来了
 
 
 
 2018-04-11
 在WWPractise小项目中有相关的内容
 [[MPNowPlayingInfoCenter defaultCenter]setNowPlayingInfo:dictM];
 //使用这个就可以做到锁屏的时候展示出来锁屏的信息 这句代码才是显示出来音频信息的关键代码
 图片保存到相册：https://blog.csdn.net/a7359780/article/details/50838515
 放大图片：https://blog.csdn.net/qxuewei/article/details/51150404
 设置访问相册的代理的时候https://stackoverflow.com/questions/8571783/assigning-to-iduinavigationcontrollerdelegate-uiimagepickercontrollerdelegate
 还要遵循那个UINavigationDelegate 否则有警告
 待解决 获取编辑过的图片的问题：https://stackoverflow.com/questions/44465904/photopicker-discovery-error-error-domain-pluginkit-code-13
 
 block传值竟然生疏了，使用比如说界面A传值到界面B
 可以在界面B中定义block属性 比如说 void(^block)(NSString *str)
 在A中回到B的时候使用 self.block(str) 把要回传的值带回来
 然后在界面A中使用B的时候使用
 B的实例.block = = ^(NSString *str) {
    在其中对A中 要通过B赋值的的操作写在这里
 };
 
 关于音频的进度的一点问题
 /*
 * 使用定时器是为了查询当前的currentTime的 而不是用来计时的
 * 拖动的时候valueChanged的位置可以通过slider.value  * 总的时长拿到应该seek 到的时间
 * 拖动的时候应该先停止定时器再继续定时器
 * 在处理的过程中会有抖动的问题有待处理
 *
 *
 
 
 2018年4月12日
 UITableView的group的样式的调节组间距
 如果只是设置heightForHeader 或者heightForFooter的话 不会调用
 还需要实现viewForHeader相关的内容才能够调节组间距
 https://blog.csdn.net/yjlios/article/details/52382372
 Md5加密：https://blog.csdn.net/w582324909/article/details/51939425
 https://blog.csdn.net/xn4545945/article/details/36755117
 调节UICollectionView组间距：https://blog.csdn.net/u014773226/article/details/54317781
 
 被底部的TabBar遮挡问题：https://blog.csdn.net/liuda18341750560/article/details/50254565
 Xib的方式设置圆角：http://www.cocoachina.com/ios/20150528/11940.html

再记录一个关于block传递数据的内容
 点击cell上的按钮 然后在控制器中做方法处理
 
 * 在自定义的Cell中定义了一个 void(^block)(NSIndexPath *indexPath) 属性
 并且定义一个@property (nonatomic,strong) NSIndexPath *indexPath;
 
 * 在控制器的cellForRow中使用 cell.indexPath 来记录下来当前的cell的indexPath
 并且cell.block = ^(NSIndexPath *indexpath) {
    //在此处执行点击cell上的按钮后的操作
 };
 
 * 在cell的实现的文件中 定义按钮的实现方法 在其中判断是否self.block 有的话 调用
 self.block(self.indexPath)
 
 2018年4月13日
 
 如果项目中有重复的文件是比较方便看出来的
 YYKit中包含YYModel 如果pod重叠的话 会引发链接错误
 一个关于AppIcon的链接问题：
 https://stackoverflow.com/questions/19145089/asset-catalog-compiler-options-missing
 我查看了下相关内容部分 像bundleIdentifier的问题
 还有buildsetting种的问题 asset相关的部分 查看Sticker Pack Identifier Prefix 部分是否对应有项目的bundle identifier
 还可以重新添加一下相关appicon的图片
 
 SVN添加没有被加入到版本控制的文件：
 
 https://stackoverflow.com/questions/1598968/add-all-unversioned-files-to-svn
 有的文件虽然没有commit上去那么update的时候也不会覆盖掉本地的文件，这些文件可能对于SVN来说像是隐形的 不过如果是直接checkout的方式来下拉代码的时候 那些没有没有被加到版本控制中的文件自然就不可能出现了
 
 2018年4月16日
 SVN使用过程中的一个问题：
 svn: E155010: Commit failed (details follow):
 svn: E155010: '/文件路径/New Group' is scheduled for addition, but is missing
 当我执行了：svn revert /文件路径/New Group --depth infinity
 后提示：
    Skipped '文件路径/New'
    Skipped 'Group'
 不知道是否是因为New Group的原因 还是什么再次提交的时候还是提示
 svn: E155010: Commit failed (details follow):
 svn: E155010: '/文件路径/New Group' is scheduled for addition, but is missing
    另外一种方法 使用Xcode 在commit文件的时候找到这个New Group 文件 然后
    只好使用Xcode 找到文件 选择discard changes 或者是是用其他的SVN的工具的话 也是discard 这个文件也是一样
    然后再commit 就可以了
 
 参考网址相关网址：
 https://www.cnblogs.com/LQCQ-Silent/p/6120899.html
 https://blog.csdn.net/rangf/article/details/7408230
 https://stackoverflow.com/questions/46827071/xcode-9-couldn-t-communicate-with-a-helper-application?rq=1
 https://www.jianshu.com/p/a64a505202ad
 https://blog.csdn.net/chengkaizone/article/details/53420469
 
 //改变UITableViewCell右侧的箭头的颜色 通过自定义accessoryView来实现
 UIImageView *imgV = [UIImageView ww_imageViewWithImageNameString:@""];
 imgV.frame = CGRectMake(0, 0, (10.f), (15.f));
 self.accessoryView = imgV;
 
 参考网址：https://developer.apple.com/documentation/uikit/uitableviewcell/1623219-accessoryview?language=objc
 参考网址：http://www.cocoachina.com/bbs/read.php?tid=69554
 
 //UITableView改变组间距 实现 如果单单实现高度的代理方法的话 是不会起到作用的

 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [UIView new];
    headerV.backgroundColor = WWColorWithRGBA(249.f, 249.f, 249.f, 1.0);
    return headerV;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (15.f);
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [UIView new];
    return footerV;
 }
 
 //参考地址https://blog.csdn.net/xumingwei12345/article/details/9664773
 
 
 2018年4月17日
 使用宏的时候的注意事项 注意有的宏的变量最好是都是用括号封起来的，避免有的时候做的一些运算出现了问题
 比如说
 #define sampleWidth  3 + 4
 那么使用的时候如果想 用 sampleWidth * 2 想要的是 (3+4)* 2 = 14 但是结果却成了 3 + 4 * 2 = 11
 所以在对宏做乘除的操作的时候要注意加括号
 
 Masonry使用过程中可能遇到的问题可能原因 reason: 'couldn't find a common superview for <UITableView:
 我们都对这个错误感觉很常见 不过有的时候不是因为没有添加到父视图
 也可能是因为做约束的时候选择的 参考的对象 有问题造成的崩溃
 
 友盟第三方登录的时候的注意事项
 AppKey写对 用于友盟SDK初始化操作 查看AppKey：http://mobile.umeng.com/apps/setting
 info.plist文件中白名单的配置情况LSApplicationQueriesSchemes
 URL types下的URLScheme的准确填写 否则无法正常调起第三方
 
 关于回调的操作方面，记得设置系统回调 否则即使从第三方返回的时候不回走回调方法
 
 相关方法：https://developer.umeng.com/docs/66632/detail/66825#h3-u8BBEu7F6Eu7CFBu7EDFu56DEu8C03
 // 支持所有iOS系统
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
     //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
     BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
     if (!result) {
     // 其他如支付等SDK的回调
     }
     return result;
 }
 
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
 {
     //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
     BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
     if (!result) {
     // 其他如支付等SDK的回调
     }
     return result;
 }
 
 支持目前所有iOS系统
 
 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
 {
     BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
     if (!result) {
     // 其他如支付等SDK的回调
     }
     return result;
 }
 

 2018年4月18日
 腾讯开放平台http://open.qq.com
 管理中心的位置可以获取到QQAppID 以及 QQAppKey用于友盟的第三方登录
要注意的是在配置QQ相关的scheme的时候 会要求输入QQ的AppID和tencent+AppID 以及QQ+(QQAppID的16进制的形式)
 关于16进制可以考虑的是使用网上的工具来获取相应的16进制的内容 另一种简单的方式是使用%x的输出的方式 或者就是自己写一下了 不过意外发现原来项目中原来用的16进制的数值不对 不过仍然可以正常地使用QQ登录 后来试了下 发现只要10进制的QQ的AppID的位置填写对了就能够正常地QQ登录
 这个是QQ登录的时候遇到的一个问题： 看样子是没有代码初始化 QQAppID引发的
 Error Domain=UMSocialPlatformErrorDomain Code=2002 "(null)" UserInfo={message=appId is nil}
 
 如果是配置的scheme有问题
 Error Domain=UMSocialPlatformErrorDomain Code=2007 "(null)" UserInfo={message=Check APP UrlSchema Fail}
 
 发现即使是16进制的scheme不对 只要十进制的是正确的就可以正常地登录
 进制转换工具：https://tool.lu/hexconvert/
 
 关于新浪微博开放平台对于回调地址的准确填写要求比较明确
 如果设置的回调地址不对的时候报出： redirect_uri_mismatch
 
 
 在此处再记录一个键盘弹出后 通知执行后键盘没有弹到预期的位置的可能因素，如果是设置的导航栏的translucent为NO的时候
 如果是改变要弹起来的textField或者是textView也好，如果是参考的是下方的约束可能还好，如果是使用的参照的顶部的约束的话，由于偏差了一个导航加上一个状态栏的高度可能导致键盘依然遮挡着文本框
 在谈一下键盘弹起的时候可能调用了2次 这个问题目前还不知道是何原因 不过不要做那种 += 或者-= 的操作而是直接控制着到某个位置 也算是一种解决方案
 
 #pragma mark - 添加键盘通知
 - (void)addNotificationKeyboard{
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboradWillShow:) name:UIKeyboardWillShowNotification object:nil];
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
 }
 
 #pragma mark - 移除键盘通知
 - (void)removeNotificationKeyboard{
 [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
 [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
 }
 
 
 #pragma mark - 处理键盘将要弹出
 - (void)handleKeyboradWillShow:(NSNotification *)noti{
    //获取到键盘的高度
     CGFloat keyboardH = ((NSValue *)(noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"])).CGRectValue.size.height;
     //其他的就是改变目的视图的位置了 或者是偏移
     [UIView animateWithDuration:0.2f animations:^{
        //可以在此做更改目的视图位置改变的操作
     }];
 }
 
 #pragma mark - 键盘隐藏
 - (void)handleKeyboardWillHide:(NSNotification *)noti{
     //获取到键盘的高度
     CGFloat keyboardH = ((NSValue *)(noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"])).CGRectValue.size.height;
     //其他的就是改变目的视图的位置了 或者是偏移
     [UIView animateWithDuration:0.2f animations:^{
     //可以在此做更改目的视图位置改变的操作
     }];
 
 }
 
 
 Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'attempting to add unsupported attribute: (null)'
 Masonry使用的时候的一个问题： 当待参考的对象的内容为空的时候可能出现下列报错
 比如说在待参考对象没有创建出来前，我们就让现有的视图参考了待参考对象，相当于参考了为空的对象
 
 2018年4月19日 
使用UITextView的时候 遇到的一个问题像
 - (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length < 1) {
 
 
    }
 }
 
 //如果是1上边的获取到的sender 会是UITapGestureRecognizer类型的sender 会崩溃的哦
 //1    [button addTarget:self action:@selector(buttonClick:)];
 //2    [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];

 2018年4月20日
 想了解一个第三方的时候
 概览一下
 修改一下源码 看看那些对应的位置改变了 比如说改变背景色 文字颜色 这些比较直观
 日历控件使用：
 FSCalendar:https://github.com/WenchaoD/FSCalendar
 JTCalendar:https://github.com/jonathantribouharet/JTCalendar
 
 对于某些界面初次展示出来的类似的新手引导页或者是一个提示的界面 又是半透明的情况 可以考虑是用modal的方式
 把被modal出来的控制器记为modalVC 在布局modalVC的视图的时候按照全屏去布局UI就可以 避免后期modal出来再调整位置 改大小都不合适
modal被modal出来的时候是全屏的，设置modalVC的modal样式为custom
 modalVC.modalPresentationStyle = UIModalPresentationCustom;
 这样就可以起到半透明的效果了
 
 FSCalendar 部分学习
 FSCalendarHeaderView
 用于展示顶部的 四月 2018 五月 2018 的顶部View
 FSCalendarWeekdayView
 用于显示 周一 周二 周三 周四 周五 周六 周日的视图
 
 关于日期的格式指定的一点点基础内容：
 NSDate *date = [NSDate date];
 NSDateFormatter *dateFormatter = [NSDateFormatter new];
 //用于指定展示的日期的格式2018年-04月-21日22:52
 dateFormatter.dateFormat = @"yyyy年-MM月-dd日HH:mm";
 NSString *dateStr = [dateFormatter stringFromDate:date];
 
 2018年4月22日
 //如果是想用英文形式(March这种的)表示的月份：使用MMMM
 //yyyy年MM月dd日HH时:mm分
 FSCalendar中就是这么指定的格式：_headerDateFormat = @"MMMM yyyy";
 
 关于NSCalendar 周几的表示方法 当然我们可以根据自己的需要自己去指定周几 还是星期几等
 NSCalendar *regorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian
 ];
 regorianCalendar.weekdaySymbols;
 //Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday
 
 regorianCalendar.shortStandaloneWeekdaySymbols;//Sun,Mon,Tue,Wed,Thu,Fri,Sat
 
 regorianCalendar.veryShortWeekdaySymbols;//S,M,T,W,T,F,S
 
 2018年4月23日
 关于UILabel多行文字设置行间距和预期的不符的问题
 http://7xqch1.com1.z0.glb.clouddn.com/有关UILabel的行高设置的探索.html
 http://pingguohe.net/2018/03/29/how-to-implement-line-height.html
 paragraphStyle.lineSpacing = lineSpacingH - (label.font.pointSize.font.lineHeight - label.font.pointSize);
 还是会有出入可以设置成这种方式 这样有误差了
 paragraphStyle.lineSpacing = floorf(lineSpacingH - (label.font.lineHeight - label.font.pointSize));
 
 多行文字的高度计算不准确可能是是最初在布局的时候没有设置好
 比如说计算字符串的高度的时所用的label的宽度和当初设置的label的宽度不一致最后可能导致计算的高度不能够容纳cell中的内容
 比较简单的可能是在给cell的label的内容赋值的时候出了问题
 
 2018年4月24日
 对于既有文字又有图片的情况的cell的展开和收缩的情况
 我倒是没有尝试如果是分多个section放置这些cell是否会有缓解 因为可能reloadSection引起的抖动 如果一组里边只有这么一个cell不知道是否会好一些
 有个问题是文字展开的时候会发现cell抖动严重 可能有别的办法做缓存高度的处理能够做到效果好一些
 不过对比只有文字没有图片的cell的展开可以发现cell基本上没什么抖动
 这个时候如果是对于微信的朋友圈界面而言 我们可以考虑的是
 可以 把下列内容当作一组cell
    把头像部分和发表的文字部分当作一个cell   AvatarCell DetailContentCell 可以在一起(这样做的时候当展开文字的时候会发现头像部分抖动)
    头像部分和发表的文字部分最好还是分开用两个celll来写
    把是否有图片部分当作一个cell        ImageViewCell
    把评论部分当作一个cell       commentCell
    把点赞的人的部分当作一个cell        likeContentCell
    把评论的内容部分当作多个cell        commentContentCell
 这样的话可以在某种程度上解决cell的抖动的问题
    一组cell的情况是这样的
        * AvatarCell
 * DetailContentCell 可以和AvatarCell合二为一((这样做的时候当展开文字的时候会发现头像部分抖动 头像部分和发表的文字部分最好还是分开用两个celll来写)
        * ImageViewCell
        * commentCell
        * likeContentCell
        * commentContentCell
 
 //重用标识写错了也可能导致cell错乱
 UICollectionView为nil可能的原因
 * 约束有误
 * 如果是懒加载过程中写错了相应的属性对应的方法 比如说collectionView 写成了别的collectionViewWWWWW的话那么 在懒加载创建的时候就不能正常地创建出来
 这种问题看似简单 不过容易出现在有的时候省事粘贴代码的时候
 - (UICollectionView *)collectionView{
    if(!_collectionView) {
        _collectionView = 实例化
    }
    return _collectionView;
 
 }
 
 - (UICollectionView *)collectionViewWWWWW{
 if(!_collectionViewWWWWW) {
    _collectionViewWWWWW = 实例化
 }
 return collectionViewWWWWW;
 
 }
 
 
 
 2018年4月25日
 Jpg转换为png：http://www.atool.org/imgextconvert.php

 注意设置UIButon的  button.titleLabel.font = [UIFont systemFontOfSize:(12.0f)];
 之后还要注意要求的button的高度的情况 不然可能对布局造成误差
 因为button的高度高于单单的titleLabel部分的高度
 
 像下边的这种如果是不用weak strong dance 的话可能会造成后边执行方法的时候indexpath为nil了
 我不小心直接用过self 调用方法 确实是出现过问题 indexpath为nil了
 好像不仅仅是这里的问题还有别的问题
 问题是出现在了忘记了给cell的indexpath赋值 导致block回调的时候indexPath为nil
 
 __weak typeof(self) weakSelf = self;
 cell.block = ^(NSIndexPath *indexPath) {
    __strong typeof(weakSelf) strongSelf = weakSelf;
    [strongSelf method:indexPath];
 };
 
 
 对于评论回复的盖楼的情况想到的有两种方式来做
 普通的回复的样子的话直接堆积多个cell可以解决
 如果是评论堆积过程中评论的样式有变动的话 就不能简单堆积多个相同cell了 毕竟可能出现查看更多的内容等
 * cell中嵌套UITableView
 * cell中评论的盖楼部分使用富文本的形式来解决问题
 相关网址：
 * https://daiweilai.github.io/2015/03/15/封装一个简单实用的朋友圈/
 * https://blog.csdn.net/wenmingzheng/article/details/78081127
 * https://blog.csdn.net/woaifen3344/article/details/50779743
 
 一个UITableView在cell的显示与隐藏的时候的崩溃情况：
 Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of rows in section 0.  The number of rows contained in an existing section after the update (5) must be equal to the number of rows contained in that section before the update (3), plus or minus the number of rows inserted or deleted from that section (1 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).'
 *** First throw call stack:
 (0x18103b164 0x180284528 0x18103b038 0x1819d57f4 0x18a7ba258 0x18a91d098 0x18a7f6300 0x100bc5a6c 0x100dd18a4 0x100dceb34 0x100dd14dc 0x1012a2d08 0x10114e4d4 0x18a62a5cc 0x18a62a54c 0x18a6150f4 0x18a629e40 0x18ac855e4 0x18ac80b94 0x18ac80678 0x18ac7f7d4 0x18a624e5c 0x18a5f5e7c 0x18af4b30c 0x18af4d898 0x18af467b0 0x180fe377c 0x180fe36fc 0x180fe2f84 0x180fe0b5c 0x180f00c58 0x182dacf84 0x18a6595c4 0x100e7e7dc 0x180a2056c)
 libc++abi.dylib: terminating with uncaught exception of type NSException
 其实是每组里边返回不同的row导致的 设置了根据一些标志来返回不同的行数
 不过这么做是不行的，那么可以考虑把相应的row的高度设置为0也算是能够起到同样的效果
 
 
 //注意下边的方式是 这是刷新相对应的indexPath 组成的数组的 的cell
 [self.tableView reloadRowsAtIndexPaths:@[nextIndexPath,nextTwoIndexPath] withRowAnimation:UITableViewRowAnimationFade];

 //下边的方式是刷新的对应的组里边的cell 整个组对应的刷新
 NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
 [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
 
 图片旋转一定的角度
 CGAffineTransform transform = CGAffineTransformRotate(imageView.transform, M_PI);
 imageView.transform = transform;
 
 如果在旋转过程中出现了问题就换种思路 考虑使用highlightedImage
 
 可能导致cell文字图片错乱的情况：
 * 可能是重用标识写成了其他的重用cell的标识
 
 有的带图片的cell一经过reloadRowsAtIndexPaths 可能会出现抖动的情况
 
 
 *
 
 2018年4月26日
 文字高度计算的选择：
 NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
 上边或在一起是为了能够不仅仅矩形高度处理好
 还有文字的行间距处理
 之前用的时候有只用NSStringDrawingUsesLineFragmentOrigin 的时候发现虽让在相应的属性字典里边写了行间距的配置
 但是就是不行
 看见下边的文章后可以考虑是因为 NSStringDrawingUsesFontLeading 没有 或 上的原因
 https://blog.csdn.net/qq_32010299/article/details/51720708
 
富文本朋友圈：
 https://github.com/waynezxcv/Gallop
 在给cell中嵌套UITableView的时候发现会出现问题 有的时候出现cell中的TableView不能够正常显示的问题 一展开一收缩导致有的数据错乱 cell中的tableView上的内容也有误了的问题
 [cell.embeddedTableView reloadData];
 
 并且在通过向cell中的TableView传递数组数据时发现数组中的内容为nil，而且此时再set数组的方法中
 刷新Acell中的TableView的时候发现TableView上的内容竟然都没了
 Acell中嵌套embeededTableView的高度计算方法：
 * 要把TableView的数据传递给Acell前，就能在ACell所在的TableView中的heightForRow中根据数据源计算出来embeededTableView所需的高度
 * 遍历那个数据源数据即可
 * 不过其间最好要想个办法，对高度有缓存的处理，不然多次的计算也是一种消耗
 注意点：
 在ACell所在的TableView中计算完了embeddedTableView的高度后
 记得在ACell内部的heightForRow中使用boundingRect用的宽度来计算高度的时候，注意宽度要一致 不然就有cell可能被遮挡了
 
 2018年4月28日
 检测有没有循环引用的办法
 * 使用内存泄漏查看Cycles & Roots部分
 * 或者是当当前ViewController在pop的时候看看有没有调用dealloc
 * 还有一种待更多了解的分享的样子的图标
 
 如果是没有成功addObserver的时候 (其实有的时候可能addObserver的类没有调用)
 发送通知并不会报错没有什么提示 只不过收不到通知罢了
 
 警告：
 Presenting view controllers on detached view controllers is discouraged
 使用：
 [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
 没有报出警告
 
 关于启动图：
 有时候启动图没有显示出来，卸载掉重新安装一次可能解决。
 可以撑起来界面的因素
 * 自带的launchScreen
 * 配置好所有尺寸的启动图 尤其注意iPhoneX的启动图 不然就是 375 * 667 的样子 上下有黑边
 * 如果没有用launchScreen 也没用启动图的话 ，自己设置启动的视图的话，要定制的时候需要设置好尺寸 这个时候默认拿到的[UIScreen mainScreen].bounds 为320 * 480
 [UIScreen mainScreen].bounds
 (origin = (x = 0, y = 0), size = (width = 320, height = 480))
 
 
 
 2018年4月30日
 其实不仅仅是block作为属性时 block中的self会被捕获
 还有的时候是比如说某一个变量有一个block的属性 而self又对这个变量有引用 变量中的block又对self有使用 那么也是会构成捕获self的情况 这个通过dealloc的方法的调用就能看出来 这种时候就得使用weak strong的方式来解决
 有的时候像NSTimer的这种情况 如果reapeats为YES的时候 那么调用的block里边也是会有捕获self的问题 也是双方都释放不了
 又一次触及到block的是否捕获self
 Masony源代码里约束部分有 从这里可以看出只有block引用了self 却不存在self对block的引用 所以在使用的时候block内部不使用weak strong修饰也不会捕获self
     - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *))block {
         self.translatesAutoresizingMaskIntoConstraints = NO;
         MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
         block(constraintMaker);
         return [constraintMaker install];
     }
 
 
 
 在项目中的plist文件使用模拟器可以修改项目文件里边的内容
 使用真机的时候不能修改内容 只能进行读取
 
 在Documents里边自己创建的plist文件的这种真机模拟器均可以读写
 在模拟器中可以定位到的文件 可能在真机中就定位不到 比如说
 
 [NSHomeDirectory() stringByAppendingPathComponent:@"xxx.plist"]
 这个文件在模拟器中是和NSDocuments并列的目录下的
 但是在真机中就定位不到这个文件
 需要使用
 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"xxx.plist"];
 的这种方式来做 才能够定位到文件 如果没有的话才能够创建出来文件
 真机对了查看沙盒中的内容使用 Window -> Devices and Simulators -> 左侧的Devices -> 选中要看的App ->点击下方的+ - 后边的设置部分 ->Download Container即可下载相应的沙盒中的内容 -> 然后 显示包内容 就可以查看到相关的内容了
 学习网址：
 * 查看沙盒文件的软件：https://simpholders.com
 * https://www.cnblogs.com/fengtengfei/p/5090276.html
 
 * https://www.cnblogs.com/WayneLiu/p/4959515.html
 * https://www.jianshu.com/p/b37c1bcf8cdc
 * https://segmentfault.com/q/1010000004343510/a-1020000004347193
 

 
 * 2018年5月1日
 当忘记写相应的模型的实现文件的时候会报出如下错误：
 Undefined symbols for architecture arm64:
 "_OBJC_CLASS_$_xxxxModel", referenced from:
 objc-class-ref in superXXXXXModel.o
 ld: symbol(s) not found for architecture arm64
 clang: error: linker command failed with exit code 1 (use -v to see invocation)
 
可能原因 忘记写下边的内容：
 @implementation xxxxModel
 
 @end
 
 有的时候使用Postman 测试的时候返回结果就是有误
 这个时候不妨试试直接使用移动端设备 直接进行网络请求 试试接口是否有问题

 //友盟判断应用是否安装了
 **
 *  平台是否安装
 *
 *  @param platformType 平台类型 @see UMSocialPlatformType
 *
 *  @return YES 代表安装，NO 代表未安装
 *  @note 在判断QQ空间的App的时候，QQApi判断会出问题
 *
//-(BOOL) isInstall:(UMSocialPlatformType)platformType;

//地址：https://developer.umeng.com/docs/66632/detail/66825#h3--umsocialmanager

 
 2018年5月2日
 /**
 *  是否为同一天
 学习网址：https://blog.csdn.net/soindy/article/details/43817557

- (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    //    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

//打卡记录标识
static NSString * const kLastPunchDateString = @"lastPunchDate";

//仿钉钉打卡的时间的逻辑
if (![[NSUserDefaults standardUserDefaults]objectForKey:kLastPunchDateString]) {
    [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:kLastPunchDateString];
    [[NSUserDefaults standardUserDefaults]objectForKey:kLastPunchDateString];
    WWLog(@"打卡");
    //此处需要打卡
}else{
    NSDate *lastPunchDate = [[NSUserDefaults standardUserDefaults]objectForKey:kLastPunchDateString];
    //当前时间之后一天多的测试时间
    //        NSDate *testDifferentDate = [NSDate dateWithTimeIntervalSinceNow:25 * 60 * 60]
    BOOL sameDay = [self isSameDay:[NSDate date] date2:lastPunchDate];
    if (sameDay) {
        //是同一天的时候需要打卡
        WWLog(@"不需要打卡");
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:kLastPunchDateString];
        //不是同一天的时候 打卡
        WWLog(@"打卡");
    }
    
}
 
 
 上拉加载更多 下拉刷新的注意事项
 
 下拉刷新使用的是比较固定的内容 有起始页面 pageSize 这都是固定的 还有盛放cell的数据的数组直接赋值为当前请求到的数据就好
 
 上拉加载更多的时候需要注意的是 是否请求到了更多的数据
 首先是判断是否是进入页面后的第一次上拉加载更多
    如果是的话 起始页面currentPageNumber += 1;
 接下来的时候要根据请求到的结果数据来判断 是否需要 进行相应的 加 的操作
    如果没有数据的时候tableView的footer显示没有更多的数据显示了
    不然的话还是要进行数据的添加到可变数组
 问题：https://blog.csdn.net/youngstar70/article/details/78493272
 https://www.jianshu.com/p/2228515777ad
 
 可变数组不小心使用的copy修饰的造成的崩溃：
 http://www.cnblogs.com/isItOk/p/7498874.html
 复习类之间的循环引用问题：https://blog.csdn.net/jiangwei0910410003/article/details/41926369
 
 关于应用中特定界面横屏的问题：
 https://www.cnblogs.com/niit-soft-518/p/5611298.html
    我用的是博主的第二个方法，在需要横屏的时候写的相应的横屏设置
    在后边的退出来的界面中写的是竖屏幕的设置 并没有设置根控制器的方向问题
 
 发现一个问题是如果是在进入到全屏后隐藏导航栏的情况下可以避免pop回来时候的界面闪的问题
 配置可以可以Landscape Left  和 Portrait
 
 - (void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = YES;
     NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
     [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
 
     NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
     [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
 }
 
 //支持的方向 公共代码部分
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations
 {
    return UIInterfaceOrientationMaskLandscapeLeft;
    //在需要竖屏的视图控制器中写明UIInterfaceOrientationMaskPortrait
 
 }
 
 //是否可以旋转
 - (BOOL)shouldAutorotate
 {
    return YES;
 }
 
 
 
 视图拖动学习记录：
 
 
 
 使用touchesmoved的方法：
 https://blog.csdn.net/liu537192/article/details/44727413
 https://blog.csdn.net/long_ios/article/details/48024269
 手势的方法待测试
 https://blog.csdn.net/zhuming3834/article/details/49154305
 判断触摸点是否在某个视图内：
 https://blog.csdn.net/codingfire/article/details/53168856
 https://www.jianshu.com/p/39a7968c1e4a
 - (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
 /*
 UITouch *touch = [touches anyObject];
 
 // 当前触摸点
 CGPoint currentPoint = [touch locationInView:_label.superview];
 // 上一个触摸点
 CGPoint previousPoint = [touch previousLocationInView:_label.superview];
 
 // 当前view的中点
 CGPoint center = _label.center;
 
 center.x += (currentPoint.x - previousPoint.x);
 center.y += (currentPoint.y - previousPoint.y);
 // 修改当前view的中点(中点改变view的位置就会改变)
 _label.center = center;
 
 *********
 
UITouch *touch = [touches anyObject];

CGPoint point = [touch locationInView:self.view];
 //排除没有点击到目标视图的情况
    CALayer *targetLay = _label.layer.presentationLayer;
    if (!CGRectContainsPoint(targetLay.frame, point)) {
        WWLog(@"不包含在");
        return;
    }

边界控制
    CGFloat w =  _label.ww_width * 0.5;
    CGFloat h = _label.ww_height * 0.5;
    if (point.x < w) {
        point.x = w;
    }
    if (point.y < h) {
        point.y = h;
    }
    if (point.x > WW_WIDTH - w) {
        point.x = WW_WIDTH - w;
    }
    if (point.y > WW_HEIGHT - h) {
        point.y = WW_HEIGHT - h;
    }
    _label.center=point;
    }
 
 
 2018年5月4日
* 关于svn 控制的时候工具
     一不小心拖动了Xcode左侧的文件夹
     有些文件显示是红色的显示被删除了 被删除的文件重新添加一下
     导致某些文件在提交的时候显示是D删除了 为了避免问题 discard changes
 
 * 关于 .DS_Store 文件：
     (.DS_Store)避免多人提交代码到GitHub上起冲突
     https://www.zhihu.com/question/20345704
     https://blog.csdn.net/iOSTianNan/article/details/52414479
 
 * 关于学习MVVM RAC
     学习demo的时候：https://github.com/wanglongshuai/MVVM-RAC-Demo
     使用pod install的时候报出问题：
     [!] The dependency `Reachability (~> 3.2)` is not used in any concrete target
     是因为没有指定target
 
     target 'YiDing’ do
     [!] Invalid `Podfile` file: syntax error, unexpected end-of-input, expecting keyword_end.
     还要注意在结尾添加end
 
     接下来就可以正常的pod install 了
     pod install
     Re-creating CocoaPods due to major version update.
     Analyzing dependencies
     Downloading dependencies
     Installing AFNetworking (3.0.4)
     Installing CHTCollectionViewWaterfallLayout (0.9.2)
 
     选择pods 找到jsonkit complie Sources fno-objc-arc
     https://blog.csdn.net/litianpeng0624/article/details/46560739
     http://eric-gao.iteye.com/blog/2092269
     结合着上边的两种方式
     我没有修改isa为NO那个
 
 * 关于iPhoneX的横屏的时候的问题：
     最好还是要在根视图中写明 需要是竖屏的因为横屏模拟器启动的时候会出现横屏视图的问题
     注意iPhoneX的横屏
     https://www.jianshu.com/p/424521c4e3aa
     在横屏的时候如果是iPhoneX
     我在原来的基础上在右侧加了个24pt
 关于缓冲进度：
 方法一：
    https://blog.csdn.net/wsyx768/article/details/46697683
     https://blog.csdn.net/flg1554112450/article/details/71424970
     音频缓冲 在slider下方添加progressView
     设置progressView的数值
     设置slider的maxColor alpha为0 这样下方的progressView就能够漏出来了
     然后计算相关的进度loadedTimeRanges
     缓冲的进度是很快的就完成了可以注意打印相关内容
 
 方法二：
 
 2018年5月8日
 * UIWebView获取高度：https://bingozb.github.io/41.html
 * 应用打断事件处理 比如说电话中断:
    https://www.jianshu.com/p/014aa679424b
 * 关于curl：
    https://baike.baidu.com/item/curl/10098606?fr=aladdin
    https://curl.haxx.se
 * 图片拉伸： 防止变形：https://www.jianshu.com/p/aef225ae1502
 
 2018年5月9日
    上线问题：https://blog.csdn.net/u010008647/article/details/79214964
    UITextField的clear的代理方法：https://segmentfault.com/q/1010000004008814
    标签使用的问题：https://github.com/iThinkerYZ/YZTagList/issues/3
    在添加标签的时候需要先判断是否有相同的标签存在了
 
 * 解析HTML CSS 为NSAttributedString 然后显示出来
    使用DTCoreText:https://github.com/Cocoanetics/DTCoreText
    这个库看起来不是很容易应用到项目中：
    相关文章：
            * https://blog.cnbang.net/tech/2630/
            * https://www.jianshu.com/p/b09d3fa1cd98
                * 注意按照上边的这个文章进行操作的时候编译的时候不用指定开发者账号 Team处于None的状态就行 否则编译不出来相关的文件
                * 遇到的一个问题 can't move temporary file: /路径/FrameworkResource to file: /路径/FrameworkResource.lipo (Is a directory) 因为最后要写的是文件名字 不是文件路径
 * 崩溃问题：dyld: Library not loaded: @rpath/DTFoundation.framework/DTFoundation
 Referenced from: /路径/Library/Developer/CoreSimulator/Devices/58CA68C6-C98B-4621-A66C-F1831E7B6413/data/Containers/Bundle/Application/BA849A75-8E2B-4B61-8BCC-A51123C2B241/WWCollection.app/WWCollection
 Reason: image not found
            *
 
 2018年5月10日
 * 一个是看提供的文档:https://docs.cocoanetics.com/DTCoreText/docs/Setup%20Guide.html
 * 一个是看提供的demo:https://github.com/Cocoanetics/DTCoreText
 * 把demo跑通了就算是成功了一半记得是zzz老师说的哈哈
    * 关于DTCoreText:http://www.cnblogs.com/bucengyongyou/category/410341.html
    * 运行项目CoreText:http://www.cocoachina.com/bbs/read.php?tid=263789
 * 加载HTML的形式的demo使用过程中遇到的这个问题：https://github.com/Cocoanetics/DTCoreText/issues/1108
 * 类似的：https://stackoverflow.com/questions/2125543/setting-a-cgcontext-transparent-background
 * 图片网址：https://www.vcg.com/creative/search?utm_source=baidu&utm_medium=cpc&utm_campaign=%E9%80%9A%E7%94%A8%E8%AF%8D&utm_content=%E5%B9%BF%E6%B3%9B&utm_term=%E5%9B%BE%E7%89%87%E5%BA%93
 
 2018年5月11日
 让Mac OS Safari 显示出来网页源代码的方法
 使用Safari -> 偏好设置 -> 高级 -> 选中 在菜单栏中显示"开发”菜单
 * 触摸板上两个手指点击网页  -> 检查元素 即可
 * 当然也可以看看菜单栏中的 开发 的网页源代码的快捷键 Commond + option + u
 学习网址：https://blog.csdn.net/justinjing0612/article/details/8113377
 
 更多html转换为富文本的内容：
 * https://www.jianshu.com/p/029a5ef4e86a
 * https://www.jianshu.com/p/a620a2664f58
 * Url编解码：https://www.cnblogs.com/hanjun/archive/2013/05/02/3054667.html
 这个可能在取到html的时候其中有多个%号的时候会用到 把这些百分号去掉还原成原来的html的原来的样子
 像这种 %3C!DOCTYPE%20html%3E 转为<!DOCTYPE html>
    前端相关内容：https://blog.csdn.net/u012230055/article/details/42875253
 iOS中：
    str = [str stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
     或者
     str = [str stringByRemovingPercentEncoding];
 
 
    * 使用DTCoreText的时候遇到的问题：
 被坑的不轻。。。
 - (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes
 {

 }
    重要！！！！这个方法中写的maxImageSize 控制着图片的宽度高度
 
    如果被其中的maxImageSize限制着 即使是我们在
 - (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
 
 }
 这个方法中修改了imageSize 有的时候也不能使得图片得以改变
 需要做的操作是修改maxImageSize 的尺寸来作出限制的让步
 
 还有一点是使用DTCoreText的时候后不能给图片使用width = "100%" 的这种形式 否则的话图片显示不出来
 不过可以使用width="100px"
 
 关于FPS 和 切圆角需要考虑的点：
 https://zh.wikipedia.org/wiki/帧率
 https://baike.baidu.com/item/fps/3227416
 https://blog.ibireme.com/2015/11/12/smooth_user_interfaces_for_ios/
 https://github.com/ibireme/YYText/blob/master/Demo/YYTextDemo/YYFPSLabel.m
 https://github.com/Draveness/analyze/blob/master/contents/AsyncDisplayKit/提升%20iOS%20界面的渲染性能%20.md
 实属惭愧 圆角部分自己还没有处理好成没有离屏渲染的情况 不显示黄色的状况
 https://www.zhihu.com/question/19568972
 http://www.cocoachina.com/ios/20160301/15486.html
 
 在UITableView重用的时候如果错误地把不同的两种类型的cell重用了相同的重用标识 会造成的问题是当这个显示的结果是同一种类型的cell的样式
 
 
 iOS8 + :
 在这两个属性的控制下 不用去手动计算TableViewCell的高度了
 如自己所试的 在使用Masonry的时候自上而下进行约束的时候 不用去计算cell应该用多多少高度
 _automaticFitCellTableView.estimatedRowHeight = 100.f;
 _automaticFitCellTableView.rowHeight = UITableViewAutomaticDimension;
 学习网址：
 http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/
 https://www.jianshu.com/p/64f0e1557562
 
 当然给cell高度加个缓存会更好一些 示例Demo:
 https://github.com/forkingdog/UITableView-FDTemplateLayoutCell
 
 2018年5月15日
 //DTDefaultLineHeightMultiplier 这个属性用于控制行间距的倍数 默认1.0保持不变
 NSMutableDictionary *options  = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption,[NSNumber numberWithFloat:1.0f],DTDefaultLineHeightMultiplier,[NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
 @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];
 
//官方示例：
     NSDictionary* options = @{ NSTextSizeMultiplierDocumentOption: [NSNumber numberWithFloat: 1.0],
     DTDefaultFontFamily: @"Helvetica Neue",
     };
 
     NSString *html = @"<p>Some Text</p>";
     NSData* descriptionData = [html dataUsingEncoding:NSUTF8StringEncoding];
     NSAttributedString* attributedDescription = [[NSAttributedString alloc] initWithHTMLData:descriptionData options:options documentAttributes:NULL];
 
不过下边的高度的计算在图片指定宽度高度px的值的情况下 还准确一些 如果没有指定的话还需要自己多做一些图片高度的处理 得出结果(这部分自己还没有实现 只有实现过图片给定宽高的情况)
 * 计算DTAttributedTextCell 的高度的计算方法之一：
 参考文档：https://docs.cocoanetics.com/DTCoreText/docs/Programming%20Guide.html
     NSAttributedString *attributedString = ...
     DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
 
 //把此处的CGFLOAT_WIDTH_UNKNOWN 换成自己想要的即可 比如说固定高度 得高度的 就给定宽度
     CGRect maxRect = CGRectMake(10, 20, CGFLOAT_WIDTH_UNKNOWN, CGFLOAT_HEIGHT_UNKNOWN);
     NSRange entireString = NSMakeRange(0, [attributedString length]);
     DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:maxRect range:entireString];
 
     CGSize sizeNeeded = [layoutFrame frame].size;
 
 
 * 计算DTAttributedTextCell 的高度的计算方法之二：
 
     DTAttributedTextCell *dtAttriCell = [DTAttributedTextCell new];
     dtAttriCell.attributedTextContextView.attributedString = [self _attributedStringForSnippetUsingiOS6Attributes:NO htmlString:_htmlString];
 
     WWLog(@"所需高度:%f",[dtAttriCell requiredRowHeightInTableView:tableView]);
     return [dtAttriCell requiredRowHeightInTableView:tableView];
 参考内容：https://github.com/WaXiDe/ZSTestDemo
 

UIWebView 可以直接load html 字符串 而且遵守协议设置代理后也会调用相应的代理方法
 http://www.code4app.com/snippets/one/loadHTMLString加载HTML代码/50d27d666803fa922f000000
 
 
 2018年5月16日
 关于UIWebView的高度计算：
    https://bingozb.github.io/41.html
     CGFloat webH = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
     CGFloat webScrollH = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"]floatValue];
     self.webViewRealHeight = webScrollH;
     WWLog(@"webView加载完毕 高度 %f---%f",webH,webScrollH);
     WWLog(@"加载完webView高度%f",height);
 
 确实有的时候document.body.offsetHeight 比 document.body.scrollHeight 值小
 
 
 使用
 对于cell的抖动的问题可以考虑使用分散到不同的组来解决
 如果在同一个组里可能难免会有抖动
 有的时候在heightForRow中取- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 取出的cell有时候为nil 我测试了下大概情况，如果indexPath 是我们自己指定的
 如下列的方式：UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
 可能导致cell为nil
 还有一种方式是在TableView滚动的过程中
 发现在有的cell滚出了屏幕然后又滚回来的时候取到的cell也会为nil
 如果我们对cell中的某些量recordVal有需要的话可以定义一个静态常量staticVal记录下来需要的量
 当然其中有部分逻辑，先判断这个staticVal 是否和要记录的量都是0或者某个原始值
 
     if (cell.recordVal == 0 && staticVal == 0) {
        return 某个固定值;
     }
     if (staticVal != 0) {
        return staticVal + WW_PX_Height(99.f);
     }
        staticVal = cell.cell.recordVal;
     return introlCell.webViewRealHeight + WW_PX_Height(99.f);
 
 更多相关问题：https://stackoverflow.com/questions/5232849/cellforrowatindexpath-returns-nil
 
 * svn Couldn’t communicate with a helper application
 这种问题有的时候是因为有些文件加入了版本控制，但是后来又删除了文件，但是版本控制中的内容没有反应过来，这样提交的时候找不到被删除之前的文件报出的错误：解决办法是使用终端命令的方式来提交，会给出错误原因
 New Group' is scheduled for addition, but is missing
 像上边所说，我们找到这个New Group  文件，然后Discard Changes 之后再提交就可以了
 
 2018年5月17日
 
 Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of sections.  The number of sections contained in the table view after the update (1) must be equal to the number of sections contained in the table view before the update (1), plus or minus the number of sections inserted or deleted (0 inserted, 1 deleted).'
 
 Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of sections.  The number of sections contained in the table view after the update (0) must be equal to the number of sections contained in the table view before the update (1), plus or minus the number of sections inserted or deleted (0 inserted, 0 deleted).'
 https://stackoverflow.com/questions/21870680/invalid-update-invalid-number-of-rows-in-section-0
 删除TableView的某一行 或者某一组的时候记得更新相应的numberOfSections 以及numberofRows
 
 当我们要删除某一组里的最后的一个cell的时候要使用删除section的方法而不能使用常规的deleteRowsAtIndexPaths 否则会崩溃
 
     if (_checkStateArrayM.count == 0) {
     [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
     }else{
     [self.tableView deleteRowsAtIndexPaths:[indexPathArrM copy] withRowAnimation:UITableViewRowAnimationFade];
     }
 
 
 //此处应该倒着删除
     for (NSInteger i = indexPathArrM.count-1; i >= 0  ; i --) {
     [_checkStateArrayM removeObjectAtIndex:((NSIndexPath *)indexPathArrM[i]).row];
     }
 比如说 标记的序列为
    NO YES NO YES YES YES YES
NO YES NO YES YES YES YES       //从低到高
    NO YES NO YES YES YES YES   //从高到低 可以保持原来的样子
 
 
 从低到高 那么之前的第二个NO的位置变成了当前的YES的位置
 从高到低 可以保持原来的样子 这样删除的次序才不会乱
 那么如果我们按照从低到高删除出现 我们把带个
 下边的方式是有误的 比如说我们要删除 的索引有 0 2 那么当我们删除了0后，原来的2的位置现在已经往前挪动了 所以这个时候再去按照原来的位置去删除肯定会出问题
     //    for (NSInteger i = 0; i < indexPathArrM.count; i ++) {
     //        [_checkStateArrayM removeObjectAtIndex:((NSIndexPath *)indexPathArrM[i]).row];
     //    }
 
 
 更多相关内容：
 https://www.jianshu.com/p/1d82befe9988
 
 
 * 想要使用extern的话也需要是有相关的类的头文件已经引入过了才可以
 Why won't extern link to a static variable?：https://stackoverflow.com/questions/2841762/why-wont-extern-link-to-a-static-variable
 
 //比如在EOCTest类中 .h头文件中
 extern const NSTimerInterval EOCAnimatedViewAnimationDuration;
 //.m 文件中
 const NSTimeInterval EOCAnimatedViewAnimationDuration = 3.0;
 //那么import ECOTest头文件 的类就可以同样使用EOCAnimatedViewAnimationDuration了
 学习内容:Effective Objective-C 2.0编写高质量iOS与OSX的52个有效方法
 
 
 * 有的时候遇到一些奇怪的问题
 像滑块使用 CGRect来布局滑块的父视图的时候 滑块能够正常地做动画的操作
 但是使用Masonry来做约束滑块的父视图 的时候在有的时候却可能得不到预期的效果
 
 把A-Z字符放到的数组 中
     NSMutableArray* _azArrayM = [NSMutableArray arrayWithCapacity:26];
     for (NSInteger i = 0; i < 26; i ++) {
     [_azArrayM addObject: [NSString stringWithFormat:@"%c",(char)(65+i)]];
     }
 WWLog(@"%@",_azArrayM);
 学习地址：https://my.oschina.net/u/2555813/blog/802887
 
 //英文字母加一个 '#' 直接使用字符的形式的累计
     _azArrayM = [NSMutableArray arrayWithCapacity:27];
     for (char a = 'A'; a <= 'Z'; a ++) {
         [_azArrayM addObject: [NSString stringWithFormat:@"%c",a]];
     }
     [_azArrayM addObject:@"#"];
     WWLog(@"%@",_azArrayM);
 
 * UISearchBar的边框问题
 https://blog.csdn.net/u013346305/article/details/51802043
 设置背景图片后即可去除边框正常地显示
 searchBar.backgroundImage = [UIImage new];
 
 * 在Xcode9上边测试离屏渲染 给ImageView或者是UIView 设置cornerRadius 以及maskToBounds 已经不会引发离屏渲染了 给按钮在设置图片设置cornerRadius 以及maskToBounds的时候仍会引发离屏渲染
 
 * 对于类似通讯录似的Demo 在处理A-Z 中有的 多音字的排序 的时候想到一种思路是
 举例子来说比如说沈(shen) 吧 他是多音字 也念chen 那么如果系统当做chen排序的话就出错了
 在处理姓名的姓的时候先把文字的姓名中 姓 查看是否为 "沈"
    如果是的话 把这个字段替换掉 比如说用 "shen##" 吧
    然后当姓名中起码 按照姓 已经正常排序好后 再把 "shen##" 改变回 "沈"
    这算是一种解决多音字排序的办法
 
 学习网址：
 https://github.com/gsdios/GSD_WeiXin/blob/master/GSD_WeiXin(wechat)/Classes/Contacts/Host/SDContactsTableViewController.m
 https://blog.csdn.net/qq_29307685/article/details/51532147
 http://www.olinone.com/?p=131
 相关内容：
 https://github.com/jkpang/PPGetAddressBook
 https://github.com/liufan321/FFChineseSort
 
 2018年5月21日
     * 文本框的背景图片的拉伸处理：
         * 文档：https://developer.apple.com/documentation/uikit/uiimage/1624127-resizableimagewithcapinsets?language=objc
         * https://onevcat.com/2011/12/uiimage/
         * http://www.cnblogs.com/mjios/archive/2013/02/26/2934280.html
         * http://zhong871004.iteye.com/blog/2287009
         * http://m6830098.github.io/2015/09/06/UIEdgeInsetsMake/
         * https://blog.csdn.net/shimiso/article/details/41079847
         * https://blog.csdn.net/ecjtuhq/article/details/52204599
 代码的方式是：
    UIImage *textBackImg = [[UIImage imageNamed:@""] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 19, 6, 8) resizingMode:UIImageResizingModeStretch];
 指定CapInsets 的时候左边 下边 右边 要求还比较低 注意是 上边 写的时候多测试下来查看合适的值
 其实左边 下边 右边就像是指定了不拉伸的缩进的距离 上边的位置注意不要出现拉伸变形的情况
 
 关于打开热点的时候的可能遇到的视图偏移的问题留作备用 其实有的时候自己的App里边在对视图布局的时候 如果是滚动视图或者是参考着底部做的约束的话 即使视图向下偏移了 也不会影响正常使用 这里留下相关的内容备用：
     https://www.2cto.com/kf/201804/738685.html
     https://www.jianshu.com/p/f8efb79eab21
     https://www.jianshu.com/p/a3f31cb9a8a3
     https://blog.csdn.net/jeffasd/article/details/50667664
 
 2018年5月22日
 
     //[self.view setNeedsLayout];
     //[self.view layoutSubviews];
     [self.view layoutIfNeeded];
 
 在使用Masonry设置一个ImageView的布局的时候 使用top left bottom right 来进行约束的时候
 * 在 开始的设置图片 后来请求到数据后的图片更新的时候 不清楚是哪里出了问题
    在后来的设置了图片以后 图片比之前高了 遮挡了其他的时候
 * 使用Masonry布局完后frame还是为0
 * 解决办法 在给ImageView 布局完使用[self.view layoutIfNeeded] 解决的问题 不要直接使用layoutSubViews 使用setNeedsLayout不会有反应是因为不会立即重新布局子视图
 * 或者是在给ImageView布局的时候指定 top left 以及尺寸 来解决这个问题
 
 使用UIWebView 加载本地gif图的时候发现尺寸有误 本来设置的和屏幕一样的大小但是显示webView的尺寸过大了 使用了下边的这个属性 可以正常显示了
 webV.scalesPageToFit = YES;
 学习地址：http://www.cocoachina.com/bbs/read.php?tid-58789-page-1.html
 UIwebView 加载gif图
 https://developer.apple.com/documentation/uikit/uiwebview/1617941-loaddata?language=objc
 https://stackoverflow.com/questions/32084420/uiwebview-loaddata-is-not-accepting-nil-values-for-textencodingname-and-baseurl
 https://www.jianshu.com/p/767af9c690a3
 
 NSData *data = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"gitName" ofType:@"gif"]];
 UIWebView *webV = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
 [webV loadData:data MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:[NSURL new]];
 webV.scalesPageToFit = YES;
 [self.window addSubview:webV];
 [self.window bringSubviewToFront:webV];
 
 对于移除的时候要注意的是可以在代理方法中进行dispatch_after的计时操作 然后再移除 否则的话移除的时机难以把握
     - (void)webViewDidFinishLoad:(UIWebView *)webView{
            WWLog(@"加载完成");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 _webView.alpha = 0;
                 [_webView removeFromSuperview];
                 WWLog(@"移除");
             });
     }
 
 更改应用显示的名字：
 简单办法：
    info.plist文件中添加key：CFBundleDisplayName
    CFBundleDisplayName = "应用名称";
 学习地址：https://www.jianshu.com/p/a3a70f0398c4
 
 AFN有个问题待解决：
 Error Domain=AFNetworkingErrorDomain Code=-1011 “Request failed: method not allowed (405)”
 https://stackoverflow.com/questions/29789353/error-domain-afnetworkingerrordomain-code-1011-request-failed-method-not-allo
 类似的经历的有：https://blog.csdn.net/zkh90644/article/details/51497740
 
 解决了这个405的问题主要是请求的地址出现了问题 不小心把图片的地址当作请求的url传入了请求地址
 
     AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
     sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
     sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml",@"image/png",@"image/jpeg",@"application/json", nil];
     //GET
     [sessionManager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
 
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //这种情况下有的时候返回的responseObject为二进制的形式 这里之所以二进制的形式和sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer]; 这行代码有关系 若查看到数据[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil] 得到json形式的数据
     WWLog(@"%@",responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     WWLog(@"%@",error);
     }];
 
 废弃的方法
     NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
     NSData *dictData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
     //    [requestM setHTTPBody:dictData];
     [requestM setValue:@"token" forHTTPHeaderField:@"token"];
     [requestM setValue:@"fadsfadsf" forHTTPHeaderField:@"content"];
     [requestM setValue:imageURLStr forHTTPHeaderField:@"imageUrls"];
     [requestM setValue:self.courseID forHTTPHeaderField:@"courseId"];
 
     [requestM setHTTPMethod:@"POST"];
     NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
     [NSURLConnection sendAsynchronousRequest:requestM queue:operationQueue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
         if (connectionError) {
            WWLog(@"%@",connectionError);
         }else{
            WWLog(@"%@",response);
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            WWLog(@"--%@",dict);
        }
     }];
 
 
 
 相关内容：
 //    [manager.requestSerializer setValue:@"application/xml"forHTTPHeaderField:@"Content-Type"];
 //    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
 
 
 * 关于字典取值的防治崩溃的问题：
        * 奔溃示例：[NSNull objectForKeyedSubscript:]
            * http://www.cocoachina.com/ios/20161110/18036.html
            * http://tech.glowing.com/cn/how-we-made-nsdictionary-nil-safe/
            * https://blog.csdn.net/zwl492454828/article/details/52163271
            * https://blog.csdn.net/kyfxbl/article/details/44538803
 * 看看第三方是怎么实现的：
    * https://blog.csdn.net/u010231453/article/details/51424115
 
 
 关于压缩拉伸的设置
 https://www.jianshu.com/p/e38157d7b828
 
 关于UITextFiled的一个问题：难道是汉字的文本框比较宽 闪动的光标比较大 而英文的闪动的光标比较小？
 还有一个1011外加一个405是请求地址有问题导致的
 注意调试的时候不仅仅要看请求参数还要看看请求的地址是否有误
 注意fileName 后边的图片名字的后缀 .jpg 不能掉了 否则会报错String index out of range:-1
  [formData appendPartWithFileData:data name:@"imgName" fileName:@"-imgFile.jpg"  mimeType:@"image/jpeg"];
 
 
 了解关于Feed流和NLP:
    * http://www.woshipm.com/tag/feed流
    * https://www.zhihu.com/question/20690652
    * https://juejin.im/post/5a090c3c518825320476b3b1
 NLP:
    * https://zh.wikipedia.org/wiki/自然语言处理
    * https://www.zhihu.com/question/19929473
 
 2018年5月27日
 * pop到指定控制器：
    * 带有导航的控制器再push和pop的时候分别对应的是视图控制器入栈和出栈的操作 所以可以通过self.navigationController.viewControllers 获取到当前的栈中的控制器 那么遍历这些控制器就可以找到想要pop到的那一个控制器
    * 学习网址： https://cnbin.github.io/blog/2015/09/18/uinavigationcontroller-fan-hui-de-fang-fa-hui-zong/
    * https://www.jianshu.com/p/8f385b8a693e
 for (UIViewController *viewController in self.navigationController.viewControllers) {
     //isKindOfClass 判断的是当前的视图控制器是否是后边的类的实例或者子类的实例
     if ([viewController isKindOfClass:[JYZLoginViewController class]]) {
         [self.navigationController popToViewController:viewController animated:YES];
     }
 
     if ([viewController isMemberOfClass:[JYZLoginViewController class]]) {
         ////isMemberOfClass 判断的是当前的视图控制器是否是后边的类的实例
         [self.navigationController popToViewController:viewController animated:YES];
    }
    //选择适合自己的那个就好
 }
 
 
 像这种链接错误的问题 原因可能在于在重复定了了 一些类
 有的时候不是显而易见的
 比如说有的时候model中嵌套了model
 然后自己在创建新的类的时候 可能起的名字在已有的类中已经存在了同名的类
 这种情况是一种连接编译失败的原因之一 这种还是比较简单的 还有比较简单的像 引入头文件.h的时候写成了.m
 4 duplicate symbols for architecture arm64
 clang: error: linker command failed with exit code 1 (use -v to see invocation)
 
     //UICollectionView中数据比较少的时候发现即使设置contentSize很大仍然不能改变能够滚动
     _collectionView.contentSize = CGSizeMake(1000.f, 1000.f);
     //使用下边的属性可以控制是否能够滚动
     _collectionView.alwaysBounceVertical = YES;
学习网址：
    https://blog.csdn.net/majiakun1/article/details/50721826
 
 2018年5月28日
 * 为键盘添加完成：
    * https://www.jianshu.com/p/db3596d211db
     * WYWTextField *textField = [WYWTextField new];
     textField.backgroundColor = [UIColor blueColor];
     textField.borderStyle = UITextBorderStyleRoundedRect;
     textField.backgroundColor = [UIColor lightGrayColor];
     [self.view addSubview:textField];
     textField.placeholder = @"占位文字";
     [textField mas_makeConstraints:^(MASConstraintMaker *make) {
     //        make.left.right.equalTo(self.view);
     make.left.equalTo(self.view).mas_offset(20.f);
     make.right.equalTo(self.view).mas_offset(-20.f);
     make.height.mas_equalTo(40.f);
     make.top.equalTo(self.view).mas_offset(100.f);
     }];
 
     UIToolbar *keyboardToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40.f)];
     textField.inputAccessoryView = keyboardToolbar;
     UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
     UIBarButtonItem *completeItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeBarButtonItemClick:)];
     keyboardToolbar.items = @[spaceItem,completeItem];
     //同样 像 UISearchBar 视图(因为UISearchBar视图中也有UITextField) 也可以设置完成 或者是取消
     UISearchBar *searchBar = [UISearchBar new];
     searchBar.inputAccessoryView = keyboardToolbar;
 
 * 关于UITextFiled设置了rightView的时候发现光标太靠左了 解决办法重写UITextField的
    *textRectForBounds 和editingRectForBounds
     #import "WYWTextField.h"
 
     //偏移量
     static CGFloat const kOffsetX = 5.0f;
     @implementation WYWTextField
 
     //这种尤其会在UITextField显示了rightView影响输入光标的位置
     - (CGRect)textRectForBounds:(CGRect)bounds{
     //使用CGRectInset的时候当使用的缩进的值比较大的时候会崩溃还没有发现问题。。returned NaN for an intrinsicContentSizeDimension. Using UIViewNoIntrinsicMetric instead.
 
     //    return CGRectInset(bounds, 50.f, 0);
     return CGRectMake(bounds.origin.x + kOffsetX, bounds.origin.y, bounds.size.width - kOffsetX, bounds.size.height);
     }
 
     - (CGRect)editingRectForBounds:(CGRect)bounds{
     //看起来是两侧都会往里边缩进
     //        return CGRectInset(bounds, 50.f, 0);
     return CGRectMake(bounds.origin.x + kOffsetX, bounds.origin.y, bounds.size.width - kOffsetX, bounds.size.height);
 
     }
 学习网址:
 https://blog.csdn.net/wangfeng2500/article/details/50176869
 https://www.jianshu.com/p/f93b005dc9d4
 
* 关于音频倍速：
    * 其实对于音频的倍速播放的这种一般设置个 0.75 - 1.0 （以0.25为单位递增到1.75就可以了）市面上好多的App都是这么做的 像喜马拉雅 慕课网 极客时间等
 
 2018年5月29日
    * nil / Nil / NULL / NSNull：
        * http://nshipster.cn/nil/
        * http://blog.sina.com.cn/s/blog_9922bc340101erg2.html
    [NSNull null] 可以用以判断字典中的value是否为null
 像下边的这种情况 自己模拟的地方还有些许不对 有的时候服务器返回的value为空的时候取值会直接崩溃
     NSDictionary *dict = dict = @{
     @"a":@{
     @"b":[NSNull null]
     }
     };
 
 
     if([dict[@"a"][@"b"] class] == [NSNull class]){
     WWLog(@"");
     }
     if(dict[@"a"][@"b"] == [NSNull null]){
     WWLog(@"value为空");
     }
    * 项目管理软件：
        * https://www.atteam.cn/project.html?bd-xmglrj1
        * 禅道：https://www.testin.cn/task_function/list_bug.htm
 
    *
 
 
 2018年5月30日
     * 使用NSUserDefaults 存储的value 为NSNumber类型的
         po [someString class]
         NSTaggedPointerString
 
         (lldb) po [someUserValue class]
         __NSCFNumber
         所以isEqualToString判断并不相等
 
 
    * 遇到了一个这个问题还不知道怎么解决：
     com.alamofire.error.serialization.response Code=-1011 "Request failed: internal server error (500)" UserInfo={NSLocalizedDescription=Request failed: internal server error (500),
     使用postman 会返回code码
     使用手机的时候调用到了错误的部分
 
    * 类似朋友圈评论的部分 学习了GSD_WeiXin(wechat) 发现作者是使用的属性字符串来处理的评论部分
        *    from 发送方
             to 被回复的方
             都是使用的有颜色的属性字符串
        *   而其他的回复  以及回复内容的部分都是使用的普通的属性字符串的内容
 
 
    * 这个可以控制内容 有的时候UITableView中有间隔的时候 section有组间距的时候 使用MBProgressHUD 提示框可能会显示的有些部分断开的样子或者说是一种分割开的样子 使用keyWindow就没事了
    [[UIApplication sharedApplication].keyWindow showTextNoActivity:@“” timeLength:2.0f];
 
 2018年5月31日
    * 关于悬浮视图 其实有的时候可能这个悬浮视图上边有的部分还需要我们进行时间的处理
        这个时候就不仅仅需要把悬浮视图当作一个整体来进行拖动悬浮考虑
        还需要思考的是 对于那些可以接受时间处理的部分(按钮的时间操作还好 如果是slider这种的就需要特殊照顾特殊处理了)
    在- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{ 中
 
         CALayer *sliderLayer = slider.layer.presentationLayer;
         if (CGRectContainsPoint(sliderLayer.frame, point)) {
             WWLog(@"排除slider部分");
             return;
         }
 
    * 编解码平台：
        http://web.chacuo.net/charseturlencode
    * 如果是html的编码后的内容得到后展示的话再考虑使用下列网站展现
        http://www.w3school.com.cn/tiy/t.asp?f=html_basic
 
 //是在此处设置的多个label的内部分 把所有的回复的label 都加到了一个数组中 然后对数组中的label依次进行布局的操作
 
 学习GSD_WeiXin(wechat)的时候不知道作者是怎么布局多条评论的 后来发现 作业是拿到了评论的数量之后 创建了相应的评论的个数的label 然后放入数组中 并且分别对数组中的label进行布局
 相关的代码在：SDTimeLineCellCommentView文件中
 方法 - (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
 {

     其实作者是用的把多个回复的label都放到了一个数组中 然后对数组中的label依次进行的布局的操作
     lastTopView 用于记录上边的参考视图
     而且后边的时候每次设置的top依赖于上次的label
     第一次的设置的label的时候因为没有上一个label 这个时候lastTopView 为nil
 
     相关的实例有：
     po lastTopView
     <MLLinkLabel: 0x7fdcf1c13e00; baseClass = UILabel; frame = (0 0; 0 0); text = 'GSD_iOS：真有意思啊你💢💢💢'; gestureRecognizers = <NSArray: 0x604000256830>; layer = <_UILabelLayer: 0x60400008e560>>
 
     (lldb) po label
     <MLLinkLabel: 0x7fdcf1c1ef20; baseClass = UILabel; frame = (0 0; 0 0); text = '风口上的猪：我勒个去，啥世道啊'; gestureRecognizers = <NSArray: 0x6040002564a0>; layer = <_UILabelLayer: 0x6040000990a0>>
 
     测试这部分的时候如果感觉使用cell将要出现的时候加载数据可能不大容易测试的话 可以考虑在第一个朋友圈的位置多写几条评论 然后相当于一进入到界面就会调用相关的方法
 
 关于调试：https://developer.apple.com/cn/support/debugging/
 
 除了打全局断点定位bug 也可以在可能发生错误的位置使用断言以便定位bug
 还有依次打断点观察
 #define NSAssert(condition, desc, ...)
 Description
 Generates an assertion if a given condition is false.
 断言的使用当第一个参数的为 false的时候输出后边的描述信息 便于测试
 
 NSString *str = nil;
 NSAssert(str != nil, @"str 不能为空");
 
 
     NSString *str;
     [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSCharacterSet *set;
     [str stringByAddingPercentEncodingWithAllowedCharacters:set];
     //    NSCharacterSet *set;
 学习地址：
 http://nshipster.cn/nscharacterset/
 https://stackoverflow.com/questions/29806098/nscharacterset-urlhostallowedcharacterset-doesnt-replace-sign
 http://www.cnblogs.com/hanjun/archive/2013/05/02/3054667.html
 https://blog.csdn.net/chenyufeng1991/article/details/50060061
 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
 
 
    * 改变按钮的文字和图片的位置
    如果是左右的位置的改变主意左右要一致
     UIButton *btn;
     CGFloat imageOffsetX = btn.imageView.ww_left;
     btn.imageEdgeInsets = UIEdgeInsetsMake(0, -imageOffsetX, 0, imageOffsetX);
     CGFloat titleLblOffsetX = btn.ww_width - playAllBtn.titleLabel.ww_right;
     btn.titleEdgeInsets = UIEdgeInsetsMake(0, titleLblOffsetX, 0, -titleLblOffsetX);
 
 */







#endif /* ReadMe_h */
