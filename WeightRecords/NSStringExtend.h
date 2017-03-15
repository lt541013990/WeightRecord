//
//  NSStringExtend.h
//  Etion
//
//  Created by  user on 11-7-30.
//  Copyright 2011 GuangZhouXuanWu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CGGeometry.h>

#import <UIKit/UIKit.h>

#define  ToInt      (int)
#define  ToUInt     (unsigned int)
#define  ToLong     (long)
#define  ToULong    (unsigned long)

@interface NSString (NSStringExtend)

- (CGSize)stringSizeWithFont:(UIFont*)font;

@end

