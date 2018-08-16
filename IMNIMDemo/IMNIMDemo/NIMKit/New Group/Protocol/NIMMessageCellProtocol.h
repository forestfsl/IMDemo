//
//  NIMMessageCellProtocol.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/15.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMCellConfig.h"

@class NIMMessageModel;
@class NIMMessage;
@class NIMKitEvent;

@protocol NIMMessageCellDelegate<NSObject>

@optional

#pragma mark - cell 样式更改
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (BOOL)disableAudioPlayedStatusIcon:(NIMMessage *)message;

#pragma mark - 点击事件
- (BOOL)onTapCell:(NIMKitEvent *)event;
- (BOOL)onLongPressCell:(NIMMessage *)message
                 inView:(UIView *)view;
- (BOOL)onTapAvatar:(NIMMessage *)message;

- (BOOL)onLongPressAvatar:(NIMMessage *)message;

- (BOOL)onPressReadLabel:(NIMMessage *)message;

- (void)onRetryMessage:(NIMMessage *)message;
@end
