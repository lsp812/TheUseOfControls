//
//  FDWebViewController.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "FDWebManager.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "FDTool.h"
#import "AppDelegate.h"
@interface FDWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong, readonly) JSContext *jsContext;
@property (strong, nonatomic) NSString *backUrl;
@property (nonatomic, strong)NSString* url;
@property (nonatomic, strong)NSString* titleName;
//加载进度条
@property (weak, nonatomic) IBOutlet NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

//html调用app方法管理类
@property (strong, nonatomic) FDWebManager *webManager;
@end

/*
 1：在Info.plist中添加AppTransportSecurity类型Dictionary。
 2：在NSAppTransportSecurity下添加AllowsArbitraryLoads类型Boolean,值设为YES
 3.因为是https请求
*/

@implementation FDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改User-Agent为票乎mplus-ua
    [[AppDelegate theAppDelegate] changeWebViewUA];
    [self createProgressView];
    [self refreshLoadWithString:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
    
}
- (void)pushWithurl:(NSString *)url
{
    self.url = url;
}
- (void)setWebTitle:(NSString *)title
{
    if (!title)
    {
        return;
    }
    self.titleName = title;
//    self.titleLabel.text = self.titleName;
}

- (void)setUrlName:(NSString *)url
{
    self.backUrl = url;
}

//重新加载
-(void)refreshLoadWithString:(NSString *)returnString
{
    self.url = returnString;
    self.url = @"http://news.baidu.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [self.webView loadRequest:request];
}

-(void)createProgressView
{
    if(!self.progressProxy)
    {
        //加载进度条创建
        self.progressProxy = [[NJKWebViewProgress alloc] init];
        self.webView.delegate = self.progressProxy;
        self.progressProxy.webViewProxyDelegate = self;
        self.progressProxy.progressDelegate = self;
    }
    [_progressView setProgress:0.0f animated:NO];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}
#pragma mark -html 会自动调用该方法 -- end
#pragma mark -
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    if(webView.loading)
    {
        return;
    }
    //JSContext *jsContext
    //获取该UIWebview的javascript执行环境。@""中内容还未细研究，应该是一个固定获取的值
    _jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //关联打印异常
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
//        ALog(@"异常信息：%@", exceptionValue);
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    /*
     //通过oc方法调用自己创建的js方法，@""中为js代码
     NSString *alertJS = @"alert('test js OC')"; //准备执行的js代码
     [_jsContext evaluateScript:alertJS];
     */
    
    //通过oc方法调用网页已知js方法，需要知道方法名。stringByEvaluatingJavaScriptFromString方法返回值为该js方法返回值。传参方式按照js方法格式。
    /*1.7.0js和oc互调实验用例
     //通过js调用oc方法，@""中为oc方法名，js中需要与之对应 callIOS("hello world");
     //不带参数
     
     _jsContext[@"htmlCallApp"] = ^() {
     NSArray *args = [JSContext currentArguments];
     for (JSValue *jsVal in args) {
     NSLog(@"%@", jsVal);
     }
     //        添加返回值，js可以接收
     return @"ocReturn1";
     };
     */
    
    
    //带参数，如果带参数则需要js中与之相对应，即字符串对字符串，对象对对象。callIOSWithParam({'param':'hehe'});
    __weak UIViewController *weakSelf = self;
    __weak FDWebManager *weakManager = self.webManager;
    _jsContext[@"htmlCallApp"] = ^(NSString *paramStr) {
        NSArray *args = [JSContext currentArguments];
        //将获取到的参数放入字典中保存
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        for (NSUInteger i=0;i<args.count;i++)
        {
            JSValue *jsVal = [args objectAtIndex:i];
            NSLog(@"jsVal = %@", jsVal);
            [paramDic setValue:[jsVal toString] forKey:[NSString stringWithFormat:@"param%lu",(unsigned long)i]];
        }
        NSLog(@"htmlCallApp接收到的字典 == %@", paramDic);
        //参数1，参数字符串决定调用哪个方法。
        //参数2，预留
        NSString *param0 = [NSString stringWithFormat:@"%@:",[paramDic objectForKey:@"param0"]];
        NSString *param1 = [paramDic valueForKey:@"param1"];
        NSDictionary *dic = [FDTool dictionaryFromJsonString:param1];
        NSLog(@"dic=%@",dic);
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        if (param1 == nil || [param1 isEqualToString:@"null"])
        {
            param1 = @"";
        }
        
        SEL selector = NSSelectorFromString(param0);
        NSString *returnDic = nil;
        if ([weakManager respondsToSelector:selector])
        {
            returnDic = [weakManager performSelector:selector withObject:mutDic];
        }
        else
        {
            NSLog(@"JS方法名错误 错误的方法名为:%@",param0);
        }
        
        return returnDic;
    };
    //客户端需要传给js的方法和需要的参数。
    NSString *jsMethod = [NSString stringWithFormat:@"appCallHtml(\"%@\",\"%@\")",@"finishLoad",@""];
    NSString *jsReturn = [webView stringByEvaluatingJavaScriptFromString:jsMethod];
    NSLog(@"js返回值为 = %@",jsReturn);
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error=%@",error);
}
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
@end
