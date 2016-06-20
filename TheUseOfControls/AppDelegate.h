//
//  AppDelegate.h
//  TheUseOfControls
//
//  Created by lishaopeng on 16/5/24.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
#pragma mark - 获取delegate实例
+ (AppDelegate *)theAppDelegate;
//1.7.0将webView的header User-Agent内容替换成mplus-ua 用于与服务端交互
-(void)changeWebViewUA;

@end

