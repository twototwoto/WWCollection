//
//  NSDate+WYWAdd.h
//  WWCollection
//
//  Created by WYW on 2018/4/20.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
//学习网址：https://blog.csdn.net/jasonblog/article/details/21977481

#import <Foundation/Foundation.h>

@interface NSDate (WYWAdd)


/**
 获取指定NSDate的0点

 @param date 指定的date
 @return 返回指定date的0点dateString
 */
+ (NSString *)wyw_zeroDateStringOf:(NSDate *)date;
@end
