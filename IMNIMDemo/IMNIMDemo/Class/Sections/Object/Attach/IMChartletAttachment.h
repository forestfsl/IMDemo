//
//  IMChartletAttachment.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMCustomAttachmentInfo.h"

@interface IMChartletAttachment : NSObject<NIMCustomAttachment,IMCustomAttachmentInfo>

@property (nonatomic, copy) NSString *chartletId;
@property (nonatomic, copy) NSString *chartletCatalog;
@property (nonatomic, strong) UIImage *showCoverImage;

@end
