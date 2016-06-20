//
//  FDWebViewController.h
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDWebViewController : UIViewController
- (void)pushWithurl:(NSString *)url;
//设置title
- (void)setWebTitle:(NSString *)title;
//设置返回页
- (void)setUrlName:(NSString *)url;
//重新加载
-(void)refreshLoadWithString:(NSString *)returnString;
//

@end
