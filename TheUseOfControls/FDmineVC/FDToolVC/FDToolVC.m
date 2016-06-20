//
//  FDToolVC.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/26.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDToolVC.h"
#import "HttpGeneralEngine.h"
@interface FDToolVC ()

@end

@implementation FDToolVC

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
    [self createView];
}

-(void)createView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 120, 40)];
    [button setTitle:@"请求" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(qingqiu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)qingqiu
{
    [[HttpGeneralEngine sharedOperationQueue] cancelAllOperations];//取消其他的operation
    [[HttpGeneralEngine sharedInstance] transferIsAllowTransfer:@"1" onComplete:^(NSDictionary *sourceDic, NSInteger errorCode, NSString *errorMsg, BOOL hasMore, id otherData) {
        if (errorCode == HTTP_200) {
            NSInteger code = [[sourceDic objectForKey:@"code"]integerValue];
            if (code == 0) {
                //允许转增.
                NSLog(@"正确");
            }
            else{
                NSLog(@"错误=%@",errorMsg);
            }
        }
        else
        {
            NSLog(@"错误=%@",errorMsg);
        }
    }];
}

@end
