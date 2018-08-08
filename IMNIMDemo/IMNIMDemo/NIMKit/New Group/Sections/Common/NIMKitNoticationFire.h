//
//  NIMKitNoticationFire.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMKitTimerholder.h"
#import <NIMSDK/NIMSDK.h>

@class NIMKitFireInfo;


@interface NIMKitNoticationFire : NSObject<NIMKitTimerHolderDelegate>

@property (nonatomic, strong) NSMutableDictionary *cachedInfo;
@property (nonatomic, strong) NIMKitTimerholder *timer;
@property (nonatomic, assign) NSTimeInterval timeInterval;

- (void)addFireInfo:(NIMKitFireInfo *)info;

@end


@interface NIMKitFireInfo : NSObject

@property (nonatomic, strong) NIMSession *session;

@property (nonatomic, copy) NSString *notificationName;

- (NSObject *)firstObject;

- (NSString *)saveIdentity;

@end
