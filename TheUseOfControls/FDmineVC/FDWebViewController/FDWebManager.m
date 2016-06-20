//
//  FDWebManager.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/30.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDWebManager.h"
#import "HttpGeneralEngine.h"
@implementation FDWebManager

+ (FDWebManager *)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[FDWebManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - -html 会自动调用该方法 --start
//服务器获取ua
- (NSString *)getUserAgent:(NSString *)param
{
//    NSDictionary* dicUA = [[HttpNewEngine sharedInstance] generateUserAgentDictionary];
//    NSDictionary* dicUA = [[HttpGeneralEngine sharedInstance] generateUserAgentDictionary];
    NSDictionary* dicUA = [NSDictionary dictionary];
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
    [jsonDic setValue:@"0" forKey:@"code"];
    [jsonDic setValue:@"200" forKey:@"status"];
    [jsonDic setValue:@"done." forKey:@"msg"];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:dicUA forKey:@"UserAgent"];
    [jsonDic setValue:dataDic forKey:@"data"];
    
    //打包json格式
    NSString *returnStr = [self takeJSONPackage:jsonDic];
    //    NSLog(@"returnStr == %@",returnStr);
    return returnStr;
}

- (NSString *)takeJSONPackage:(NSDictionary *)dic
{
    NSError *error = nil;
    //NSJSONWritingPrettyPrinted:指定生成的JSON数据应使用空格旨在使输出更加可读。如果这个选项是没有设置,最紧凑的可能生成JSON表示。
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSLog(@"Successfully serialized the dictionary into data.");
        //NSData转换为String
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@", jsonString);
        return jsonString;
    }
    else if ([jsonData length] == 0 &&
             error == nil){
        NSLog(@"No data was returned after serialization.");
        return nil;
    }
    else if (error != nil){
        NSLog(@"An error happened = %@", error);
        return nil;
    }
    return nil;
}

//从服务器获取当前web的title和所返回的页面。
- (NSString *)setAppGobackBar:(NSMutableDictionary *)paramDic
{
    //    NSLog(@"param = %@",paramDic);
    NSString *title = [paramDic objectForKey:@"title"];
    [self.webVC setWebTitle:title];
    
    //如果native不为0则根据native值返回到对应原生VC。如果native为0且url不为空则跳转对应url页
    //把native判断变成0url 1原生带入返回按键，让返回根据此做判断
    NSUInteger native = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"native_code"]].integerValue;
    NSString *url = [paramDic objectForKey:@"url"];
    NSString *urlStr = @"";
    if (native == 0)
    {
        urlStr = [NSString stringWithFormat:@"0%@",url];
    }
    //我的 PHMyInfoViewController
    else
    {
        NSString *vcstr = @"";
        if (native == 10000)//我的
        {
            vcstr = @"PHMyInfoViewController";
        }
        else if (native == 10001)//买家详情页 我买到的
        {
            vcstr = @"PHMyBuyAndSoldVC";
        }
        else if (native == 10002)//卖家详情页 我卖出的
        {
            vcstr = @"PHMyBuyAndSoldVC";
        }
        
        urlStr = [NSString stringWithFormat:@"1%@",vcstr];
    }
    
    [self.webVC setUrlName:urlStr];
    return nil;
}
#pragma mark - -html 会自动调用该方法 --end
#pragma mark -- 涉及js交互的         --start
//跳转到地址管理
-(void)jumpToAddressManager:(NSMutableDictionary *)paramDic
{
//    NSString *urlString = [NSString stringWithFormat:@"%@",[paramDic valueForKey:@"backUrl"]];
//    PHAddressListVC *vc = [[PHAddressListVC alloc]initWithNibName:@"PHAddressListVC" bundle:nil];
//    [vc pushPHAddressType:PHAddressTypeWeb];
//    [vc pushUrlString:urlString];
//    [self.webVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 涉及js交互的         --end
@end
