//
//  FDAddressChooseVC.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDAddressChooseVC.h"
#import "PHPickerView.h"
@interface FDAddressChooseVC ()
@property (nonatomic ,strong) PHPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *showLabel;
@end

@implementation FDAddressChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self creatPickView];
}
- (IBAction)showPickViewAction:(id)sender {
    self.pickerView.hidden = NO;
    [self.pickerView showPickerView];
}
//选择地区
-(void)creatPickView
{
    //添加PickerView
    CGRect windowRect = [UIScreen mainScreen].bounds;
    self.pickerView = [[PHPickerView alloc]initWithFrame:windowRect];
    self.pickerView.hidden = YES;
    self.pickerView.parentControl = self;
    [self.view addSubview:self.pickerView];
    [self.view bringSubviewToFront:self.pickerView];
}
-(void)pushProvince_id:(NSString *)province_id province_name:(NSString *)province_name city_id:(NSString *)city_id city_name:(NSString *)city_name area_id:(NSString *)area_id area_name:(NSString *)area_name
{
    
    NSString *chooseString = [NSString stringWithFormat:@"%@:%@    %@:%@    %@:%@",province_name,province_id,city_name,city_id,area_name,area_id];
    NSLog(@"chooseString=%@",chooseString);
    self.showLabel.text = chooseString;
    self.showLabel.adjustsFontSizeToFitWidth = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
