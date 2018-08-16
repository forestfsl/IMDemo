//
//  IMSWhiteboardAttachment.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMCustomAttachmentInfo.h"

typedef NS_ENUM(NSUInteger, CustomWhiteboardFlag) {
    CustomWhiteboardFlagInvite   = 0,//邀请
    CustomWhiteboardFlagClose    = 1,//关闭
};

@interface IMSWhiteboardAttachment : NSObject<NIMCustomAttachment,IMCustomAttachmentInfo>

@property (nonatomic, assign) CustomWhiteboardFlag flag;

@end
