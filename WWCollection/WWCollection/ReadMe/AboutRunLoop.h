//
//  AboutRunLoop.h
//  WWCollection
//
//  Created by WYW on 2018/6/21.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#ifndef AboutRunLoop_h
#define AboutRunLoop_h

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.

#endif /* AboutRunLoop_h */

/*
 
 学习网址：
 https://blog.csdn.net/yangyangzhang1990/article/details/45969951
 https://blog.csdn.net/hbblzjy/article/details/73543844
 
 最近想了解下 RunLoop的一些内容发现 左侧的调用堆栈的显示部分不全有省略 找到了下边的办法查看相关信息
 打断点后： 查看调用堆栈情况的办法 使用LLDB：
 po [NSThread callStackSymbols]
 可以查看到调用堆栈的情况
 
 po [NSThread callStackSymbols]
         <_NSCallStackArray 0x60c00005e6f0>(
         0   ???                                 0x0000000121585ecb 0x0 + 4854406859,
         1   WWCollection                        0x00000001010ec3d0 main + 0,
         2   UIKit                               0x0000000104cd0e2f -[UIScrollView(UIScrollViewInternal) _notifyDidScroll] + 68,
         3   UIKit                               0x0000000104cb6e87 -[UIScrollView setContentOffset:] + 493,
         4   UIKit                               0x0000000104d23399 -[UITableView setContentOffset:] + 362,
         5   Foundation                          0x0000000103703cb8 -[NSObject(NSKeyValueObservingPrivate) _changeValueForKeys:count:maybeOldValuesDict:usingBlock:] + 701,
         6   Foundation                          0x00000001035eec4f -[NSObject(NSKeyValueObservingPrivate) _changeValueForKey:key:key:usingBlock:] + 61,
         7   Foundation                          0x00000001036ac414 _NSSetPointValueAndNotify + 288,
         8   UIKit                               0x0000000104cd7423 _UIScrollViewAdjustForOverlayInsetsChangeIfNecessary + 687,
         9   UIKit                               0x0000000104cd7783 -[UIScrollView(UIScrollViewInternal) setSafeAreaInsets:] + 399,
         10  UIKit                               0x0000000104d73485 -[UIViewController _updateViewSafeAreaInsetsAndEagerlyUpdateContentScrollView:] + 138,
         11  UIKit                               0x0000000104d73cc7 -[UIViewController _setContentOverlayInsets:andLeftMargin:rightMargin:] + 914,
         12  UIKit                               0x0000000104d75d57 __121-[UIViewController __updateContentOverlayInsetsWithOurRect:inBoundsOfAncestorViewController:viaImmediateChildOfAncestor:]_block_invoke + 534,
         13  UIKit                               0x0000000104d75ac6 -[UIViewController __updateContentOverlayInsetsWithOurRect:inBoundsOfAncestorViewController:viaImmediateChildOfAncestor:] + 4099,
         14  UIKit                               0x0000000104d748f0 -[UIViewController _updateContentOverlayInsetsFromParentIfNecessary] + 713,
         15  UIKit                               0x0000000104d73fd9 -[UIViewController _updateContentOverlayInsetsForSelfAndChildren] + 100,
         16  UIKit                               0x0000000104d81b3c -[UIViewController _updateLayoutForStatusBarAndInterfaceOrientation] + 1022,
         17  UIKit                               0x0000000104d87920 -[UIViewController viewDidMoveToWindow:shouldAppearOrDisappear:] + 1208,
         18  UIKit                               0x0000000104c9f05e -[UIView(Internal) _didMoveFromWindow:toWindow:] + 1515,
         19  UIKit                               0x0000000104cb8a81 -[UIScrollView _didMoveFromWindow:toWindow:] + 84,
         20  UIKit                               0x0000000104c9ed84 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 785,
         21  UIKit                               0x0000000104c911e1 __45-[UIView(Hierarchy) _postMovedFromSuperview:]_block_invoke + 151,
         22  UIKit                               0x0000000104c910c8 -[UIView(Hierarchy) _postMovedFromSuperview:] + 828,
         23  UIKit                               0x0000000104ca1cbd -[UIView(Internal) _addSubview:positioned:relativeTo:] + 1973,
         24  UIKit                               0x000000010513d3c1 -[UINavigationTransitionView transition:fromView:toView:] + 616,
         25  UIKit                               0x0000000104dc7f6d -[UINavigationController _startTransition:fromViewController:toViewController:] + 3278,
         26  UIKit                               0x0000000104dc844f -[UINavigationController _startDeferredTransitionIfNeeded:] + 841,
         27  UIKit                               0x0000000104dc96d3 -[UINavigationController __viewWillLayoutSubviews] + 150,
         28  UIKit                               0x00000001050244e2 -[UILayoutContainerView layoutSubviews] + 231,
         29  UIKit                               0x0000000104ca8a6d -[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 1439,
         30  QuartzCore                          0x00000001047c961c -[CALayer layoutSublayers] + 159,
         31  QuartzCore                          0x00000001047cd7ad _ZN2CA5Layer16layout_if_neededEPNS_11TransactionE + 401,
         32  QuartzCore                          0x000000010475486c _ZN2CA7Context18commit_transactionEPNS_11TransactionE + 364,
         33  QuartzCore                          0x0000000104781946 _ZN2CA11Transaction6commitEv + 500,
         34  UIKit                               0x0000000104bf226a __34-[UIApplication _firstCommitBlock]_block_invoke_2 + 141,
         35  CoreFoundation                      0x00000001026e705c __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__ + 12,
         36  CoreFoundation                      0x00000001026cb83b __CFRunLoopDoBlocks + 203,
         37  CoreFoundation                      0x00000001026cb014 __CFRunLoopRun + 1300,
         38  CoreFoundation                      0x00000001026ca889 CFRunLoopRunSpecific + 409,
         39  GraphicsServices                    0x000000010c4039c6 GSEventRunModal + 62,
         40  UIKit                               0x0000000104bd75d6 UIApplicationMain + 159,
         41  WWCollection                        0x00000001010ec43f main + 111,
         42  libdyld.dylib                       0x000000010a46dd81 start + 1,
         43  ???                                 0x0000000000000001 0x0 + 1
         )
 
 (lldb) po [NSThread callStackReturnAddresses]
         <_NSCallStackArray 0x604000054f70>(
         4854406907,
         4312712144,
         4375514671,
         4375408263,
         4375851929,
         4352654520,
         4351519823,
         4352295956,
         4375540771,
         4375541635,
         4376179845,
         4376181959,
         4376190295,
         4376189638,
         4376185072,
         4376182745,
         4376238908,
         4376262944,
         4375310430,
         4375415425,
         4375309700,
         4375253473,
         4375253192,
         4375321789,
         4380152769,
         4376526701,
         4376527951,
         4376532691,
         4379002082,
         4375349869,
         4370241052,
         4370257837,
         4369762412,
         4369946950,
         4374602346,
         4335759452,
         4335646779,
         4335644692,
         4335642761,
         4500502982,
         4374492630,
         4312712255,
         4467383681,
         1
         )
 
 (lldb) thread info
     thread #1: tid = 0xc81f9c, 0x00000001010fd0ba WWCollection`-[TestMJTableViewController scrollViewDidScroll:](self=0x00007febc28076f0, _cmd="scrollViewDidScroll:", scrollView=0x00007febc4003400) at TestMJTableViewController.m:183, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
 
 (lldb) thread info 1
     thread #1: tid = 0xc81f9c, 0x00000001010fd0ba WWCollection`-[TestMJTableViewController scrollViewDidScroll:](self=0x00007febc28076f0, _cmd="scrollViewDidScroll:", scrollView=0x00007febc4003400) at TestMJTableViewController.m:183, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
 
 (lldb) thread info 2
 thread #2: tid = 0xc8209a, 0x000000010a8866da libsystem_kernel.dylib`__workq_kernreturn + 10
 
 (lldb) thread info 3
 thread #3: tid = 0xc8209b, 0x000000010a8866da libsystem_kernel.dylib`__workq_kernreturn + 10
 
 (lldb) thread info 4
 thread #4: tid = 0xc8209c, 0x000000010a8866da libsystem_kernel.dylib`__workq_kernreturn + 10
 
 (lldb) thread info 5
 thread #5: tid = 0xc8209d, 0x000000010a8bbc40 libsystem_pthread.dylib`start_wqthread
 
 (lldb) thread info 6
 thread #6: tid = 0xc8209e, 0x000000010a87ce76 libsystem_kernel.dylib`mach_msg_trap + 10, name = 'com.apple.uikit.eventfetch-thread'
 
 (lldb) thread info 7
 error: no thread with index: "7"
 (lldb) thread info 8
 thread #8: tid = 0xc820b7, 0x000000010a885e7e libsystem_kernel.dylib`__psynch_cvwait + 10
 
 (lldb) thread info 9
 thread #9: tid = 0xc820b8, 0x000000010a885eae libsystem_kernel.dylib`__psynch_mutexwait + 10, name = 'WebThread'
 
 */
