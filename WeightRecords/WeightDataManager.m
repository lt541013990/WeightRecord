//
//  WeightDataManager.m
//  WeightRecords
//
//  Created by lt on 17/3/20.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "WeightDataManager.h"

@implementation WeightDataManager

+ (NSArray *)getCurrentWeekData
{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *weightModeArray = [SQLManager getWholeWeight];
    NSString *mondayDate = [self getCurrentWeekData];
    
    
    
    return dataArray;
}







/**
 *  获取当前周的周一和周日的时间
 *
 *  @return xx/xx 周一日期
 */
+ (NSString *)getCurrentWeekMonday
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    //NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    //[lastDayComp setDay:day + lastDiff];
    //NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    //NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    
    return firstDay;
}

@end
