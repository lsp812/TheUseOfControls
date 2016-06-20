//
//  FDAddressTool.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/30.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDAddressTool.h"
#import "FMDatabase.h"
@implementation FDAddressTool

//通过名称获取二级城市Id
+(NSString *)getCitySecondId:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_city" ofType:@"db"];//PN
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM area where name = '%@'  and type = 2",name];
    //    NSLog(@"%@--%d--%@",NSStringFromSelector(_cmd),__LINE__,sql);
    FMResultSet *rs = [db executeQuery:sql];//select * from Area where parent_code = '02'
    //    NSLog(@"rs = %@",rs);
    while ([rs next]) {
        NSString *code = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"id"]];
        //        NSLog(@"code = %@",code);
        
        return code;
    }
    
    [db close];
    return nil;
}

//通过名称获取Id
+(NSString *)getCityId:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_city" ofType:@"db"];//PN
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM area where name like '%@%%'  and parentid != 0",name];
    //    NSLog(@"%@--%d--%@",NSStringFromSelector(_cmd),__LINE__,sql);
    FMResultSet *rs = [db executeQuery:sql];//select * from Area where parent_code = '02'
    //    NSLog(@"rs = %@",rs);
    while ([rs next]) {
        NSString *code = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"id"]];
        //        NSLog(@"code = %@",code);
        
        return code;
    }
    
    
    [db close];
    return nil;
}

+(void)getCity:(NSMutableArray *)arr{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_city" ofType:@"db"];//PN
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM area where postalcode <> 0 ORDER BY firstLetter,telCode"];
    //    NSLog(@"%@--%d--%@",NSStringFromSelector(_cmd),__LINE__,sql);
    FMResultSet *rs = [db executeQuery:sql];//select * from Area where parent_code = '02'
    //    NSLog(@"rs = %@",rs);
    
    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
    NSMutableArray *arr2 = [[NSMutableArray alloc]init];
    while ([rs next]) {
        NSString *code = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"name"]];
        //        NSLog(@"code = %@",code);
        [arr1 addObject:code];
    }
    
    
    for (NSString *city in arr1) {
        if ([arr indexOfObject:city] == NSNotFound) {
            [arr2 addObject:city];
        }
    }
    
    
    
    [db close];
}
//查询所有的省份
+(NSMutableArray *)getProvinceArr
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_city" ofType:@"db"];//PN
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM area where postalcode = 0 and parentid=0 ORDER BY firstLetter,telCode"];
    //    NSLog(@"%@--%d--%@",NSStringFromSelector(_cmd),__LINE__,sql);
    FMResultSet *rs = [db executeQuery:sql];//select * from Area where parent_code = '02'
    //    NSLog(@"rs = %@",rs);
    
    while ([rs next]) {
        NSString *code = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"name"]];
        //        NSLog(@"code = %@",code);
        [arr addObject:code];
    }
    
    [db close];
    
    return arr;
}
#pragma mark -- 通过省查询相应的省id
+ (NSString *) getProvinceId:(NSString *)provinceName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_city" ofType:@"db"];//PN
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    
    NSString* sqlStr = [NSString stringWithFormat: @"select id from area where name = '%@'and telcode='%@'",provinceName,@"0"];
    NSString *provinceId;
    
    FMResultSet* rs = nil;
    
    @synchronized(db) {
        rs = [db executeQuery:sqlStr];
    }
    while([rs next]) {
        
        
        provinceId = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"id"]];
        
    }
    
    [rs close];
    
    return provinceId;
}

//根据省ID查询市
+(NSMutableArray *)getCityArr:(NSString *)provinceId
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_city" ofType:@"db"];//PN
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM area where parentid = %@ ORDER BY firstLetter,telCode",provinceId];
    //    NSLog(@"%@--%d--%@",NSStringFromSelector(_cmd),__LINE__,sql);
    FMResultSet *rs = [db executeQuery:sql];//select * from Area where parent_code = '02'
    //    NSLog(@"rs = %@",rs);
    
    while ([rs next]) {
        NSString *code = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"name"]];
        //        NSLog(@"code = %@",code);
        [arr addObject:code];
    }
    
    [db close];
    
    return arr;
}
//根据ID查询名称
+(NSString *)getNameById:(NSString *)ID
{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_city" ofType:@"db"];//PN
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM area where id = %@",ID];
    //    NSLog(@"%@--%d--%@",NSStringFromSelector(_cmd),__LINE__,sql);
    FMResultSet *rs = [db executeQuery:sql];//select * from Area where parent_code = '02'
    //    NSLog(@"rs = %@",rs);
    
    while ([rs next]) {
        NSString *code = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"name"]];
        //        NSLog(@"code = %@",code);
        return code;
        
    }
    
    [db close];
    
    return nil;
    
}


@end
