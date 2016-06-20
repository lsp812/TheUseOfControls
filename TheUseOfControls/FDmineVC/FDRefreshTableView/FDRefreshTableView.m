//
//  FDRefreshTableView.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDRefreshTableView.h"
#import "FDBaseTableView.h"
@interface FDRefreshTableView ()<UITableViewDelegate,UITableViewDataSource,UITableViewEventDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FDBaseTableView *tableV;
@end

@implementation FDRefreshTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self callRequest];
}

-(void)callRequest
{
    [self.tableV headerEndRefreshing];
    [self.tableV footerEndRefreshing];
    [self fillData];
}

-(void)fillData
{
    self.dataArray = [NSMutableArray array];
    for(int i=0;i<15;i++)
    {
        [self.dataArray addObject:[NSString stringWithFormat:@"text_%d",i]];
    }
    [self createTableView];
}

-(void)createTableView
{
    if(!self.tableV)
    {
        CGRect rect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        FDBaseTableView *tableView = [[FDBaseTableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.eventDelegate = self;
        [self.view addSubview:tableView];
        self.tableV = tableView;
    }
}
#pragma mark --
- (void)pullDown:(FDBaseTableView *)tableView
{
//    ++
    NSLog(@"pullDown");
    [self callRequest];
}
//下拉刷新
- (void)pullUp:(FDBaseTableView *)tableView
{
//    1
    NSLog(@"pullUp");
    [self callRequest];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identify = @"UItableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"Cell_%ld",(long)indexPath.row];
    return cell;
    
}
@end
