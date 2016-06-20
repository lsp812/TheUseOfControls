//
//  FDMacroDefinitionVC.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDMacroDefinitionVC.h"

@interface FDMacroDefinitionVC ()

@end

@implementation FDMacroDefinitionVC

#define KHeight             40
#define KName               @"名字"
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define KprintA             NSLog(@"printA")
#define CompareBig(a,b)     (a>b?a:b)
#define KprintSome(a)       NSLog(@"%@",a)
#define FONT(f)             [UIFont systemFontOfSize:f]
#define Plus(a,b)           (a+b)
#define method(count)               {\
if(count==1)\
{\
NSLog(@"吃饭");\
}\
else if (count==2)\
{\
NSLog(@"睡觉");\
}\
else\
{\
NSLog(@"结束");\
}\
}




//#define KCreateButton(buttonType,buttonFrame,buttonTitle,buttonFont,buttonTitleColor){\
//[button setFrame:buttonFrame];\
//[button setTitle:buttonTitle forState:UIControlStateNormal];\
//[button setTitleColor:buttonTitleColor forState:UIControlStateNormal];\
//[button.titleLabel setFont:buttonFont];\
//return button;\
//}

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(100, 100, 100, 40)];
    [button setTitle:@"POP" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)popAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self start];
    
}


-(void)writeSome
{
    NSLog(@"kkk");
}


-(void)start
{
    NSLog(@"name = %@",KName);
    KprintA;
    NSLog(@"c=%d",CompareBig(5, 7));
    KprintSome(@"as");
    NSLog(@"c=%d",Plus(5, 7));
    method(2);
    
    //    UIButtonType buttonType = UIButtonTypeCustom;
    //    CGRect buttonFrame = CGRectMake(100, 200, 100, 40);
    //    NSString *buttonTitle = @"title";
    //    UIFont *buttonFont = [UIFont systemFontOfSize:17.0];
    //    UIColor *buttonTitleColor = [UIColor greenColor];
    //    //
    ////    UIButton *button = [UIButton buttonWithType:buttonType];
    //    UIButton *button = [UIButton buttonWithType:buttonType];
    //    [button addTarget:self action:@selector(doIt) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:button];
    
}

-(void)doIt
{
    NSLog(@"doIt");
}


@end
