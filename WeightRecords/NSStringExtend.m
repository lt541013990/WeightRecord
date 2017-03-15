//
//  NSStringExtend.m
//  Etion
//
//  Created by  user on 11-7-30.
//  Copyright 2011 GuangZhouXuanWu. All rights reserved.
//


#import "NSStringExtend.h"



@implementation NSString (NSStringExtend)

- (CGSize)stringSizeWithFont:(UIFont*)font
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED <=  __IPHONE_6_1
    return [self sizeWithFont:font];
#else
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [self sizeWithAttributes:attributes];
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
#endif
}

@end
