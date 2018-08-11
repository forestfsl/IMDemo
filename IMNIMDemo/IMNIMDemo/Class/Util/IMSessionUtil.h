//
//  IMSessionUtil.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


//最近会话本地扩展标记类型
typedef NS_ENUM(NSUInteger, IMRecentSessionMarkType) {
    //@ 标记
    IMRecentSessionMarkTypeAt,
    //置顶标记
    IMRecentSessionMarkTypeTop,
};

@interface IMSessionUtil : NSObject

+ (CGSize)getImageSizeWithImageOriginSize:(CGSize)originSize
                                  minSize:(CGSize)imageMinSize
                                  maxSize:(CGSize)imageMaxSize;

+ (NSString *)showNick:(NSString *)uid inSession:(NIMSession *)session;

//接收时间格式化
+ (NSString *)showTime:(NSTimeInterval)msglastTime showDetail:(BOOL)showDetail;

+ (void)sessionWithInputURL:(NSURL *)inputURL
                  outputURL:(NSURL *)outputURL
               blockHandler:(void(^)(AVAssetExportSession *))handler;

+ (NSDictionary *)dictByJsonData:(NSData *)data;

+ (NSDictionary *)dictByJsonString:(NSString *)jsonString;

+ (BOOL)canMessageBeForwarded:(NIMMessage *)message;

+ (BOOL)canMessageBeRevoked:(NIMMessage *)message;

+ (NSString *)tipOnMessageRevoked:(NIMRevokeMessageNotification *)notification;

+ (void)addRecentSessionMark:(NIMSession *)session type:(IMRecentSessionMarkType)type;

+ (void)removeRecentSessionMark:(NIMSession *)session type:(IMRecentSessionMarkType)type;

+ (BOOL)recentSessionIsMark:(NIMRecentSession *)recent type:(IMRecentSessionMarkType)type;


+ (NSString *)onlineState:(NSString *)userId detail:(BOOL)detail;

+ (NSString *)formatAutoLoginMessage:(NSError *)error;

@end
