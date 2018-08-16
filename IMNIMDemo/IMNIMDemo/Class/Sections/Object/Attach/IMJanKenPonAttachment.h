//
//  IMJanKenPonAttachment.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMCustomAttachmentInfo.h"

typedef NS_ENUM(NSUInteger, CustomJanKenPonValue) {
    CustomJanKenPonValueKen   = 1,//石头
    CustomJanKenPonValueJan   = 2,//剪子
    CustomJanKenPonValuePon  = 3,//布
};

@interface IMJanKenPonAttachment : NSObject<NIMCustomAttachment,IMCustomAttachmentInfo>

@property (nonatomic, assign) CustomJanKenPonValue value;
@property (nonatomic, strong) UIImage *showCoverImage;

@end
