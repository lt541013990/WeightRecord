//
//  FoldLineView.m
//  WeightRecords
//
//  Created by lt on 16/11/21.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "FoldLineView.h"
#import "Masonry.h"

#define LINEPOINTCOLOR [UIColor orangeColor]

@interface FoldLineView ()

@property (nonatomic, strong) NSMutableArray *pointArr;     /**< 坐标点数组 */

@property (nonatomic, strong) NSTimer *timer;               /**< 定时器 */

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end


@implementation FoldLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)draw
{
    // 判断如果没有数据 则不绘图
    if (self.xArr.count == 0)
    {
        return;
    }
    
    // 计算每个点之间的间距  -- 54   一个屏幕七个点
    // 循环添加日期标签
    for (int i = 0; i < self.xArr.count; i++)
    {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + i * space, 180, 40, 20)];
        numberLabel.text = self.xArr[i];
        numberLabel.font = [UIFont systemFontOfSize:11];
        numberLabel.alpha = 0.5;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [numberLabel sizeToFit];
        numberLabel.centerX = 20 + i * space + 10;
        [self addSubview:numberLabel];
    }
    
    // 找最大Y值
    // 这个地方的逻辑是: 找到这组数据中的最大值,然后根据最大值,选择一个合适的数值当做最大值,然后根据数组里的值等比例安排各个点的位置
    float maxY = [self.yArr[0] floatValue];
    for (int i = 0; i < self.xArr.count ; i++)
    {
        if (maxY < [self.yArr[i] floatValue])
        {
            maxY = [self.yArr[i] floatValue];
        }
    }
    
    // 最大值设置为高度百分之90 求出最大值
    maxY = maxY / 0.9;
    // 求出坐标点在线上的比例
    self.pointArr = [NSMutableArray array];
    for (int i = 0; i < self.xArr.count; i++)
    {
        if ([self.yArr[i] isEqualToString:@""])
        {
            [self.pointArr addObject:@""];
        }else
        {
            [self.pointArr addObject:[NSString stringWithFormat:@"%f",[self.yArr[i] floatValue] / maxY]];
        }
    }
    
    // 添加平行Y轴的七根线
    for (int i = 0; i < self.xArr.count; i++)
    {
        UIView *lineVeiw = [[UIView alloc] initWithFrame:CGRectMake(20 + i * space + 9, 0, 1, 180)];
        [self addSubview:lineVeiw];
        // 给线添加渐变
        CAGradientLayer *lineLayer = [CAGradientLayer layer];
        lineLayer.frame = lineVeiw.bounds;
        [lineVeiw.layer addSublayer:lineLayer];
        
        // 颜色分配
        lineLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor colorWithR:221 G:223 B:225 A:0.6].CGColor, (__bridge id)[UIColor clearColor].CGColor];
        lineLayer.locations = @[@(0),@(1)];
        
        // 起始点
        lineLayer.startPoint = CGPointMake(0.5, 0);
        
        // 结束点
        lineLayer.endPoint = CGPointMake(0.5, 1);
    }
    
    // 根据点划线
    UIBezierPath *path = [UIBezierPath bezierPath];
    BOOL hasStartDraw = NO;
    for (int i = 0; i < self.xArr.count; i++)
    {
        if ([self.pointArr[i] isEqualToString:@""])
        {
            continue;
        }
        
        if (hasStartDraw == NO)
        {
            hasStartDraw = YES;
            [path moveToPoint:CGPointMake(20 + 9 + space*i, 4 + 170 * (1 - [self.pointArr[i] floatValue]))];
        }else
        {
            [path addLineToPoint:CGPointMake(20 + space*i + 9, 4 + 170 * (1 - [self.pointArr[i] floatValue]))];
        }
        
    }
    self.shapeLayer = [[CAShapeLayer alloc]init];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = LINEPOINTCOLOR.CGColor;
    self.shapeLayer.lineWidth = 1.f;
    self.shapeLayer.path = path.CGPath;
    
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    [self.layer addSublayer:self.shapeLayer];
    // 手动添加运行循环 防止滑动的时候动画停止
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(addAnimation) userInfo:nil repeats:YES];
    NSRunLoop *cunrrentRunLoop = [NSRunLoop currentRunLoop];
    [cunrrentRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // 根据坐标绘制点
    for (int i = 0; i < self.xArr.count; i++)
    {
        if ([self.pointArr[i] isEqualToString:@""])
        {
            continue;
        }
        
        CGFloat pointY = [self.pointArr[i] floatValue];
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(20 + i * space + 5.5, 170 * (1 - pointY), 7, 7)];
        pointView.centerX = 20 + i * space + 9.5;
        pointView.backgroundColor = [UIColor whiteColor];
        pointView.layer.borderWidth = 1.5;
        pointView.layer.borderColor = LINEPOINTCOLOR.CGColor;
        pointView.layer.cornerRadius = 3.5;
        pointView.layer.masksToBounds = YES;
        [self addSubview:pointView];
        
        // 添加标签label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:9];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.text = [NSString stringWithFormat:@"%@",self.yArr[i]];
        [titleLabel sizeToFit];
        [self addSubview:titleLabel];
        // 用masonry做约束
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.mas_equalTo(pointView.mas_top).offset(-5);
            make.centerX.mas_equalTo(pointView.mas_centerX);;
        }];
    }
}

// 添加动画
- (void)addAnimation
{
    if (self.shapeLayer.strokeEnd < 1.0)
    {
        CGFloat add = 1.0 / (self.xArr.count + 3);
//        NSLog(@"add-->>%f",add);
        self.shapeLayer.strokeEnd += add;
//        NSLog(@"strokeEnd = %f",self.shapeLayer.strokeEnd);
    }else
    {
        // 取消定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
