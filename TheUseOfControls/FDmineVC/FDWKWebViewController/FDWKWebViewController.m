//
//  FDWKWebViewController.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/7/12.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDWKWebViewController.h"
#import <WebKit/WebKit.h>
@interface FDWKWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation FDWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self start];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)start
{
    NSString *string = @"http://news.baidu.com";
    CGSize size = [UIScreen mainScreen].bounds.size;
    //
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    WKWebView *webView = [[WKWebView alloc]initWithFrame:rect];
    webView.navigationDelegate = self;
    webView.allowsBackForwardNavigationGestures = YES;
    webView.allowsLinkPreview = YES;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    [self.view addSubview:webView];
    //
    
}

#pragma mark -- WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didStartProvisionalNavigation");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didCommitNavigation");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didFinishNavigation");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailNavigation");
}
// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
//{
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
//}
// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
//{
//    NSLog(@"decidePolicyForNavigationResponse");
//}
// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    NSLog(@"decidePolicyForNavigationAction");
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
