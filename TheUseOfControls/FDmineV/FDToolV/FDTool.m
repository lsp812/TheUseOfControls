//
//  FDTool.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/26.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDTool.h"
#import "EMStringStylingConfiguration.h"
#import "NSString+EMAdditions.h"
#import "ColorUtility.h"
#import <AVFoundation/AVFoundation.h>
#import "JKBigDecimal.h"
#import "GTMBase64.h"
@implementation FDTool


#pragma mark -- 获取相机的权限
+(BOOL)getTheCameraPermissions
{
    //    __block BOOL  flag = NO;
    //    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    //    {
    //        //无权限
    //        PHAlertView *alert = [[PHAlertView alloc]initWithLeftTitle:@"取消" rightTitle:@"设置" contentTitle:@"系统无法开启摄像头，请先开启权限" contentView:nil alertImage:@"turnTicket_prompt" alertImageWidth:80 alertTitle:@"提示"];
    //        [alert show];
    //        alert.rightBlock= ^() {
    //            //跳转iPhone摄像头权限开关界面
    //            if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
    //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    //            }else{
    //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=INTERNET_TETHERING"]];
    //            }
    //        };
    //        alert.leftBlock = ^(){
    //            //回到入口页面
    //        };
    //    }
    //    else
    //    {
    //        flag = YES;
    //    }
    //    return flag;
    return YES;
}
#pragma mark ---------------------------------------------------------------------------------------- 关于校验的
#pragma mark --身份证校验
+(BOOL)isIdentityCard:(NSString *)str
{
    NSString *regex = @"^[A-Za-z0-9]{15,18}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}
#pragma mark --银行卡校验
+(BOOL)isBankCard:(NSString *)str
{
    NSString *regex = @"^[A-Za-z0-9]{16,19}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}
#pragma mark -- 手机号码校验
+(BOOL)isPhone:(NSString *)str
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
    
}
#pragma mark -- 正则表达式 判断8位的包含字母和数字
+(BOOL)regularExpressionsWithString:(NSString *)string
{
    NSString * regex = @"^[A-Za-z0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}
#pragma mark ---------------------------------------------------------------------------------------- 关于字符串的
#pragma mark -- 初始化富文本类
+ (void)initEMStringWithdefaultFont:(CGFloat)defaultFont strongFont:(CGFloat)strongFont defaultTextColor:(NSString *)defaultTextColor strongTextColor:(NSString *)strongTextColor
{
    [EMStringStylingConfiguration sharedInstance].defaultFont  = [UIFont systemFontOfSize:defaultFont];
    [EMStringStylingConfiguration sharedInstance].strongFont   = [UIFont systemFontOfSize:strongFont];
    // The code tag a little bit like in Github (custom font, custom color, a background color)
    EMStylingClass *aStylingClass = [[EMStylingClass alloc] initWithMarkup:@"<red>"];
    aStylingClass.color           = [ColorUtility colorWithHexString:strongTextColor];
    aStylingClass.font            = [UIFont boldSystemFontOfSize:strongFont];
    aStylingClass.attributes      = @{NSBackgroundColorAttributeName : [UIColor clearColor]};//背景色
    [[EMStringStylingConfiguration sharedInstance] addNewStylingClass:aStylingClass];
    
    aStylingClass       = [[EMStylingClass alloc] initWithMarkup:@"<black>"];
    aStylingClass.color = [ColorUtility colorWithHexString:defaultTextColor];
    aStylingClass.font  = [UIFont systemFontOfSize:defaultFont];
    [[EMStringStylingConfiguration sharedInstance] addNewStylingClass:aStylingClass];
}
#pragma mark -- 字符串为空判断
+(BOOL)stringisNULL:(NSString *)str
{
    if ([str isEqualToString:@""] || [str isEqualToString:@"<null>"]|| str == nil || [str isKindOfClass:[NSNull class]]||[str isEqualToString:@" "]) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark -- 字典转字符串
+(NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
    
    
}
#pragma mark -- 字符串转字典
+(NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark -- 把手机号换4位*显示
+(NSString *)changeEncryptionMobile:(NSString *)mobile
{
    NSString *thePrefix = [mobile substringToIndex:3];
    NSString *theSuffix = [mobile substringFromIndex:7];
    NSString *result = [NSString stringWithFormat:@"%@****%@",thePrefix,theSuffix];
    return result;
}
#pragma mark - 获取字符串size
+(CGSize)sizeOfTextContent:(NSString *)textContent text_w:(CGFloat)text_w text_h:(CGFloat)text_h text_font:(NSInteger)text_font
{
    
    CGSize titleSize = [textContent boundingRectWithSize:CGSizeMake(text_w, text_h) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:text_font]} context:nil].size;
    return titleSize;
}





#pragma mark ---------------------------------------------------------------------------------------- 关于时间戳的
#pragma mark -- 根据时间戳获取星期几
+(NSString *)getWeekDayFordateString:(NSString *)dataString
{
    double timeDate = [dataString doubleValue]/1000;
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timeDate];//
    
    //    long long data = [dataString longLongValue];
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    //    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
#pragma mark -- 时间戳转换
+ (NSString *) getStringFromDateTime:(NSString *)date  andDataFormat:(NSString *)dateFormat
{
    if (!date)
        return nil;
    if ([date isKindOfClass:[NSString class]])
    {
        int a = 0;
        a++;
    }
    if ([date isKindOfClass:[NSNumber class]])
    {
        int a = 0;
        a++;
    }
    
    double timeDate = [date doubleValue]/1000;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDate];//
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:dateFormat];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    
    //1296035591
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    //NSLog(@"confromTimespStr =  %@",confromTimespStr);
    return  confromTimespStr;
}
#pragma mark -- 根据时间戳获取2016.06.25 星期六19:30的格式
+(NSString *)getDateAndWeekAndTimeForDateString:(NSString *)dataString
{
    NSString *date = [self getStringFromDateTime:dataString andDataFormat:@"yyyy.MM.dd"];
    NSString *weekString = [self getWeekDayFordateString:dataString];
    NSString *timeString = [self getStringFromDateTime:dataString andDataFormat:@"HH:mm"];
    
    NSString *togetherString = [NSString stringWithFormat:@"%@ %@%@",date,weekString,timeString];
    return togetherString;
}

#pragma mark -- 与现在对比相隔时间
+ (int)intervalSinceNow:(NSString *)theDate
{
    double timeDate = [theDate doubleValue]/1000;
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:timeDate];
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSString *timeString = @"";
    NSTimeInterval cha = [d timeIntervalSinceDate:dat];
    
    //返回距现在相距多少分钟
    if (cha/60>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        return [timeString intValue];
    }
    return -1;
}
#pragma mark -- 比较时间大小的返回值1oneDay在将来.返回-1oneday在以前。返回0是相同的
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    //    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}
#pragma mark ---------------------------------------------------------------------------------------- 大数据二维码加密.a^b%c
+(NSString *)encryptedDataWithjiBenString:(NSString *)jibenString andTimeString:(NSString *)timeString andPubKeyString:(NSString *)pubKeyString andSessionId:(int)sessionId
{
    //二维码拆分(初始化数据)
    NSArray *jibenArray = [NSArray arrayWithArray:[jibenString componentsSeparatedByString:@"|"]];
    if([jibenArray count]==0)
    {
        return nil;
    }
    NSString *jibenPart1 = [jibenArray objectAtIndex:0];
    NSString *jibenPart2 = @"";
    for(int i=1;i<[jibenArray count];i++)
    {
        jibenPart2 = [jibenPart2 stringByAppendingFormat:@"|%@",jibenArray[i]];
    }
    //(对第一部分)base64解密后生成一个数组
    NSData *basedata = [jibenPart1 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    basedata = [GTMBase64 decodeData:basedata];
    //将时间转化成10位的byte
    NSData *timeData = [timeString dataUsingEncoding: NSUTF8StringEncoding];
    //合并
    NSMutableData *hebingData = [NSMutableData data];
    [hebingData appendData:timeData];
    [hebingData appendData:basedata];
    Byte *hebingByte = (Byte *)[hebingData bytes];
    
    NSString *pingjie = @"";
    for(int i=0;i<hebingData.length;i++)
    {
        NSString *he = [NSString stringWithFormat:@"%02X",hebingByte[i]];
        pingjie = [pingjie stringByAppendingString:he];
    }
    //JKBigInteger 用来进行模运算
    //    NSLog(@"pubKeyString=%@",pubKeyString);
    JKBigInteger *contentInter = (JKBigInteger *)[[JKBigInteger alloc]initWithString:pingjie andRadix:16];
    NSString *pubKeyStringPart1 = [[pubKeyString componentsSeparatedByString:@"|"] objectAtIndex:0];
    NSString *pubKeyStringPart2 = [[pubKeyString componentsSeparatedByString:@"|"] objectAtIndex:1];
    
    JKBigInteger *exponentInter = [[JKBigInteger alloc]initWithString:pubKeyStringPart2];
    JKBigInteger *modulusInter = [[JKBigInteger alloc]initWithString:pubKeyStringPart1];
    JKBigInteger *operationInter = [contentInter pow:exponentInter andMod:modulusInter];
    //
    unsigned int numBytesInt5 = [operationInter countBytes];
    unsigned char bytes[numBytesInt5];
    [operationInter toByteArrayUnsigned:bytes];
    //进行base64加密
    NSData *datajiami = [[NSData alloc]initWithBytes:bytes length:numBytesInt5];
    datajiami = [GTMBase64 encodeData:datajiami];
    
    NSString *resultBase = [[NSString alloc] initWithData:datajiami encoding:NSUTF8StringEncoding];
    //以下拼接最后结果
    NSString *sessionIdString = [NSString stringWithFormat:@"%d",sessionId];
    resultBase = [resultBase stringByAppendingFormat:@"%@",jibenPart2];
    resultBase = [resultBase stringByAppendingFormat:@"|%@",sessionIdString];
    return resultBase;
}

#pragma mark -- urlencode操作
+(NSString*)encodeString:(NSString*)unencodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    NSString *encodedString = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)unencodedString,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
@end
