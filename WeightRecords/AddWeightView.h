//
//  AddWeightView.h
//  WeightRecords
//
//  Created by lt on 16/11/22.
//  Copyright © 2016年 lt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddWeightViewDelegate <NSObject>

@optional

- (void)redrawChart;

@end

@interface AddWeightView : UIView <UITextFieldDelegate>

@property (nonatomic, assign) id<AddWeightViewDelegate> delegate;

- (void)show;

@end
