//
//  NSDate+WYWAdd.m
//  WWCollection
//
//  Created by WYW on 2018/4/20.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "NSDate+WYWAdd.h"

@implementation NSDate (WYWAdd)

+ (NSString *)wyw_zeroDateStringOf:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *zeroDate = [calendar startOfDayForDate:date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss a";
    return [dateFormatter stringFromDate:zeroDate];
}
@end
