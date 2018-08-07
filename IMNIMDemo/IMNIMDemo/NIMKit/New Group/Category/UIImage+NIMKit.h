//
//  UIImage+NIMKit.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/5.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NIMKit)

+ (UIImage *)nim_fetchEmoticon:(NSString *)imageNameOrPath;

+ (UIImage *)nim_fetchChartlet:(NSString *)imageName chartletId:(NSString *)chartletId;

+ (CGSize)nim_sizeWithImageOriginSize:(CGSize)originSize
                              minSize:(CGSize)imageMinSize
                              maxSize:(CGSize)imageMaxSize;

+ (UIImage *)nim_imageInKit:(NSString *)imageName;

+ (UIImage *)nim_emoticonInKit:(NSString *)imageName;

- (UIImage *)nim_imageForAvatarUpload;

@end
