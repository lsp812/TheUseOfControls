//
//  ViewController.m
//  TheUseOfControls
//
//  Created by lishaopeng on 16/5/24.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "ViewController.h"
#import "TotalRefer.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;//存储数组的
@property (strong, nonatomic) UITableView *tableV;//列表
@end

#define CUSTOM_Test                      @"test"
#define CUSTOM_UIScrollview_InfiniteLoop @"无限滚动的UIScrollView"
#define CUSTOM_UITableView_InfiniteLoop  @"无限滚动的UITableView"
#define CUSTOM_Refresh_UITableView       @"下拉刷新和上提加载"
#define CUSTOM_DropDownList              @"下拉列表"
#define CUSTOM_ChineseNameList           @"姓名排序_tableView"
#define CUSTOM_DEFINE                    @"#define"
#define CUSTOM_BLOCK                     @"#block"
#define CUSTOM_GCD                       @"#GCD"
#define CUSTOM_UICollectionView          @"UICollectionView"
#define CUSTOM_RunTime                   @"runtime"
#define CUSTOM_NetWork                   @"网络请求"
#define CUSTOM_WebViewProgress           @"加载进度WebViewProgress"
#define CUSTOM_areaChoose                @"省市区_地区选择"
#define CUSTOM_wifi                      @"wifi"
#define CUSTOM_autoConstraints           @"masonry代码适配"
#define CUSTOM_wkWebView                 @"wkWebView"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Control";
    [self createData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.tableV = [[UITableView alloc]init];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV setFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    [self.view addSubview:self.tableV];
}

-(void)createData
{
    //
    self.dataArray = [NSMutableArray array];
    [self.dataArray removeAllObjects];
    //
    [self.dataArray addObject:CUSTOM_Test];
    [self.dataArray addObject:CUSTOM_UIScrollview_InfiniteLoop];
    [self.dataArray addObject:CUSTOM_UITableView_InfiniteLoop];
    [self.dataArray addObject:CUSTOM_Refresh_UITableView];
    [self.dataArray addObject:CUSTOM_DropDownList];
    [self.dataArray addObject:CUSTOM_ChineseNameList];
    [self.dataArray addObject:CUSTOM_DEFINE];
    [self.dataArray addObject:CUSTOM_BLOCK];
    [self.dataArray addObject:CUSTOM_GCD];
    [self.dataArray addObject:CUSTOM_UICollectionView];
    [self.dataArray addObject:CUSTOM_RunTime];
    [self.dataArray addObject:CUSTOM_NetWork];
    [self.dataArray addObject:CUSTOM_WebViewProgress];
    [self.dataArray addObject:CUSTOM_areaChoose];
    [self.dataArray addObject:CUSTOM_wifi];
    [self.dataArray addObject:CUSTOM_autoConstraints];
    [self.dataArray addObject:CUSTOM_wkWebView];
    //
    [self createTableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"tableViewCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld---%@",(long)indexPath.row,[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectString = [self.dataArray objectAtIndex:indexPath.row];
    [self jumpToNextVcWithString:selectString];
}
-(void)jumpToNextVcWithString:(NSString *)selectString
{
    if([selectString isEqualToString:CUSTOM_UIScrollview_InfiniteLoop])
    {
         [self jumpNextViewControllerName:@"FDScrolInfiniteLoopVC" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_UITableView_InfiniteLoop])
    {
        [self jumpNextViewControllerName:@"FDTableViewInfiniteLoopVC" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_Refresh_UITableView])
    {
        [self jumpNextViewControllerName:@"FDRefreshTableView" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_DropDownList])
    {
        [self jumpNextViewControllerName:@"FDDropDownListVC" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_ChineseNameList])
    {
        [self jumpNextViewControllerName:@"FDChineseSorting" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_DEFINE])
    {
        [self jumpNextViewControllerName:@"FDMacroDefinitionVC" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_BLOCK])
    {
        [self jumpNextViewControllerName:@"FDBlock" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_GCD])
    {
        [self jumpNextViewControllerName:@"FDGCD" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_UICollectionView])
    {
        [self jumpNextViewControllerName:@"FDUICollectionView" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_RunTime])
    {
        [self jumpNextViewControllerName:@"FDFourRunTimeViewController" andHaveXib:NO];
    }
    else if([selectString isEqualToString:CUSTOM_NetWork])
    {
        [self jumpNextViewControllerName:@"FDToolVC" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_WebViewProgress])
    {
        [self jumpNextViewControllerName:@"FDWebViewController" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_areaChoose])
    {
        [self jumpNextViewControllerName:@"FDAddressChooseVC" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_wifi])
    {
        [self jumpNextViewControllerName:@"FDWiFiVC" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_autoConstraints])
    {
        [self jumpNextViewControllerName:@"FDMasonryViewConroller" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_wkWebView])
    {
        [self jumpNextViewControllerName:@"FDWKWebViewController" andHaveXib:YES];
    }
    else if([selectString isEqualToString:CUSTOM_Test])
    {
        [self jumpNextViewControllerName:@"FDTestViewController" andHaveXib:YES];
    }
    else
    {
        NSLog(@"nothing");
    }
}
#pragma mark -- 跳转的地方
-(void)jumpNextViewControllerName:(NSString *)vcName andHaveXib:(BOOL)have
{
    if(have==YES)//带xib创建的
    {
        id  myObj = [[NSClassFromString(vcName) alloc]initWithNibName:vcName bundle:nil];
        [self.navigationController pushViewController:myObj animated:YES];
    }
    else//不带xib创建的
    {
        id  myObj = [[NSClassFromString(vcName) alloc]init];
        [self.navigationController pushViewController:myObj animated:YES];
    }
}
@end
