//
//  UIView+SetRect.h
//  WeatherApp
//
//  Created by lt on 16/10/20.
//  Copyright © 2016年 lt. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UIScreen width
 */
#define Width [UIScreen mainScreen].bounds.size.width

/**
 *  UIScreen height.
 */
#define  Height  [UIScreen mainScreen].bounds.size.height

/**
 *  Status bar height.
 */
#define  StatusBarHeight      20.f

/**
 *  Navigation bar height.
 */
#define  NavigationBarHeight  44.f

/**
 *  Tabbar height.
 */
#define  TabbarHeight         49.f

/**
 *  Status bar & navigation bar height.
 */
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)

/**
 *  iPhone4 or iPhone4s
 */
#define  iPhone4_4s     (Width == 320.f && Height == 480.f)

/**
 *  iPhone5 or iPhone5s
 */
#define  iPhone5_5s     (Width == 320.f && Height == 568.f)

/**
 *  iPhone6 or iPhone6s
 */
#define  iPhone6_6s     (Width == 375.f && Height == 667.f)

/**
 *  iPhone6Plus or iPhone6sPlus
 */
#define  iPhone6_6sPlus (Width == 414.f && Height == 736.f)


@interface UIView (SetRect)

/*---------------------
 *Absolute coordinate *
 ---------------------*/

@property (nonatomic, assign) CGPoint viewOrigin;
@property (nonatomic, assign) CGSize viewSize;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;



/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;
@end
