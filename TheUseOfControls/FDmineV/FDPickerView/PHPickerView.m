//
//  PHPickerView.m
//  iMSBuyerTicket
//
//  Created by 大麦 on 16/5/13.
//  Copyright © 2016年 Martin Hartl. All rights reserved.
//

#import "PHPickerView.h"
#import "FDAddressChooseVC.h"
#import "FDAddressTool.h"
#import "ColorUtility.h"
#define ProvinceComponent 0
#define CityComponent 1
#define AreaComponent 2
@implementation PHPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        
        self.frame = frame;
        //
        CGFloat headHeight = 40;
        CGFloat pickHeight = 180;
        CGFloat buttonWidth = 80;
        //
        CGRect windowRect = [UIScreen mainScreen].bounds;
        UIView *view_background = [[UIView alloc]init];
        view_background.backgroundColor = [UIColor blackColor];
        view_background.alpha = 0.5;
        [view_background setFrame:windowRect];
        [self addSubview:view_background];
        //
        UIView *view_button = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-headHeight-pickHeight, frame.size.width, headHeight)];
        view_button.backgroundColor =[ColorUtility colorWithHexString:@"e6e6e6"];
        [self addSubview:view_button];
        //
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setFrame:CGRectMake(5, 0, buttonWidth, view_button.frame.size.height)];
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [leftButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [leftButton setTitleColor:[ColorUtility colorWithHexString:@"f52d28"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [view_button addSubview:leftButton];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setFrame:CGRectMake(view_button.frame.size.width-buttonWidth-5, 0, buttonWidth, view_button.frame.size.height)];
         rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [rightButton setTitleColor:[ColorUtility colorWithHexString:@"f52d28"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(makeSureClick) forControlEvents:UIControlEventTouchUpInside];
        [view_button addSubview:rightButton];
        //
        self.picker = [[UIPickerView alloc]init];
        self.picker.delegate = self;
        self.picker.dataSource = self;
        self.picker.showsSelectionIndicator = YES;
        self.picker.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.picker];
        [self.picker reloadAllComponents];
        //
         self.picker.frame = CGRectMake(0, self.frame.size.height - pickHeight, self.frame.size.width, pickHeight);
        //
        //获取省份名称集合
        self.provinceArr = [FDAddressTool getProvinceArr];
        //获取第一个省
        _provinceName = [self.provinceArr objectAtIndex:0];
        //获取省份ID
        _provinceID = [FDAddressTool getProvinceId:_provinceName];
        //获取市级单位
        self.cityArr = [FDAddressTool getCityArr:_provinceID];
        //获取市名称
        _cityName = [self.cityArr objectAtIndex:0];
        //获取市ID
        _cityID = [FDAddressTool getCityId:_cityName];
        //获取区
        self.areaArr = [FDAddressTool getCityArr:_cityID];
        //获取区名称
        _areaName = [self.areaArr objectAtIndex:0];
        //获取区ID
        _areaID = [FDAddressTool getCityId:_areaName];
        
    }
    return self;
}
//点击取消
-(void)cancelClick
{
    [self hidePickerView];
}
//点击确定
-(void)makeSureClick
{
    if([self.parentControl isKindOfClass:[FDAddressChooseVC class]]){
        [(FDAddressChooseVC*)(self.parentControl) pushProvince_id:_provinceID province_name:_provinceName city_id:_cityID city_name:_cityName area_id:_areaID area_name:_areaName];
    }
    [self hidePickerView];
}
-(void)showPickerView
{
    self.hidden = NO;
}
-(void)hidePickerView
{
    self.hidden = YES;
}

#pragma mark -UIPickerViewDataSource
//PickView 由几部分组成
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//每一部分有几行组成
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case ProvinceComponent:
        {
            return [self.provinceArr count];
        }
            break;
        case CityComponent:
        {
            return [self.cityArr count];
        }
            break;
        case AreaComponent:
        {
            return [self.areaArr count];
        }
            break;
        default:
            return 0;
            break;
    }
}
//每一行显示什么文字


//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    switch (component) {
//        case ProvinceComponent:
//        {
//            return [self.provinceArr objectAtIndex:row];
//        }
//            break;
//        case CityComponent:
//        {
//            return [self.cityArr objectAtIndex:row];
//        }
//            break;
//        case AreaComponent:
//        {
//            return [self.areaArr objectAtIndex:row];
//        }
//            break;
//        default:
//            return nil;
//            break;
//    }
//}
//选择行之后的业务
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == ProvinceComponent) {
        
        _provinceName =[self.provinceArr objectAtIndex:row];
        _provinceID = [FDAddressTool getProvinceId:_provinceName];
        self.cityArr = [FDAddressTool getCityArr:_provinceID];
        _cityName = [self.cityArr objectAtIndex:0];
        _cityID = [FDAddressTool getCitySecondId:_cityName];
        self.areaArr = [FDAddressTool getCityArr:_cityID];
        _areaName = [self.areaArr objectAtIndex:0];
        _areaID = [FDAddressTool getCityId:_areaName];
        [pickerView reloadComponent:CityComponent];
        [pickerView selectRow:0 inComponent:CityComponent animated:YES];
        [pickerView reloadComponent:AreaComponent];
        [pickerView selectRow:0 inComponent:AreaComponent animated:YES];
    }else if (component == CityComponent)
    {
        _cityName = [self.cityArr objectAtIndex:row];
        _cityID = [FDAddressTool getCityId:_cityName];
        self.areaArr = [FDAddressTool getCityArr:_cityID];
        _areaName = [self.areaArr objectAtIndex:0];
        _areaID = [FDAddressTool getCityId:_areaName];
        [pickerView reloadComponent:AreaComponent];
        [pickerView selectRow:0 inComponent:AreaComponent animated:YES];
    }else{
        _areaName = [self.areaArr objectAtIndex:row];
        _areaID = [FDAddressTool getCityId:_areaName];
    }
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
    }
    customLabel.textAlignment = NSTextAlignmentCenter;
    customLabel.adjustsFontSizeToFitWidth = YES;
    [customLabel setFont:[UIFont systemFontOfSize:14.0]];
    customLabel.textColor = [ColorUtility colorWithHexString:@"000000"];
    NSString *title;
    
    switch (component) {
        case ProvinceComponent:
        {
            title = [self.provinceArr objectAtIndex:row];
        }
            break;
        case CityComponent:
        {
            title =  [self.cityArr objectAtIndex:row];
        }
            break;
        case AreaComponent:
        {
            title =  [self.areaArr objectAtIndex:row];
        }
            break;
        default:
            return nil;
            break;
    }
    customLabel.text = title;
    return customLabel;
}

@end
