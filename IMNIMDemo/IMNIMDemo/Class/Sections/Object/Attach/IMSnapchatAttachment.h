//
//  IMSnapchatAttachment.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMCustomAttachmentInfo.h"

@interface IMSnapchatAttachment : NSObject<NIMCustomAttachment,IMCustomAttachmentInfo>

@property (nonatomic, copy) NSString *md5;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL isFired; //是否焚毁
@property (nonatomic, strong) UIImage *showCoverImage;

- (void)setImage:(UIImage *)image;

- (void)setImageFilePath:(NSString *)path;

- (NSString *)filepath;

@end
