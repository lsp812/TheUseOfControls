//
//  FDTestViewController.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/7/13.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDTestViewController.h"

@interface FDTestViewController ()

@end

@implementation FDTestViewController

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
    [self start];
}

-(void)start
{
    //
    UIImage *image = [UIImage imageNamed:@"shuffingImage5.png"];
    UIImageView *imageV = [[UIImageView alloc]init];
    [imageV setFrame:CGRectMake(50, 100, 50, 50)];
    [self.view addSubview:imageV];
    //
    UIGraphicsBeginImageContextWithOptions(imageV.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:imageV.bounds cornerRadius:10.0] addClip];
    [image drawInRect:imageV.bounds];
    imageV.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
}

@end
