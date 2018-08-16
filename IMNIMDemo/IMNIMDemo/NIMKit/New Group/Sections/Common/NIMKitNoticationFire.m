//
//  NIMKitNoticationFire.m
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMKitNoticationFire.h"

NSString *const NIMKitUserInfoHasUpdatedNotification = @"NIMKitUserInfoHasUpdatedNotification";
NSString *const NIMKitTeamInfoHasUpdatedNotification = @"NIMKitTeamInfoHasUpdatedNotification";

NSString *const NIMKitUserBlackListHasUpdatedNotification = @"NIMKitUserBlackListHasUpdatedNotification";
NSString *const NIMKitUserMuteListHasUpdatedNotification  = @"NIMKitUserMuteListHasUpdatedNotification";

NSString *const NIMKitTeamMembersHasUpdatedNotification   = @"NIMKitTeamMembersHasUpdatedNotification";

NSString *const NIMKitInfoKey                        = @"InfoId";

@implementation NIMKitNoticationFire
- (instancetype)init
{
    self = [super init];
    if (self) {
        _timer = [[NIMKitTimerholder alloc]init];
        _timeInterval = 1.0f;
        _cachedInfo = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)addFireInfo:(NIMKitFireInfo *)info
{
    NSAssert([NSThread currentThread].isMainThread, @"info must be fire in main thread");
    if (!self.cachedInfo.count) {
        [self.timer startTimer:self.timeInterval delegaate:self repeats:NO];
    }
    [self.cachedInfo setObject:info forKey:info.saveIdentity];
}

#pragma mark - NIMKitTimerHolderDelegate

- (void)onNIMKitTimerFired:(NIMKitTimerholder *)holder
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    for (NIMKitFireInfo *info in self.cachedInfo.allValues) {
        NSMutableArray *fireInfos = dict[info.notificationName];
        if (!fireInfos) {
            fireInfos = [[NSMutableArray alloc]init];
            dict[info.notificationName] = fireInfos;
        }
        if (info.firstObject) {
            [fireInfos addObject:info.firstObject];
        }
    }
    for (NSString *notificationName in dict) {
        NSDictionary *userInfo = dict[notificationName] ? @{NIMKitInfoKey : dict[notificationName]} : nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:userInfo];
    }
    [self.cachedInfo removeAllObjects];
}

@end



@implementation NIMKitFireInfo

- (NSObject *)firstObject
{
    if (self.session) {
        return self.session.sessionId;
    }
    return [NSNull null];
}

- (NSString *)saveIdentity
{
    if (self.session) {
        return [NSString stringWithFormat:@"%@-%zd",self.session.sessionId,self.session.sessionType];
    }
    return self.notificationName;
}

@end
