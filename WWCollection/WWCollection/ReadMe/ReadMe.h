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
 
 
 
 

 
 
 */


#endif /* ReadMe_h */
