//
//  IMLogManager.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMLogManager.h"
#import "IMLogViewController.h"
#import "IMBundleSetting.h"


@interface IMLogManager ()
{
      DDFileLogger *_fileLogger;
}

@end

@implementation IMLogManager

+ (instancetype)sharedManager
{
    static IMLogManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IMLogManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagDebug];
        _fileLogger = [[DDFileLogger alloc] init];
        _fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        _fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        [DDLog addLogger:_fileLogger];
    }
    return self;
}

- (void)start
{
    DDLogInfo(@"App Started SDK Version %@\nBundle Setting: %@",[[NIMSDK sharedSDK] sdkVersion],[IMBundleSetting sharedConfig]);
}

- (UIViewController *)demoLogViewController {
    NSString *filepath = _fileLogger.currentLogFileInfo.filePath;
    IMLogViewController *vc = [[IMLogViewController alloc] initWithFilepath:filepath];
    vc.title = @"Demo Log";
    return vc;
}

- (UIViewController *)sdkLogViewController
{
    NSString *filepath = [[NIMSDK sharedSDK] currentLogFilepath];
    IMLogViewController *vc = [[IMLogViewController alloc] initWithFilepath:filepath];
    vc.title = @"SDK Log";
    return vc;
}

- (UIViewController *)sdkNetCallLogViewController
{
    NSString *filepath = [[NIMAVChatSDK sharedSDK].netCallManager netCallLogFilepath];
    IMLogViewController *vc = [[IMLogViewController alloc] initWithFilepath:filepath];
    vc.title = @"NetCall Log";
    return vc;
}

- (UIViewController *)sdkNetDetectLogViewController
{
    NSString *filepath = [[NIMAVChatSDK sharedSDK].avchatNetDetectManager logFilepath];
    IMLogViewController *vc = [[IMLogViewController alloc] initWithFilepath:filepath];
    vc.title = @"Net Detect Log";
    return vc;
}



- (UIViewController *)demoConfigViewController
{
    NSString *content = [NSString stringWithFormat:@"SDK Config:\n%@\nDemo Config:\n%@\n",[NIMSDKConfig sharedConfig],[IMBundleSetting sharedConfig]];
    IMLogViewController *vc = [[IMLogViewController alloc] initWithContent:content];
    vc.title = @"Demo Config";
    return vc;
}
@end
