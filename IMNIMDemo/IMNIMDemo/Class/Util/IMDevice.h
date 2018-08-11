//
//  IMDevice.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IMNetworkType) {
    IMNetworkTypeUnknown,
    IMNetworkTypeWifi,
    IMNetworkTypeWwan,
    IMNetworkType2G,
    IMNetworkType3G,
    IMNetworkType4G,
};

NS_ASSUME_NONNULL_BEGIN

@interface IMDevice : NSObject

+ (IMDevice *)currentDevice;

//图片、音频推荐参数
- (CGFloat)suggestImagePixels;

- (CGFloat)compressQuality;

//App 状态
- (BOOL)isUsingWifi;
- (BOOL)isInBackground;

- (IMNetworkType)currentNetworkType;
- (NSString *)networkStatus:(IMNetworkType)networkType;

- (NSInteger)cpuCount;
- (BOOL)isLowDevice;
- (NSString *)machineName;

- (CGFloat)statusBarHeight;

@end

NS_ASSUME_NONNULL_END
