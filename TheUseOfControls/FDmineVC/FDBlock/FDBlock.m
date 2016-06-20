//
//  FDBlock.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDBlock.h"

@interface FDBlock ()

@end

@implementation FDBlock


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self start];
}

#define createButtonWithStatus(buttonFrame,buttonTitle,buttonTitleColor)\
^(void)\
{\
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];\
[button setTitle:buttonTitle forState:UIControlStateNormal];\
[button setTitleColor:buttonTitleColor forState:UIControlStateNormal];\
[button setFrame:buttonFrame];\
return button;\
}()



#pragma mark -- 触发的方法
-(void)start
{
    //
    //^(传入参数列){行为主体};
    //
    int result = ^(int a){return a*a;}(5);
    NSLog(@"result=%d",result);
    //
    int result1 = ^(void){return 30;}();
    NSLog(@"result1=%d",result1);
    //
    NSString *buttonTitle = @"按钮";
    UIColor *buttonTitleColor = [UIColor blackColor];
    CGRect buttonFrame = CGRectMake(100, 200, 100, 40);
    //
    UIButton *button = createButtonWithStatus(buttonFrame, buttonTitle, buttonTitleColor);
    [self.view addSubview:button];
    //
    [self create];
    //
}

#pragma mark -- block方法  --start＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
void (^printNumBlock)(int) = ^(int num){
    NSLog(@"int num = %d",num);
};

int (^myBlock)(int) = ^(int num){
    return num*num;
};

int (^add)(int a,int b) = ^(int a,int b){
    return a+b;
};

int (^subtraction)(int a, int b) = ^(int a, int b){
    if(a>=b)
        return a-b;
    else
        return b-a;
};

#pragma mark -- block方法  --end

-(void)create
{
    //        printNumBlock(9);
    //        //
    //        NSLog(@"myBlock = %d",myBlock (9));
    //        //
    //        int kk = 2;
    //       __block int (^externalBlock)(int) = ^(int num){
    //            return kk*num;
    //        };
    //        NSLog(@"externalBlock=%d",externalBlock(9));
    //        //
    //       __block int x= 10;
    //        void (^sumXandYBolck)(int) = ^(int y){
    //            x=x+y;
    //            NSLog(@"new x = %d",x);
    //        };
    //        sumXandYBolck(50);
    //        NSLog(@"XX = %d",x);
    //        //
    //        NSLog(@"加法 = %d",add(1,3));
    //        NSLog(@"减法 = %d",subtraction(1,3));
    
    int (^square)(int);
    square = ^(int a){return a*a;};
    int result = square(3);
    NSLog(@"square=%d",result);
}


@end
