//
//  IMDemoConfig.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMDemoConfig.h"

@interface IMDemoConfig ()

@end

@implementation IMDemoConfig

+ (instancetype)sharedConfig
{
    static IMDemoConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IMDemoConfig alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _appKey = @"45c6af3c98409b18a84451215d0bdd6e";
        _apiURL = @"https://app.netease.im/api";
        _apnsCername = @"ENTERPRISE";
        _pkCername = @"DEMO_PUSH_KIT";
        
        _redPacketConfig = [[IMRedPacketConfig alloc] init];
    }
    return self;
}


- (NSString *)apiURL
{
    NSAssert([[NIMSDK sharedSDK] isUsingDemoAppKey], @"只有 demo appKey 才能够使用这个API接口");
    return _apiURL;
}

- (void)registerConfig:(NSDictionary *)config
{
    if (config[@"red_packet_online"])
    {
        _redPacketConfig.useOnlineEnv = [config[@"red_packet_online"] boolValue];
    }
}


@end

@implementation IMRedPacketConfig

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _useOnlineEnv = YES;
        _aliPaySchemeUrl = @"alipay052969";
        _weChatSchemeUrl = @"wx2a5538052969956e";
    }
    return self;
}

@end
