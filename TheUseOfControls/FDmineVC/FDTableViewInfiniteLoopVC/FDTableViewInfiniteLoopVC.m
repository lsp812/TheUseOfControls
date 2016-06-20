//
//  FDTableViewInfiniteLoopVC.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/26.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDTableViewInfiniteLoopVC.h"
#import "BBTableView.h"
#import "PHMainBannerCell.h"
@interface FDTableViewInfiniteLoopVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) BBTableView *bannerBottomTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation FDTableViewInfiniteLoopVC

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
    [self fillData];
}

-(void)fillData
{
    self.dataArray = [NSMutableArray array];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"shuffingImage1.png"],@"image",@"标题1",@"title", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"shuffingImage2.png"],@"image",@"标题2",@"title", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"shuffingImage3.png"],@"image",@"标题3",@"title", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"shuffingImage4.png"],@"image",@"标题4",@"title", nil];
//    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"shuffingImage5.png"],@"image",@"标题5",@"title", nil];
    [self.dataArray addObject:dic1];
    [self.dataArray addObject:dic2];
    [self.dataArray addObject:dic3];
    [self.dataArray addObject:dic4];
//    [self.dataArray addObject:dic5];
    
    [self start];
}

-(void)start
{
    CGRect rect = CGRectMake(0, 200, self.view.frame.size.width, 100);
    if(!self.bannerBottomTableView)
    {
        self.bannerBottomTableView = [[BBTableView alloc] init];
        self.bannerBottomTableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        self.bannerBottomTableView.frame = rect;
        self.bannerBottomTableView.tag = 100;
        self.bannerBottomTableView.delegate = self;
        self.bannerBottomTableView.dataSource = self;
        self.bannerBottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bannerBottomTableView.rowHeight = 130;
        self.bannerBottomTableView.backgroundColor = [UIColor whiteColor];
        self.bannerBottomTableView.showsHorizontalScrollIndicator = NO;
        self.bannerBottomTableView.showsVerticalScrollIndicator = NO;
        self.bannerBottomTableView.enableInfiniteScrolling = YES;
        [self.view addSubview:self.bannerBottomTableView];
    }
}

#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellMark = @"PHMainBannerCell";
    PHMainBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMark];
    if (cell==nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PHMainBannerCell" owner:self options:nil]lastObject];
    }
    //因为tableView旋转，所以cell需要跟着旋转
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
    [cell pushBannerData:self.dataArray[indexPath.row]];
    //tableview默认往右偏移一点保证与上部视图对齐，因为tableView翻转过，故调整y值
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath=%ld",(long)indexPath.row%self.dataArray.count);
//由于BBTableView机制，indexPath是成倍增长放到table里的，所以需要做取余操作
//    NSUInteger index = indexPath.row%self.mainData.bannersThreeArr.count;
//    
//    BannerData *data = self.mainData.bannersThreeArr[index];
//    //             NSLog(@"data.banner_type=%lu",(unsigned long)data.banner_type);
//    if (data.banner_type == 1)
//    {
//        //                [self showHUD:[NSString stringWithFormat:@"%@",data.url]];
//        [self jumopToHtmlUrl:data.url];
//    }
//    else if (data.banner_type == 2)
//    {
//        //                [self showHUD:[NSString stringWithFormat:@"%@",data.project_id]];
//        [self jumpToProjectId:data.project_id];
//    }
//    else
//    {
//        NSLog(@"banner类型错误");
//    }
    
    
}


@end
