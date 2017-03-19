//
//  ChartView.h
//  WeightRecords
//
//  Created by lt on 16/11/22.
//  Copyright © 2016年 lt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    ChartModeWeek,
    ChartModeMonth,
    ChartModeYear
}ChartMode;

@interface ChartView : UIView

- (id)initWithFrame:(CGRect)frame mode:(ChartMode) mode;

- (void)showChart;

@property (nonatomic, assign) ChartMode chartMode;

@end
