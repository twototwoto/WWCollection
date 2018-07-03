//
//  NSObject+RuntimeWYWAdd.h
//  WWCollection
//
//  Created by WYW on 2018/7/3.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//学习地址：https://www.jianshu.com/p/35971a7e8bf6
/**
 * 其中IvarList 标识 Instance Variable List
 */
#import <Foundation/Foundation.h>

@interface NSObject (RuntimeWYWAdd)

/**
 获取实例变量 包括 属性 生成的实例变量
 */
+ (NSArray *)wyw_fetchIvarList;

/**
 获取类的属性列表 包括 私有属性 公有属性 分类中的属性
 */
+ (NSArray *)wyw_fetchPropertyList;

/**
 获取实例方法列表 包括setter getter  方法等
 */
+ (NSArray *)wyw_fetchInstanceMethodList;

/**
 获取类方法列表
 */
+ (NSArray *)wyw_fetchClassMethodList;

/**
 获取协议列表 包括.h .m 分类中的
 
 */
+ (NSArray *)wyw_fetchProtocolList;

/**
 添加一个方法
 
 */
+ (void)wyw_addMethod:(SEL)methodSel methodImp:(SEL)methodImp;
/**
 实例方法交换
 */
+ (void)wyw_swapInstanceMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;
/**
 类方法交换
 */
+ (void)wyw_swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;


@end
