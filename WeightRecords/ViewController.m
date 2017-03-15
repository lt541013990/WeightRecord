//
//  ViewController.m
//  WeightRecords
//
//  Created by lt on 16/11/18.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "ViewController.h"
#import "SegmentedControl.h"
#import "ChartView.h"
#import "AddWeightView.h"
#import "SQLManager.h"

@interface ViewController () <AddWeightViewDelegate>

@property (nonatomic, strong) CSegmentedControl *dateModeSegment;

@property (nonatomic, strong) ChartView *chartView;

@property (nonatomic, strong) UIButton *addNewWeightBtn;

@property (nonatomic, strong) AddWeightView *addWeightView;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"1");
    [SQLManager createLocalDB];
    NSLog(@"%@",LOCALPATH);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.dateModeSegment];
    [self.view addSubview:self.addNewWeightBtn];
    [self.view addSubview:self.chartView];
    [self.chartView showChart];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



/**
 重写该函数来隐藏bar

 @return YES
 */
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)addNewWeight
{
    _addWeightView = [[AddWeightView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _addWeightView.delegate = self;
    [self.view addSubview:_addWeightView];
    [_addWeightView show];
}

#pragma mark - delegate

- (void)redrawChart
{
    [self.chartView showChart];
}


#pragma mark - Lazy

- (CSegmentedControl *)dateModeSegment
{
    if (!_dateModeSegment)
    {
        _dateModeSegment = [[CSegmentedControl alloc]initWithTitles:@[NSLocalizedString(@"周", nil),NSLocalizedString(@"月", nil),NSLocalizedString(@"年", nil)]];
        _dateModeSegment.renderColor = [UIColor flatRedColor];//[UIColor colorWithR:16 G:130 B:255 A:1];
        _dateModeSegment.frame = CGRectMake(SCREEN_WIDTH / 2 - 90, 30, 180, 30);
        [_dateModeSegment addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
        _dateModeSegment.selectedSegmentIndex  = 0;
    }
    return _dateModeSegment;

}

- (ChartView *)chartView
{
    if (!_chartView)
    {
        _chartView = [[ChartView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 240)];
    }
    return _chartView;

}

- (UIButton *)addNewWeightBtn
{
    if (!_addNewWeightBtn)
    {
        _addNewWeightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addNewWeightBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 27, 35, 35);
        _addNewWeightBtn.backgroundColor = [UIColor clearColor];
        [_addNewWeightBtn setImage:[UIImage imageNamed:@"add_red"] forState:UIControlStateNormal];
        _addNewWeightBtn.contentMode = UIViewContentModeScaleToFill;
        [_addNewWeightBtn addTarget:self action:@selector(addNewWeight) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addNewWeightBtn;
}

@end
