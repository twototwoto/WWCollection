//
//  WYWDateTimeViewController.m
//  WWCollection
//
//  Created by WYW on 2018/6/30.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//
/**
 * 学习地址：
 * https://blog.csdn.net/biggercoffee/article/details/50177597
 * http://www.cnblogs.com/pengyingh/articles/2354343.html
 * 关于localIdentifier:https://gist.github.com/jacobbubu/1836273
 https://www.cnblogs.com/wfwenchao/articles/4045785.html
 *
 */

#import "WYWDateTimeViewController.h"
#import "WYWTimerCycleDemoViewController.h"

#import "NSDate+WYWAdd.h"

static NSTimeInterval const kTotalTimeSeconds = 2.f * 60.f * 60.f;
static NSTimeInterval const kEarlyTimeSeconds = 6.f * 60.f * 60.f;
static NSTimeInterval const kLateTimeSeconds = 8.f * 60.f * 60.f;


@interface WYWDateTimeViewController ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation WYWDateTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *zeroDateString = [NSDate wyw_zeroDateStringOf:[NSDate date]];
    //2018-06-30 16:00:00 +0000 打印结果默认是这种形式
    //输出结果：2018-07-01 00:00:00 上午
    
    WWLog(@"%@",zeroDateString);
    return;
    
    [self daysBetweenDate];
    return;
    [self splitDate];
    
    return;
    [self AMPMTime];
    [self dateTimeTest];
//    [self dateTimeDemo];
    [self timerDemo];
    [UIFont fontWithName:@"" size:2.f];
}

#pragma mark - 某两个日期之间的每天的日期加入到数组中
- (void)daysBetweenDate{
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSDateComponents *beginDateComponents = [NSDateComponents new];
    beginDateComponents.year = 2018;
    beginDateComponents.month = 5;
    beginDateComponents.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //起始日期
    NSDate *beginDate = [calendar dateFromComponents:beginDateComponents];
    
    //结束日期
    NSDate *endDate = [[NSCalendar currentCalendar]startOfDayForDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy/MM/dd";

    
    NSDate *tempDate = beginDate;
    [arrM addObject:tempDate];
    
    NSDateComponents *perDayComponent = [NSDateComponents new];
    perDayComponent.year = 0;
    perDayComponent.month = 0;
    perDayComponent.day = 1;
    
    while (![tempDate isEqual:endDate]) {
        NSString *dateStr = [dateFormatter stringFromDate:tempDate];
        [arrM addObject:dateStr];
        tempDate = [calendar dateByAddingComponents:perDayComponent toDate:tempDate options:0];
    }
    
    WWLog(@"%@",arrM);
    
    
}

#pragma mark - 想要做遍历日历的操作
- (void)splitDate{
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.year = 2018;
    dateComponents.month = 5;
    dateComponents.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    NSDateComponents *perDayComponent = [NSDateComponents new];
    perDayComponent.year = 0;
    perDayComponent.month = 0;
    NSInteger day = 0;
    NSDate *nextDayDate = [calendar dateByAddingComponents:perDayComponent toDate:date options:0];
    NSString *nextDayStr = [dateFormatter stringFromDate:nextDayDate];
    WWLog(@"");
    WWLog(@"%@",[NSDate date]);
    NSMutableArray *arrM = [NSMutableArray array];
    while (day++ < 20) {
        perDayComponent.day = day;
        nextDayDate = [calendar dateByAddingComponents:perDayComponent toDate:date options:0];
        nextDayStr = [dateFormatter stringFromDate:nextDayDate];
        [arrM addObject:nextDayStr];
        
    }
    WWLog(@"%@",[NSDate date]);
    WWLog(@"%@",arrM);
    

    
    WWLog(@"%@",nextDayStr);
    
    WWLog(@"%@",date);
//    [NSDate date];
    
}

#pragma mark - AMPM 的显示
- (void)AMPMTime{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm a";
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    //2018-07-01 15:12 PM
    
    NSString *AMPMStr = dateFormatter.dateFormat = @"a";
    //    [dateFormatter setAMSymbol:@"AM"];
    //    [dateFormatter setPMSymbol:@"PM"];
    
    
    WWLog(@"%@",timeStr);
    
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [_timer invalidate];
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [_timer invalidate];
//}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [_timer setFireDate:[NSDate date]];
    
//    return;
    WYWTimerCycleDemoViewController *timerCycleDemoVC = [WYWTimerCycleDemoViewController new];
    [self.navigationController pushViewController:timerCycleDemoVC animated:YES];
}

- (void)dealloc{
    WWLog(@"dealloc");
}

- (void)timerAction:(id)sender{
    WWLog(@"timerAction");
}

- (void)timerDemo{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    [timer setFireDate:[NSDate distantFuture]];
//    [timer fire];
//    [NSTimer timerWithTimeInterval:3.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
//
//    }];
    
    
}

- (void)dateTimeDemo{
    
    NSDate *currentDate = [NSDate date];
    //Sat Jun 30 12:04:41 2018
    //如果是模拟器currentDate 2018-06-30 04:07:43 +0000
    
    NSDateFormatter *currentDateFormatter = [[NSDateFormatter alloc]init];
    currentDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *currentDateStr = [currentDateFormatter stringFromDate:currentDate];
    // po currentDateStr 2018-06-30 12:06
    
    WWLog(@"%@",currentDate);
    NSTimeInterval durationTimeInterval = [currentDate timeIntervalSinceDate:currentDate];
    
    //https://blog.csdn.net/soindy/article/details/45268847
    //https://blog.csdn.net/DynastyTing/article/details/51889213
    
    
}


- (void)clockTimerAction:(id)sender{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    //    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    NSDate *startCurrentCalendarDate = [[NSCalendar currentCalendar]startOfDayForDate:[NSDate date]];
    NSString *startCurrentCalendarDateStr = [dateFormatter stringFromDate:startCurrentCalendarDate];
    NSDate *earlyDate = [NSDate dateWithTimeInterval:kEarlyTimeSeconds sinceDate:startCurrentCalendarDate];
    NSString *ealyDateStr = [dateFormatter stringFromDate:earlyDate];
    
    NSDate *lateDate = [NSDate dateWithTimeInterval:kLateTimeSeconds sinceDate:startCurrentCalendarDate];
    NSString *lateDateStr = [dateFormatter stringFromDate:lateDate];
    //比较结果
    NSComparisonResult compareResult = [currentDate compare:earlyDate];
    if (compareResult == NSOrderedAscending) {
//        self.morningView.clockShapeLayer.strokeEnd = 0.f;
        return;
    }else{
        compareResult = [currentDate compare:lateDate];
        if (compareResult == NSOrderedDescending) {
//            self.view.clockShapeLayer.strokeEnd = 1.f;
            return;
        }
        //中间的内容
        NSTimeInterval duartion = [currentDate timeIntervalSinceDate:earlyDate];
        CGFloat ratio = duartion / kTotalTimeSeconds;
//        self.morningView.clockShapeLayer.strokeEnd = ratio;
        //(arc4random() % 1000)/1000.f;
    }
}

- (void)dateTimeTest{
    //2018-06-30 02:39:08 +0000 打印出的当前时间
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    WWLog(@"%@",currentDateStr);
    
    //总的时间
    NSTimeInterval kTotalTimeSeconds = 2.f * 60.f * 60.f;
    
    /*
    //确定出来 这一天的04:30 以及这一天的 06:30
    NSDate *earlyDate = [NSDate date];
    NSDateFormatter *earlyDateFormatter = [NSDateFormatter new];
    earlyDateFormatter.dateFormat = @"yyyy-MM-dd HH:MM";
    NSString *ealyDateStr = [earlyDateFormatter stringFromDate:earlyDate];
    WWLog(@"%@--%@-%@",currentDate,earlyDate,ealyDateStr);
    */
    //想要获取到当天的某个时间
    NSCalendar *currentDayCalendar = [NSCalendar currentCalendar];
    //获取当天 0 点 https://blog.csdn.net/DynastyTing/article/details/51889213
    NSDate *startCurrentCalendarDate = [[NSCalendar currentCalendar]startOfDayForDate:[NSDate date]];
    NSString *startCurrentCalendarDateStr = [dateFormatter stringFromDate:startCurrentCalendarDate];
    
    CGFloat earlyTimeInterval = 4.5f * 60.f * 60.f;
    NSDate *earlyDate = [NSDate dateWithTimeInterval:earlyTimeInterval sinceDate:startCurrentCalendarDate];
    NSString *ealyDateStr = [dateFormatter stringFromDate:earlyDate];
    
    NSTimeInterval lateTimeInterval = 6.5f * 60.f * 60.f;
    NSDate *lateDate = [NSDate dateWithTimeInterval:lateTimeInterval sinceDate:startCurrentCalendarDate];
    NSString *lateDateStr = [dateFormatter stringFromDate:lateDate];
    
    WWLog(@"%@)-%@",ealyDateStr,lateDateStr);
    /**
     * po ealyDateStr
     2018-06-30 04:30
     
     (lldb) po lateDateStr
     2018-06-30 06:30
     */
    
    WWLog(@"%@",startCurrentCalendarDateStr);
    //https://stackoverflow.com/questions/34846785/why-calendar-datefromcomponents-always-return-hour-16 输出结果的问题
    /**
     * 2018-06-30 00:00
         *  如果是直接输出 po startCurrenCalendarDate
         2018-06-29 16:00:00 +0000 会有误
     *
     */
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.hour = 4;
    dateComponents.minute = 30;
    
    NSDate *calendarDate = [currentDayCalendar dateFromComponents:dateComponents];
    WWLog(@"%@",calendarDate);
    
    
    //其实有一个总的时间
    /**
     * 总的时间是 04:30 - 06:30 这样就有的了总的秒数
     * 比较当前时间过了04:30 的间隔 并且是否在 06:30的时间之前
        * 在上述的时间间隔内才会执行绘制的操作
        * 如果时间早于04:30 就什么都没有
        * 如果时间晚于6:30 就是一个一直的绘制好的状态 不用去管了
     * 是否需要转换为本地时间？
        * 如果不转为本地时间 那么控制的时候就应该把时间往前调
        *
     
     */
    
//    NSDate currentLocalDate = [dateFormatter dateFromString:];
    
//    [((CAGradientLayer *)shapeLayer)setColors:@[[UIColor blueColor],[UIColor greenColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor redColor]]];
//    [((CAGradientLayer *)shapeLayer) setLocations:@[@(0.2),@(0.2),@(0.2),@(0.2),@(0.2)]];
    
    //比较结果
    NSComparisonResult compareResult = [currentDate compare:earlyDate];
    if (compareResult == NSOrderedAscending) {
        return;
    }else{
        compareResult = [currentDate compare:lateDate];
        if (compareResult == NSOrderedDescending) {
            return;
        }
        //中间的内容
        NSTimeInterval duartion = [currentDate timeIntervalSinceDate:earlyDate];
        CGFloat radio = duartion / kTotalTimeSeconds;
        WWLog(@"%f",radio);
    }
    WWLog(@"%zd",compareResult);
    /**
     * typedef NS_ENUM(NSInteger, NSComparisonResult) {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};
     */
    
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
