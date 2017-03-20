//
//  SQLManager.m
//  WeightRecords
//
//  Created by lt on 16/11/23.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "SQLManager.h"

#define FMDATABASENAME @"longtengDB.db"
#define SQLDBNAME @"weightRecordDB"

const NSString *sql_id = @"id";
const NSString *sql_name = @"user_name";
const NSString *sql_weight = @"weight";
const NSString *sql_date = @"weight_date";


@interface SQLManager ()


@end

@implementation SQLManager

+ (BOOL)createLocalDB
{
    FMDatabase *db = [SQLManager db];
    if ([db open])
    {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' TEXT)",SQLDBNAME,sql_id,sql_name,sql_weight,sql_date];
        BOOL res = [db executeUpdate:sqlCreateTable];
        [db close];
        if (!res)
        {
            NSLog(@"error when creating db table");
            return NO;
        } else
        {
            NSLog(@"success to creating db table");
            return YES;
        }
        
    }
    return NO;
}

+ (BOOL)addWeight:(NSString *)weight date:(NSString *)date name:(NSString *)userName
{
    FMDatabase *db = [SQLManager db];
    if ([db open])
    {
        NSString *deleteWeight = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",SQLDBNAME,sql_date,date];
        BOOL d_res = [db executeUpdate:deleteWeight];
        if (!d_res)
        {
            NSLog(@"error when delete db table");
        } else
        {
            NSLog(@"success to delete db table");
        }
        
        
        NSString *insertWeight= [NSString stringWithFormat:@"INSERT INTO %@ ('%@', %@, %@) VALUES ('%@', '%@', '%@')",
                                 SQLDBNAME, sql_name, sql_weight, sql_date, userName, weight, date];
        BOOL res = [db executeUpdate:insertWeight];
        if (!res)
        {
            NSLog(@"error when insert db table");
        } else
        {
            NSLog(@"success to insert db table");
        }
        
        [db close];
        
        return d_res & res;
    }
    
    return NO;
}

/**
 *  获取数据库所有体重
 *
 *  @return array
 */
+ (NSArray *)getWholeWeight
{
    FMDatabase *db = [SQLManager db];
    NSMutableArray *weightArr = [NSMutableArray array];
    
    if ([db open])
    {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY weight_date",SQLDBNAME ];
        FMResultSet * rs = [db executeQuery:sql];
        
        while ([rs next])
        {
            NSString * name = [rs stringForColumn:(NSString *)sql_name];
            NSString * weight = [rs stringForColumn:(NSString *)sql_weight];
            NSString * date = [rs stringForColumn:(NSString *)sql_date];
            
            WeightMode *weightMode = [[WeightMode alloc] initWithName:name weight:weight date:date];
            [weightArr addObject:weightMode];
        }
        [db close];
    }
    
    return weightArr;
}

#pragma mark - Lazy

+ (FMDatabase *)db
{
    return [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/%@",LOCALPATH,FMDATABASENAME]];
}

@end
