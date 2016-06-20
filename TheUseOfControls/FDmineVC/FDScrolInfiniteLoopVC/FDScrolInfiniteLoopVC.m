//
//  FDScrolInfiniteLoopVC.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/26.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDScrolInfiniteLoopVC.h"
#import "PHShufflingFigureView.h"
@interface FDScrolInfiniteLoopVC ()<PHShufflingFigureDataSourceDelegate>
@property (strong, nonatomic) PHShufflingFigureView *sfv;
@end

@implementation FDScrolInfiniteLoopVC

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
    NSMutableArray *imgAry = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"shuffingImage1.png"],[UIImage imageNamed:@"shuffingImage2.png"],[UIImage imageNamed:@"shuffingImage3.png"],[UIImage imageNamed:@"shuffingImage4.png"],[UIImage imageNamed:@"shuffingImage5.png"], nil];
    CGRect rect = CGRectMake(0, 64+150, self.view.frame.size.width, 200);
    if(!self.sfv)
    {
        PHShufflingFigureView *sfv = [[PHShufflingFigureView alloc] init];
        sfv.backgroundColor = [UIColor greenColor];
        sfv.frame = rect;
        sfv.delegate = self;
        [sfv dataSourceWithImageArray:imgAry andDelegate:self andTimeInterval:2.0];
        self.sfv = sfv;
        [self.view addSubview:sfv];
    }

}
-(void)phShuffingView:(PHShufflingFigureView *)phShuffingView  clickimageViewIndex:(NSUInteger)index
{
    NSLog(@"index=%lu",(unsigned long)index);
}
@end
