//
//  NIMKitDevice.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/5.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIMKitDevice : NSObject

+ (NIMKitDevice *)currentDevice;

//图片、音频推荐参数
- (CGFloat)suggestImagePixels;
- (CGFloat)compressQuality;
- (CGFloat)statusBarHeight;

@end
