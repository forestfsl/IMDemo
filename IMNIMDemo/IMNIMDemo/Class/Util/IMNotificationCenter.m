//
//  IMCustomNotificationCountChanged.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMNotificationCenter.h"
#import <AVFoundation/AVFoundation.h>
#import "IMAVNotifier.h"
#import "IMRedPacketTipAttachment.h"
#import "IMMainTabController.h"
#import "NIMSessionViewController.h"


NSString *IMCustomNotificationCountChanged = @"IMCustomNotificationCountChanged";

@interface IMNotificationCenter () <NIMSystemNotificationManagerDelegate,NIMNetCallManagerDelegate,
NIMRTSManagerDelegate,NIMChatManagerDelegate,NIMBroadcastManagerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player; //播放提示音
@property (nonatomic, strong) IMAVNotifier *notifier;

@end

@implementation IMNotificationCenter

+ (instancetype)sharedCenter{
    static IMNotificationCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IMNotificationCenter alloc]init];
    });
    return instance;
}

- (void)start{
    DDLogInfo(@"Notification Center Setup");
}

- (instancetype)init{
    if (self = [super init]) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"message" withExtension:@"wav"];
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        _notifier = [[IMAVNotifier alloc]init];
        [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
        [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
        [[NIMAVChatSDK sharedSDK].rtsManager addDelegate:self];
        [[NIMSDK sharedSDK].chatManager addDelegate:self];
        [[NIMSDK sharedSDK].broadcastManager addDelegate:self];
    }
    return self;
}

- (void)dealloc{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
    [[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
    [[NIMAVChatSDK sharedSDK].rtsManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [[NIMSDK sharedSDK].broadcastManager removeDelegate:self];
}

#pragma mark - NIMChatManagerDelegate

- (void)onRecvMessages:(NSArray<NIMMessage *> *)recvMessages{
    NSArray *messages = [self filterMessages:recvMessages];
    
}

- (NSArray *)filterMessages:(NSArray *)messages{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NIMMessage *message in messages) {
        if ([self checkRedPacketTip:message] && ![self canSaveMessageRedPackTip:message]) {
            [[NIMSDK sharedSDK].conversationManager deleteMessage:message];
//            [self.currentSessionViewController ]
        }
    }
    return array;
}


#pragma mark - Misc
- (NIMSessionViewController *)currentSessionViewController
{
    UINavigationController *nav = [IMMainTabController instance].selectedViewController;
    for (UIViewController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:[NIMSessionViewController class]]) {
            return (NIMSessionViewController *)vc;
        }
    }
    return nil;
}

- (BOOL)canSaveMessageRedPackTip:(NIMMessage *)message
{
    NIMCustomObject *object = message.messageObject;
    IMRedPacketTipAttachment *attach = (IMRedPacketTipAttachment *)object.attachment;
    NSString *me = [NIMSDK sharedSDK].loginManager.currentAccount;
    return [attach.sendPacketId isEqualToString:me] || [attach.openPacketId isEqualToString:me];
}



- (BOOL)checkRedPacketTip:(NIMMessage *)message
{
    NIMCustomObject *object = message.messageObject;
    if ([object isKindOfClass:[NIMCustomObject class]] && [object.attachment isKindOfClass:[IMRedPacketTipAttachment class]]) {
        return YES;
    }
    return NO;
}

@end
