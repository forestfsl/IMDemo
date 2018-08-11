//
//  IMSubscribeManager.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMSubscribeManager : NSObject

+ (instancetype)sharedManager;

- (void)start;

- (NSDictionary<NIMSubscribeEvent *, NSString *> *)eventsForType:(NSInteger)type;

- (void)subscribeTempUserOnlineState:(NSString *)userId;

- (void)unsubscribeTempUserOnlineState:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
