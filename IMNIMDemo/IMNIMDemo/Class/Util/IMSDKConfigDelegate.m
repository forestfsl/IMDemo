//
//  IMSDKConfigDelegate.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMSDKConfigDelegate.h"
#import "IMBundleSetting.h"


@implementation IMSDKConfigDelegate


- (BOOL)shouldIgnoreNotification:(NIMNotificationObject *)notification
{
    BOOL ignore = NO;
    NIMNotificationContent *content = notification.content;
    if ([content isKindOfClass:[NIMTeamNotificationContent class]]) { //这里做个示范如何忽略部分通知
        NSArray *types = [[IMBundleSetting sharedConfig] ignoreTeamNotificationTypes];
        NIMTeamOperationType type =[(NIMTeamNotificationContent *)content  operationType];
        for (NSString *item in types) {
            if (type == [item integerValue]) {
                ignore = YES;
                break;
            }
        }
    }
    return ignore;
}

@end
