//
//  FDAddressChooseVC.h
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAddressChooseVC : UIViewController
//关于选择地区的地方使用
-(void)pushProvince_id:(NSString *)province_id province_name:(NSString *)province_name city_id:(NSString *)city_id city_name:(NSString *)city_name area_id:(NSString *)area_id area_name:(NSString *)area_name;
@end
