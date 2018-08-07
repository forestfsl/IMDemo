//
//  NIMMessageModel.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIMMessageModel : NSObject

/**
 * 消息数据
 */
@property (nonatomic, strong) NIMMessage *message;

/**
 * 时间戳
 
 * @discussion 这个时间戳为缓存的界面显示的时间戳，消息发出的时候记录下本地时间，由于NIMMessage在服务器确认收到后会将自身发送时间timestamp字段修正为服务器时间，所以缓存当前发送的本地时间避免刷新时由于发送时间修改导致的消息界面跳跃
 * messageTime 和 message。timestamp 会有一定的误差
 *
 *
 */

@property (nonatomic, readonly) NSTimeInterval messageTime;

@property (nonatomic, readonly) UIEdgeInsets contentViewInsets;

@property (nonatomic, readonly) UIEdgeInsets bubbleViewInsets;

@property (nonatomic, readonly) CGPoint avatarMargin;

@property (nonatomic, readonly) CGPoint nickNameMargin;

@property (nonatomic, readonly) CGSize avatarSize;

@property (nonatomic, readonly) BOOL shouldShowAvatar;

@property (nonatomic, readonly) BOOL shouldShowNickName;

@property (nonatomic, readonly) BOOL shouldShowLeft;

@property (nonatomic) BOOL shouldShowReadLabel;

/**
 * NIMMessage 封装成NIMMessageModel 的方法
 * @param message 消息体
 * @return NIMMessageModel 实例
 */
- (instancetype)initWithMessage:(NIMMessage *)message;

/**
 *  清除缓存的排版数据
 */
- (void)cleanCache;


/**
 * 计算内容大小
 */
- (CGSize)contentSize:(CGFloat)width;
@end
