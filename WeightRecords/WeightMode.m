//
//  WeightMode.m
//  WeightRecords
//
//  Created by lt on 16/11/24.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "WeightMode.h"

@implementation WeightMode

- (id)initWithName:(NSString *)name weight:(NSString *)weight date:(NSString *)date
{
    if (self = [super init])
    {
        _name = name;
        _weight = weight;
        
        // 此时date格式为 yyyy-mm-dd 修改成mm/dd
        _date = [date substringFromIndex:5];
        _date = [_date stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    return self;
}

@end
