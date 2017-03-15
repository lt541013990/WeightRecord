//
//  SegmentedControl.h
//  etionUI
//
//  Created by WangJian on 14-5-7.
//  Copyright (c) 2014年 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSegmentedControl : UIControl

@property (nonatomic, retain) UIColor *renderColor;     //默认为0x2083C3，该值用于渲染控件边框和选中部分的背景色，以及未选中状态下的文字或图片的颜色
@property (nonatomic, retain) UIColor *selectedColor;   //默认为0xFFFFFF，选中状态下的文字或图片颜色
@property (nonatomic, assign) CGFloat boarderSize;        //default is 1.0
@property (nonatomic, assign) CGFloat cornerRadius;       //default is 3.0

@property (nonatomic, strong) UIFont *font;         //default is [UIFont systemFontOfSize:14]

@property (nonatomic, assign) NSInteger selectedSegmentIndex;   //无动画效果
@property (nonatomic, readonly) NSUInteger numberOfSegments;

@property (nonatomic, getter=isMomentary) BOOL momentary;   //default is NO

- (id)initWithTitles:(NSArray *)titles;
- (id)initWithImages:(NSArray *)images;

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex animated:(BOOL)animated;

@end


// momentary == YES，无外边框，有分割线
@interface CStaticSegmentedControl : CSegmentedControl

@end
