//
//  FoldLineView.h
//  WeightRecords
//
//  Created by lt on 16/11/21.
//  Copyright © 2016年 lt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoldLineView : UIView


/**
 纵坐标数据
 */
@property (nonatomic, strong) NSMutableArray *yArr;


/**
 横坐标数据
 */
@property (nonatomic, strong) NSMutableArray *xArr;

- (void)draw;

@end
