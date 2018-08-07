//
//  IMCustomNotificationObject.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMCustomNotificationObject.h"

@implementation IMCustomNotificationObject

- (instancetype)initWithNotification:(NIMCustomSystemNotification *)notification{
    if (self = [super init]) {
        _sender = notification.sender;
        _receiver = notification.receiver;
        _timestamp = notification.timestamp;
        _content = notification.content;
        _needBadge = notification.setting.shouldBeCounted;
    }
    return self;
}

@end
