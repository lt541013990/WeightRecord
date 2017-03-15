//
//  WeightMode.h
//  WeightRecords
//
//  Created by lt on 16/11/24.
//  Copyright © 2016年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeightMode : NSObject

@property (nonatomic, strong, readonly) NSString *name;

@property (nonatomic, strong, readonly) NSString *weight;

@property (nonatomic, strong, readonly) NSString *date;

- (id)initWithName:(NSString *)name weight:(NSString *)weight date:(NSString *)date;

@end
