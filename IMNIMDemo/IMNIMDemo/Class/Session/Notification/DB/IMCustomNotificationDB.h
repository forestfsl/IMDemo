//
//  IMCustomNotificationDB.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMService.h"

@class IMCustomNotificationObject;

@interface IMCustomNotificationDB : IMService

@property (nonatomic, assign) NSInteger unreadCount;

- (NSArray *)fetchNotifications:(IMCustomNotificationObject *)notification
                          limit:(NSInteger)limit;

- (BOOL)saveNotification:(IMCustomNotificationObject *)notification;

- (void)deleteNotification:(IMCustomNotificationObject *)notification;

- (void)deleteAllNotification;

- (void)markAllNotificationAsRead;

@end
