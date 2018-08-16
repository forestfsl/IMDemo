//
//  IMRedPacketAttachment.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMCustomAttachmentInfo.h"

@interface IMRedPacketAttachment : NSObject<NIMCustomAttachment,IMCustomAttachmentInfo>

@property (nonatomic, copy) NSString *redPacketId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end
