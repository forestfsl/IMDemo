//
//  IMCustomAttachmentInfo.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#ifndef IMCustomAttachmentInfo_h
#define IMCustomAttachmentInfo_h

typedef NS_ENUM(NSUInteger, IMCustomMessageType) {
    CustomMessageTypeJanKenPon = 1, //剪刀石头布
    CustomMessageTypeSnapchat = 2, //阅后即焚
    CustomMessageTypeChartlet = 3, //贴图表情
    CustomMessageTypeWhiteboard = 4, //白板会话
    CustomMessageTypeRedPacket = 5, //红包消息
    CustomMessageTypeRedPacketTip = 6, //红包提示消息
};

#define CMType             @"type"
#define CMData             @"data"
#define CMValue            @"value"
#define CMFlag             @"flag"
#define CMURL              @"url"
#define CMMD5              @"md5"
#define CMFIRE             @"fired"        //阅后即焚消息是否被焚毁
#define CMCatalog          @"catalog"      //贴图类别
#define CMChartlet         @"chartlet"     //贴图表情ID
//红包
#define CMRedPacketTitle   @"title"        //红包标题
#define CMRedPacketContent @"content"      //红包内容
#define CMRedPacketId      @"redPacketId"  //红包ID
//红包详情
#define CMRedPacketSendId     @"sendPacketId"
#define CMRedPacketOpenId     @"openPacketId"
#define CMRedPacketDone       @"isGetDone"



#endif /* IMCustomAttachmentInfo_h */


@protocol IMCustomAttachmentInfo <NSObject>

@optional

- (NSString *)cellContent:(NIMMessage *)message;

- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width;

- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message;

- (NSString *)formatedMessage;

- (UIImage *)showCoverImage;

- (BOOL)shouldShowAvatar;

- (void)setShowCoverImage:(UIImage *)image;

- (BOOL)canBeRevoked;

- (BOOL)canBeForwarded;
@end
