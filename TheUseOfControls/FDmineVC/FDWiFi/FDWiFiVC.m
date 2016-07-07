//
//  FDWiFiVC.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/6/21.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDWiFiVC.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <net/if.h>
//
#import "SOLStumbler.h"
#import <SystemConfiguration/CaptiveNetwork.h>


@interface FDWiFiVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) SOLStumbler *stumbler;
@property(nonatomic, strong) UITableView *mTableV;
@property(nonatomic, strong) NSArray  *dicts;
@end

@implementation FDWiFiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"localIPAddress=%@",[self localIPAddress]);
    NSLog(@"getWIFIDic=%@",[self getWIFIDic]);
    NSLog(@"getBSSID=%@",[self getBSSID]);
    NSLog(@"getSSID=%@",[self getSSID]);
    [self fetchSSIDInfo];
    //
    [self registerNetwork:@"DaMai"];
    NSLog(@"getWifiName=%@",[self getWifiName]);
    //
}
- (NSString *)getWifiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    } 
    CFRelease(wifiInterfaces);
    return wifiName;
}


#pragma mark -- 获取网卡ip
- (NSString *)localIPAddress
{
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return localIP;
}
#pragma mark -- 获取网卡信息
- (NSDictionary *)getWIFIDic
{
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dic = (NSDictionary*)CFBridgingRelease(myDict);
            return dic;
        }
    }
    return nil;
}

- (NSString *)getBSSID
{
    NSDictionary *dic = [self getWIFIDic];
    if (dic == nil) {
        return nil;
    }
    return dic[@"BSSID"];
}

- (NSString *)getSSID
{
    NSDictionary *dic = [self getWIFIDic];
    if (dic == nil) {
        return nil;
    }
    return dic[@"SSID"];
}
#pragma mark -- 向ios系统注册ssid
- (void)registerNetwork:(NSString *)ssid
{
    NSString *values[] = {ssid};
    CFArrayRef arrayRef = CFArrayCreate(kCFAllocatorDefault,(void *)values,
                                        (CFIndex)1, &kCFTypeArrayCallBacks);
    if( CNSetSupportedSSIDs(arrayRef)) {
        NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
        CNMarkPortalOnline((__bridge CFStringRef)(ifs[0]));
        NSLog(@"%@", ifs);
    }
}
#pragma mark -- 获取当前链接的wifi
- (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return info;
}
@end
