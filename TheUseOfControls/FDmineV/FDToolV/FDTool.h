//
//  FDTool.h
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/26.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FDTool : NSObject

#pragma mark -- 获取相机的权限
+(BOOL)getTheCameraPermissions;

#pragma mark ---------------------------------------------------------------------------------------- 关于校验的
#pragma mark --身份证校验
+(BOOL)isIdentityCard:(NSString *)str;
#pragma mark --银行卡校验
+(BOOL)isBankCard:(NSString *)str;
#pragma mark -- 手机号码校验
+(BOOL)isPhone:(NSString *)str;
#pragma mark -- 判断规则:8位(只包含数字和字母)
+(BOOL)regularExpressionsWithString:(NSString *)string;



#pragma mark ---------------------------------------------------------------------------------------- 关于字符串的
#pragma mark -- 初始化 富文本类
+ (void)initEMStringWithdefaultFont:(CGFloat)defaultFont strongFont:(CGFloat)strongFont defaultTextColor:(NSString *)defaultTextColor strongTextColor:(NSString *)strongTextColor;
+(BOOL)stringisNULL:(NSString *)str;
#pragma mark -- 字典转字符串
+(NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary;
#pragma mark -- 字符串转字典
+(NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString;
#pragma mark -- 把手机号换4位*显示
+(NSString *)changeEncryptionMobile:(NSString *)mobile;
#pragma mark - 获取字符串size
+(CGSize)sizeOfTextContent:(NSString *)textContent text_w:(CGFloat)text_w text_h:(CGFloat)text_h text_font:(NSInteger)text_font;



#pragma mark ---------------------------------------------------------------------------------------- 关于时间戳的
#pragma mark -- 时间戳转换
+ (NSString *) getStringFromDateTime:(NSString *)date  andDataFormat:(NSString *)dateFormat;
#pragma mark -- 根据时间戳获取星期几
+(NSString *)getWeekDayFordateString:(NSString *)dataString;
#pragma mark -- 根据时间戳获取2016.06.25 星期六19:30的格式
+(NSString *)getDateAndWeekAndTimeForDateString:(NSString *)dataString;
#pragma mark -- 与现在对比相隔时间
+ (int)intervalSinceNow:(NSString *)theDate;
#pragma mark -- 比较时间大小的返回值1oneDay在将来.返回-1oneday在以前。返回0是相同的
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

#pragma mark ---------------------------------------------------------------------------------------- 大数据二维码加密.a^b%c
+(NSString *)encryptedDataWithjiBenString:(NSString *)jibenString andTimeString:(NSString *)timeString andPubKeyString:(NSString *)pubKeyString andSessionId:(int)sessionId;


#pragma mark -- urlencode操作
+(NSString*)encodeString:(NSString*)unencodedString;
@end
