//
//  NIMKitUtil.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NIMSDK/NIMSDK.h>
#import "NIMGlobalMacro.h"

@interface NIMKitUtil : NSObject

+ (NSString *)showNick:(NSString *)uid inMessage:(NIMMessage *)message;

+ (NSString *)showNick:(NSString *)uid inSession:(NIMSession *)session;

+ (NSString *)showTime:(NSTimeInterval)msglastTime showDetail:(BOOL)showDetail;

+ (NSString *)messageTipContent:(NIMTeamMember *)member;

+ (BOOL)canInviteMember:(NIMTeamMember *)member;

@end
