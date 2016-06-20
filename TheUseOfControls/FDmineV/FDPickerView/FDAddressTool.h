//
//  FDAddressTool.h
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/30.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDAddressTool : NSObject

//通过名称获取二级城市Id
+(NSString *)getCitySecondId:(NSString *)name;
//通过名称获取Id
+(NSString *)getCityId:(NSString *)name;
//
+(void)getCity:(NSMutableArray *)arr;
//查询所有的省份
+(NSMutableArray *)getProvinceArr;
// 通过省查询相应的省id
+ (NSString *) getProvinceId:(NSString *)provinceName;
//根据省ID查询市
+(NSMutableArray *)getCityArr:(NSString *)provinceId;
//根据ID查询名称
+(NSString *)getNameById:(NSString *)ID;


@end
