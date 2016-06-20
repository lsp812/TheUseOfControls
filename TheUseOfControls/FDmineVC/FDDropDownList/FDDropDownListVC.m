//
//  FDDropDownListVC.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDDropDownListVC.h"
#import "PHDropDownChooseToolView.h"
@interface FDDropDownListVC ()<PHDropDownChooseToolViewDelegate>
@end

@implementation FDDropDownListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self start];
}

-(void)start
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"显示" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 60, 100, 50)];
    [button addTarget:self action:@selector(showDrop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but setTitle:@"隐藏" forState:UIControlStateNormal];
    [but setFrame:CGRectMake(200, 60, 100, 50)];
    [but addTarget:self action:@selector(hideDrop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    //
}
-(void)showDrop
{
    NSMutableArray *checkArray = [NSMutableArray arrayWithObjects:@"全部颜色",@"红色",@"橙色",@"黄色",@"绿色",@"青色",@"蓝色",@"紫色", nil];
    CGRect rect = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    PHDropDownChooseToolView *list = [PHDropDownChooseToolView sharedInstance];
    list.delegate = self;
    [list showPHChooseListWithArray:checkArray withFrame:rect andSelectIndex:0];
    [list showPHView:YES];
}
-(void)hideDrop
{
    [[PHDropDownChooseToolView sharedInstance] dismissPHView:YES];
}
//代理方法.返回的是点击的第几项(从0开始。本质是数组的下标)。
-(void)phDropDownList:(PHDropDownChooseToolView *)dropDownList andClickIndex:(NSInteger)index
{
    NSLog(@"index=%ld",(long)index);
}

@end
