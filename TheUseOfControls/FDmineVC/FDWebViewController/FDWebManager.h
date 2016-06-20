//
//  FDWebManager.h
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/30.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDWebViewController.h"
@interface FDWebManager : NSObject
@property (strong, nonatomic) FDWebViewController *webVC;

+(FDWebManager *)sharedInstance;//


@end

