//
//  ChartView.m
//  WeightRecords
//
//  Created by lt on 16/11/22.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "ChartView.h"
#import "FoldLineView.h"

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
    NSArray *arr = [SQLManager getWholeWeight];
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
    NSArray *arr = [SQLManager getWholeWeight];
    [_yArr removeAllObjects];
    
    for (WeightMode *mode in arr)
    {
        [_yArr addObject:mode.weight];
    }
    
    return _yArr;
}

@end
