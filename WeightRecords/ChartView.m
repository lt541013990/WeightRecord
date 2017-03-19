//
//  ChartView.m
//  WeightRecords
//
//  Created by lt on 16/11/22.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "ChartView.h"
#import "FoldLineView.h"
#import "SQLManager.h"

@interface ChartView ()

@property (nonatomic, strong) UIScrollView *chartScrollView;

@property (nonatomic, strong) FoldLineView *foldLineView;

@property (nonatomic, strong) NSMutableArray *xArr;

@property (nonatomic, strong) NSMutableArray *yArr;

@end

@implementation ChartView

- (id)initWithFrame:(CGRect)frame mode:(ChartMode) mode
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.chartMode = mode;
        [self addSubview:self.chartScrollView];
        
    }
    return self;
}

- (void)showChart
{
    // 每次绘图都完全干掉上一次的绘图
    [self.foldLineView removeFromSuperview];
    self.foldLineView = nil;
    [self.chartScrollView addSubview:self.foldLineView];
    [self.foldLineView draw];
}

// 获取当前周的周一和周日的时间
- (NSString *)getWeekTime
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
    [formatter setDateFormat:@"MM/dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    //NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];

    
    return firstDay;
}

#pragma mark - Lazy

- (UIScrollView *)chartScrollView
{
    if (!_chartScrollView)
    {
        _chartScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH - 30, 200)];
        _chartScrollView.showsHorizontalScrollIndicator = NO;
        _chartScrollView.backgroundColor = [UIColor whiteColor];
    }
    _chartScrollView.contentSize = CGSizeMake((self.xArr.count - 1) * space + 60, 200);
    return _chartScrollView;
}

- (FoldLineView *)foldLineView
{
    if (!_foldLineView)
    {
        _foldLineView = [[FoldLineView alloc] initWithFrame:CGRectMake(0, 0, (self.xArr.count - 1) * space + 60, 200)];
    }
    _foldLineView.xArr = self.xArr;
    _foldLineView.yArr = self.yArr;
    return _foldLineView;

}

- (NSMutableArray *)xArr
{
    if (!_xArr)
    {
        _xArr = [NSMutableArray array];
    }
    // x的数据源
    NSArray *arr = [SQLManager queryWeight];
    [_xArr removeAllObjects];
    
    for (WeightMode *mode in arr)
    {
        [_xArr addObject:mode.date];
    }
    
    return _xArr;
}

- (NSMutableArray *)yArr
{
    if (!_yArr)
    {
        // y的数据源
        _yArr =[NSMutableArray array];
    }
    NSArray *arr = [SQLManager queryWeight];
    [_yArr removeAllObjects];
    
    for (WeightMode *mode in arr)
    {
        [_yArr addObject:mode.weight];
    }
    
    return _yArr;
}

@end
