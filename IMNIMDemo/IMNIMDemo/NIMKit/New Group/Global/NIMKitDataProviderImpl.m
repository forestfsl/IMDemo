//
//  NIMKitDataProviderImpl.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/5.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMKitDataProviderImpl.h"
#import "NIMKit.h"
#import "NIMKitInfoFetchOption.h"
#import "UIImage+NIMKit.h"
#import "NIMKitInfoFetchOption.h"


#pragma mark - kit data request
@interface NIMKitDataRequest : NSObject

@property (nonatomic, strong) NSMutableSet *failedUserIds;
@property (nonatomic, assign) NSInteger maxMergeCount; //最大合并数

- (void)requestUserIds:(NSArray *)userIds;

@end

@implementation NIMKitDataRequest{
    NSMutableArray *_requestUserIdArray; //待请求池
    BOOL _isRequesting;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _failedUserIds = [[NSMutableSet alloc]init];
        _requestUserIdArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)requestUserIds:(NSArray *)userIds
{
    for (NSString *userId in userIds) {
        if (![_requestUserIdArray containsObject:userId] && ![_failedUserIds containsObject:userId]) {
            [_requestUserIdArray addObject:userId];
        }
    }
    [self request];
}

- (void)request
{
    static NSUInteger MaxBatchRequestCount = 10;
    if (_isRequesting || [_requestUserIdArray count] == 0) {
        return;
    }
    _isRequesting = YES;
    NSArray *userIds = [_requestUserIdArray count] > MaxBatchRequestCount ? [_requestUserIdArray subarrayWithRange:NSMakeRange(0, MaxBatchRequestCount)] : [_requestUserIdArray copy];
    __weak typeof(self) weakSelf = self;
    [[NIMSDK sharedSDK].userManager fetchUserInfos:userIds completion:^(NSArray<NIMUser *> * _Nullable users, NSError * _Nullable error) {
        [weakSelf afterRequest:userIds];
        if (!error && users.count) {
            [[NIMKit sharedKit] notifyUserInfoChanged:userIds];
        }else if ([weakSelf shouldAddToFailedUsers:error]){
            [weakSelf.failedUserIds addObjectsFromArray:userIds];
        }
    }];
}

- (void)afterRequest:(NSArray *)userIds
{
    _isRequesting = NO;
    [_requestUserIdArray removeObjectsInArray:userIds];
    [self request];
}

- (BOOL)shouldAddToFailedUsers:(NSError *)error
{
    //没有错误这种异常情况走到这个路径里也不对，不再请求
    return error.code != NIMRemoteErrorCodeTimeoutError || !error;
}

@end

@interface NIMKitDataProviderImpl ()<NIMUserManagerDelegate,NIMTeamManagerDelegate,NIMLoginManagerDelegate>

@property (nonatomic, strong) UIImage *defaultUserAvatar;
@property (nonatomic, strong) UIImage *defaultTeamAvatar;
@property (nonatomic, strong) NIMKitDataRequest *request;
@end

@implementation NIMKitDataProviderImpl

- (instancetype)init{
    self = [super init];
    if (self) {
        _request = [[NIMKitDataRequest alloc] init];
        _request.maxMergeCount = 20;
        [[NIMSDK sharedSDK].userManager addDelegate:self];
        [[NIMSDK sharedSDK].teamManager addDelegate:self];
        [[NIMSDK sharedSDK].loginManager addDelegate:self];
    }
    return self;
}

- (void)dealloc
{
    [[NIMSDK sharedSDK].userManager removeDelegate:self];
    [[NIMSDK sharedSDK].teamManager removeDelegate:self];
    [[NIMSDK sharedSDK].loginManager removeDelegate:self];
}

- (NIMKitInfo *)infoByUser:(NSString *)userId option:(NIMKitInfoFetchOption *)option
{
    //优先检测是否为机器人
    NIMKitInfo *info = [self infoByRobot:userId];
    if (info == nil) {
        NIMSession *session = option.message.session ?: option.session;
        info = [self infoByUser:userId session:session option:option];
    }
    return info;
}

- (NIMKitInfo *)infoByTeam:(NSString *)teamId
                    option:(NIMKitInfoFetchOption *)option
{
    NIMTeam *team    = [[NIMSDK sharedSDK].teamManager teamById:teamId];
    NIMKitInfo *info = [[NIMKitInfo alloc] init];
    info.showName    = team.teamName;
    info.infoId      = teamId;
    info.avatarImage = self.defaultTeamAvatar;
    info.avatarUrlString = team.thumbAvatarUrl;
    return info;
}

#pragma mark - 用户信息拼装
//会话中用户信息
- (NIMKitInfo *)infoByUser:(NSString *)userId
                   session:(NIMSession *)session
                    option:(NIMKitInfoFetchOption *)option
{
    NIMSessionType sessionType = session.sessionType;
    NIMKitInfo *info;
    
    switch (sessionType) {
        case NIMSessionTypeP2P:
        {
            info = [self userInfoInP2P:userId option:option];
        }
            break;
        case NIMSessionTypeTeam:
        {
            info = [self userInfo:userId inTeam:session.sessionId option:option];
        }
            break;
        case NIMSessionTypeChatroom:
        {
            info = [self userInfo:userId inChatroom:session.sessionId option:option];
        }
            break;
        default:
            NSAssert(0, @"invalid type");
            break;
    }
    
    if (!info)
    {
        if (!userId.length)
        {
            NSLog(@"warning: fetch user failed because userid is empty");
        }
        else
        {
            [self.request requestUserIds:@[userId]];
        }
        
        info = [[NIMKitInfo alloc] init];
        info.infoId = userId;
        info.showName = userId; //默认值
        info.avatarImage = self.defaultUserAvatar;
    }
    return info;
}

#pragma mark - P2P 用户信息
- (NIMKitInfo *)userInfoInP2P:(NSString *)userId
                       option:(NIMKitInfoFetchOption *)option
{
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:userId];
    NIMUserInfo *userInfo = user.userInfo;
    NIMKitInfo *info;
    if (userInfo)
    {
        info = [[NIMKitInfo alloc] init];
        info.infoId = userId;
        NSString *name = [self nickname:user
                             memberInfo:nil
                                 option:option];
        info.showName = name?:userId;
        info.avatarUrlString = userInfo.thumbAvatarUrl;
        info.avatarImage = self.defaultUserAvatar;
    }
    return info;
}

#pragma mark - 群组用户信息
- (NIMKitInfo *)userInfo:(NSString *)userId
                  inTeam:(NSString *)teamId
                  option:(NIMKitInfoFetchOption *)option
{
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:userId];
    NIMUserInfo *userInfo = user.userInfo;
    NIMTeamMember *member =  [[NIMSDK sharedSDK].teamManager teamMember:userId
                                                                 inTeam:teamId];
    
    NIMKitInfo *info;
    
    if (userInfo || member)
    {
        info = [[NIMKitInfo alloc] init];
        info.infoId = userId;
        
        NSString *name = [self nickname:user
                             memberInfo:member
                                 option:option];
        info.showName = name?:userId;
        info.avatarUrlString = userInfo.thumbAvatarUrl;
        info.avatarImage = self.defaultUserAvatar;
    }
    return  info;
}

#pragma mark - 聊天室用户信息
- (NIMKitInfo *)userInfo:(NSString *)userId
              inChatroom:(NSString *)roomId
                  option:(NIMKitInfoFetchOption *)option
{
    NIMKitInfo *info = [[NIMKitInfo alloc] init];
    info.infoId = userId;
    
    if ([userId isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount])
    {
        
        switch ([NIMSDK sharedSDK].loginManager.currentAuthMode) {
            case NIMSDKAuthModeChatroom:
            {
                NSAssert([NIMKit sharedKit].independentModeExtraInfo, @"in mode NIMSDKAuthModeChatroom , must has independentModeExtraInfo");
                info.showName        = [NIMKit sharedKit].independentModeExtraInfo.myChatroomNickname;
                info.avatarUrlString = [NIMKit sharedKit].independentModeExtraInfo.myChatroomAvatar;
            }
                break;
            case NIMSDKAuthModeIM:
            {
                NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:userId];
                info.showName        = user.userInfo.nickName;
                info.avatarUrlString = user.userInfo.thumbAvatarUrl;
            }
                break;
            default:
            {
                NSAssert(0, @"invalid mode");
            }
                break;
        }
        
    }
    else
    {
        NSAssert(option.message, @"message must has value in chatroom");
        NIMMessageChatroomExtension *ext = [option.message.messageExt isKindOfClass:[NIMMessageChatroomExtension class]] ?
        (NIMMessageChatroomExtension *)option.message.messageExt : nil;
        info.showName = ext.roomNickname;
        info.avatarUrlString = ext.roomAvatar;
    }
    info.avatarImage = self.defaultUserAvatar;
    return info;
}

//机器人
- (NIMKitInfo *)infoByRobot:(NSString *)userId
{
    NIMKitInfo  *info = nil;
    if ([[NIMSDK sharedSDK].robotManager isValidRobot:userId]) {
        NIMRobot *robot = [[NIMSDK sharedSDK].robotManager robotInfo:userId];
        if (robot) {
            info = [[NIMKitInfo alloc]init];
            info.infoId = userId;
            info.showName = robot.nickname;
            info.avatarUrlString = robot.thumbAvatarUrl;
            info.avatarImage = self.defaultUserAvatar;
        }
    }
    return info;
}
//昵称优先级
- (NSString *)nickname:(NIMUser *)user
            memberInfo:(NIMTeamMember *)memberInfo
                option:(NIMKitInfoFetchOption *)option
{
    NSString *name = nil;
    do{
        if (!option.forbidaAlias && [user.alias length]) {
            name = user.alias;
            break;
        }
        if (memberInfo && [memberInfo.nickname length]) {
            name = memberInfo.nickname;
            break;
        }
        if ([user.userInfo.nickName length]) {
            name = user.userInfo.nickName;
            break;
        }
    }while(0);
    return name;
}

@end
