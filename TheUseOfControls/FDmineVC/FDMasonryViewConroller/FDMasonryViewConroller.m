//
//  FDMasonryViewConroller.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/7/4.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDMasonryViewConroller.h"
#import "Masonry.h"


@interface FDMasonryViewConroller ()

@end

@implementation FDMasonryViewConroller

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
    [self createInterFace];
}

//创建视图
-(void)createInterFace
{
//    NSLog(@"createInterFace");
//    UILabel *label_01 = [[UILabel alloc]init];
//    [label_01 setFrame:CGRectMake(100, 100, 120, 20)];
//    [label_01 setBackgroundColor:[UIColor grayColor]];
//    [label_01 setFont:[UIFont systemFontOfSize:15.0]];
//    [label_01 setTextColor:[UIColor redColor]];
//    [label_01 setTextAlignment:NSTextAlignmentCenter];
//    label_01.text = @"label_01";
//    [self.view addSubview:label_01];
//    //
//    UILabel *label_02 = [[UILabel alloc]init];
//    [label_02 setFrame:CGRectMake(100, 150, 120, 20)];
//    [label_02 setBackgroundColor:[UIColor grayColor]];
//    [label_02 setFont:[UIFont systemFontOfSize:15.0]];
//    [label_02 setTextColor:[UIColor redColor]];
//    [label_02 setTextAlignment:NSTextAlignmentCenter];
//    label_02.text = @"label_02";
//    [self.view addSubview:label_02];
    //
//    [self.ticketTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(15);
//        make.centerX.mas_equalTo(_baseInfoView.mas_centerX);
//        make.width.mas_equalTo(_baseInfoView.mas_width);
//        make.height.mas_equalTo(22);
//        
//        
//    }];
    
    
//    [label_02 mas_makeConstraints:^(MASConstraintMaker *make) {
//       //
//        make.left.equalTo(MASBoxValue(100));
//        make.right.equalTo(MASBoxValue(100));
//        
//    }];
    [self createView];
}

-(void)createView
{
    UIView *view_01 = [[UIView alloc]init];
    [view_01 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view_01];
    [view_01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10+64, 10, 10, 10));
    }];
    //
    UIView *view_02 = [[UIView alloc]init];
    [view_02 setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:view_02];
    [view_02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view_01.mas_top).offset(20);
        make.left.mas_equalTo(view_01.mas_left).offset(20);
        make.right.mas_equalTo(view_01.mas_right).offset(-20);
        make.bottom.mas_equalTo(view_01.mas_bottom).offset(-20);
    }];
    //
    int padding1 = 10;
    UIView *sv2 = [[UIView alloc]init];
    sv2.backgroundColor = [UIColor greenColor];
    [view_02 addSubview:sv2];
    //
    UIView *sv3 = [[UIView alloc]init];
    sv3.backgroundColor = [UIColor greenColor];
    [view_02 addSubview:sv3];
    //
    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view_02.mas_top);
        make.left.equalTo(view_02.mas_left).offset(padding1);
        make.right.equalTo(sv3.mas_left).offset(-padding1);
//        make.height.mas_equalTo(@150);
        make.height.equalTo(@150);
        make.width.equalTo(sv3);
    }];
    //
    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view_02.mas_top);
        make.left.equalTo(sv2.mas_right).offset(padding1);
        make.right.equalTo(view_02.mas_right).offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(sv2);
        //
    }];
    //
    UIView *view_03 = [[UIView alloc]init];
    view_03.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view_03];
    [view_03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(260);
        make.left.mas_offset(50);
        make.width.mas_offset(120);
        make.height.mas_offset(50);
    }];
    //
    UIView *view_04 = [[UIView alloc]init];
    view_04.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view_04];
    [view_04 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(view_03.mas_bottom);
//        make.top.mas_equalTo(view_03.mas_bottom).offset(10);
//        make.top.mas_lessThanOrEqualTo(view_03.mas_bottom);
//        make.left.mas_offset(50);
//        make.right.mas_lessThanOrEqualTo(view_02.mas_right).offset(-10);
        make.right.mas_equalTo(view_02.mas_right).offset(-10);
//        make.width.mas_offset(120);
        make.left.mas_lessThanOrEqualTo(view_03.mas_right).offset(10);
//        make.left.mas_greaterThanOrEqualTo(view_03.mas_right).offset(10);
//        make.left.mas_equalTo(view_03.mas_right).offset(10);
        make.height.mas_offset(80);
    }];
    ///////////////////////////修改约束条件
    [view_02 mas_updateConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(view_01.mas_left).offset(10);
    }];
    ///
    [view_02 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view_01.mas_top).offset(20);
        make.left.mas_equalTo(view_01.mas_left).offset(20);
        make.right.mas_equalTo(view_01.mas_right).offset(-30);
        make.bottom.mas_equalTo(view_01.mas_bottom).offset(-40);
    }];
}

@end
