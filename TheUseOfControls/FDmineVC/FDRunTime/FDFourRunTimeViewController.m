//
//  FourRunTimeViewController.m
//  ConclusionOnIOS
//
//  Created by 大麦 on 16/1/22.
//  Copyright (c) 2016年 lsp. All rights reserved.
//

#import "FDFourRunTimeViewController.h"
#import <objc/runtime.h>
#import "Father.h"
@implementation FDFourRunTimeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self create];
}

//runtime
//**************实用************
-(void)create
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"runtime" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(100, 100, 120, 40)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)clickAction:(UIButton *)button
{
//    [self tryMember];
    [self tryMemberFunc];
}

- (void)tryMember
{
    Father *father = [[Father alloc] init];
    NSLog(@"before runtime:%@", [father description]);
    
    unsigned int count = 0;
//    Ivar *members = class_copyIvarList([Father class], &count);
    Ivar *members = class_copyIvarList([Father class], &count);
    for (int i = 0 ; i < count; i++) {
        Ivar var = members[i];
        const char *memberName = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"%s----%s", memberName, memberType);
    }
    //
    Ivar m_name = members[1];//获取father的属性[name]
    object_setIvar(father, m_name, @"zhanfen");
    NSLog(@"after runtime:%@", [father description]);
    //

}
- (void)tryMemberFunc
{
    //动态添加方法
    [self tryAddingFunction];
    //
    unsigned int count = 0;
    Method *memberFuncs = class_copyMethodList([Father class], &count);//所有在.m文件显式实现的方法都会被找到
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"member method:%@", methodName);
    }
    //尝试调用新增的方法(用marc环境去测试)
//    Father *father = [[Father alloc] init];
//    [father method:10 :@"111"];//当你敲入father实例后，是无法获得method的提示的，只能靠手敲。而且编译器会给出"-method" not found的警告，可以忽略
    //
}

#pragma mark -- 动态添加新方法
- (void)tryAddingFunction
{
    class_addMethod([Father class], @selector(method::), (IMP)myAddingFunction, "i@:i@");
}
//具体的实现，即IMP所指向的方法
int myAddingFunction(id self, SEL _cmd, int var1, NSString *str)
{
    NSLog(@"I am added funciton");
    return 10;
}
//
- (void)tryMethodExchange
{
    Method method1 = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method method2 = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    method_exchangeImplementations(method1, method2);
    NSLog(@"lowcase of WENG zilin:%@", [@"WENG zilin" lowercaseString]);
    NSLog(@"uppercase of WENG zilin:%@", [@"WENG zilin" uppercaseString]);
}

@end
