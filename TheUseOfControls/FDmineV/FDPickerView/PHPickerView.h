//
//  PHPickerView.h
//  iMSBuyerTicket
//
//  Created by 大麦 on 16/5/13.
//  Copyright © 2016年 Martin Hartl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *_provinceName;
    NSString *_provinceID;
    NSString *_cityName;
    NSString *_cityID;
    NSString *_areaName;
    NSString *_areaID;
    UIViewController *__unsafe_unretained _parentControl;
}
@property(nonatomic,assign) UIViewController* parentControl;
@property (nonatomic ,strong) UIPickerView *picker;
@property (nonatomic ,strong) NSMutableArray *provinceArr;
@property (nonatomic ,strong) NSMutableArray *cityArr;
@property (nonatomic ,strong) NSMutableArray *areaArr;
-(void)showPickerView;
@end
