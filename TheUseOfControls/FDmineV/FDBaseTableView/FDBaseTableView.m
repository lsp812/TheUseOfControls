//
//  FDBaseTableView.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/30.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDBaseTableView.h"
#import "MJRefresh.h"

NSString *const MJTableViewCellIdentifier = @"Cell";
@implementation FDBaseTableView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}


-(id)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}
- (void)initView {
    
    // 1.注册cell
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:MJTableViewCellIdentifier];
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 2.集成刷新控件
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    if (!self.isHeader) {
//        [self addHeaderWithTarget:self action:@selector(headerRereshing)];
//        if (self.refresh) {
//#pragma 自动刷新(一进入程序就下拉刷新)
//            [self headerBeginRefreshing];
//        }
//        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//        [self addFooterWithTarget:self action:@selector(footerRereshing)];
//        
//        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//        
//    }
    
}

@end
