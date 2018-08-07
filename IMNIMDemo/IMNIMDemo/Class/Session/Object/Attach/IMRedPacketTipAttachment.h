//
//  IMRedPacketTipAttachment.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMRedPacketTipAttachment : NSObject<NIMCustomAttachment,IMCustomAttachmentInfo>

/**
 * 红包发送者ID
 */
@property (nonatomic, strong) NSString *sendPacketId;

/**
 * 拆红包的人的ID
 */
@property (nonatomic, strong) NSString *openPacketId;

/**
 * 红包ID
 */
@property (nonatomic, strong) NSString *packetId;

/**
 * 是否为最后一个红包
 */
@property (nonatomic, strong) NSString *isGetDone;

@end
