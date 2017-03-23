//
//  WeightMode.m
//  WeightRecords
//
//  Created by lt on 16/11/24.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "WeightMode.h"

@implementation WeightMode

- (id)initWithName:(NSString *)name weight:(NSString *)weight date:(NSString *)datestr
{
    if (self = [super init])
    {
        _name = name;
        _weight = weight;
        _date = [datestr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        _showDate = [datestr substringFromIndex:5];
        _showDate = [_showDate stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    return self;
}

@end
