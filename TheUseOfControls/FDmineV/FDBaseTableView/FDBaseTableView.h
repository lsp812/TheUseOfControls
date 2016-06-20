//
//  FDBaseTableView.h
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/30.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@class FDBaseTableView;
@protocol UITableViewEventDelegate <NSObject>

@optional
//下拉
- (void)pullDown:(FDBaseTableView *)tableView;
//上拉
- (void)pullUp:(FDBaseTableView *)tableView;
@end

@interface FDBaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)id<UITableViewEventDelegate> eventDelegate;


@end
