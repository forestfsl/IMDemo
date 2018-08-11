//
//  IMDevice.m
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMDevice.h"
#import "Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>

#define NormalImageSize       (1280 * 960)


@interface IMDevice()

@property (nonatomic,copy)      NSDictionary    *networkTypes;

@end


@implementation IMDevice

- (instancetype)init
{
    if (self = [super init]) {
        [self buildDeviceInfo];
    }
    return self;
}

+ (IMDevice *)currentDevice{
    static IMDevice *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IMDevice alloc]init];
    });
    return instance;
}

- (void)buildDeviceInfo{
    _networkTypes = @{
                      CTRadioAccessTechnologyGPRS:@(IMNetworkType2G),
                      CTRadioAccessTechnologyEdge:@(IMNetworkType2G),
                      CTRadioAccessTechnologyWCDMA:@(IMNetworkType3G),
                      CTRadioAccessTechnologyHSDPA:@(IMNetworkType3G),
                      CTRadioAccessTechnologyHSUPA:@(IMNetworkType3G),
                      CTRadioAccessTechnologyCDMA1x:@(IMNetworkType3G),
                      CTRadioAccessTechnologyCDMAEVDORev0:@(IMNetworkType3G),
                      CTRadioAccessTechnologyCDMAEVDORevA:@(IMNetworkType3G),
                      CTRadioAccessTechnologyCDMAEVDORevB:@(IMNetworkType3G),
                      CTRadioAccessTechnologyeHRPD:@(IMNetworkType3G),
                      CTRadioAccessTechnologyLTE:@(IMNetworkType4G),
                      };
}


///图片/音频推荐参数
- (CGFloat)suggestImagePixels{
    return NormalImageSize;
}

- (CGFloat)compressQuality{
    return 0.5;
}


//App状态
- (BOOL)isUsingWifi{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status =  [reachability currentReachabilityStatus];
    return status == ReachableViaWiFi;
}

- (BOOL)isInBackground{
    return [[UIApplication sharedApplication] applicationState] != UIApplicationStateActive;
}

- (IMNetworkType)currentNetworkType{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status =  [reachability currentReachabilityStatus];
    switch (status) {
        case ReachableViaWiFi:
            return IMNetworkTypeWifi;
        case ReachableViaWWAN:
        {
            CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
            NSNumber *number = [_networkTypes objectForKey:telephonyInfo.currentRadioAccessTechnology];
            return number ? (IMNetworkType)[number integerValue] : IMNetworkTypeWwan;
        }
        default:
            return IMNetworkTypeUnknown;
    }
}


- (NSString *)networkStatus:(IMNetworkType)networkType
{
    switch (networkType) {
        case IMNetworkType2G:
            return @"2G";
        case IMNetworkType3G:
            return @"3G";
        case IMNetworkType4G:
            return @"4G";
        default:
            return @"WIFI";
    }
}

- (NSInteger)cpuCount{
    size_t size = sizeof(int);
    int results;
    
    int mib[2] = {CTL_HW, HW_NCPU};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

- (BOOL)isLowDevice{
#if TARGET_IPHONE_SIMULATOR
    return NO;
#else
    return [[NSProcessInfo processInfo] processorCount] <= 1;
#endif
}

- (BOOL)isIphone{
    NSString *deviceModel = [UIDevice currentDevice].model;
    if ([deviceModel isEqualToString:@"iPhone"]) {
        return YES;
    }else {
        return NO;
    }
}

- (NSString *)machineName{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}


- (CGFloat)statusBarHeight{
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
    return height;
}



@end
