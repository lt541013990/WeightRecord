//
//  SQLManager.h
//  WeightRecords
//
//  Created by lt on 16/11/23.
//  Copyright © 2016年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLManager : NSObject

+ (BOOL)createLocalDB;                      /**< 创建本地表 */

+ (BOOL)addWeight:(NSString *)weight date:(NSString *)date name:(NSString *)userName;           /**< 向本地表里面添加体重日期等数据 */

+ (NSArray *)queryWeight;

@end
