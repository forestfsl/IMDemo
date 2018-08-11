//
//  NSString+NIMKit.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/10.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NIMKit)

- (CGSize)nim_stringSizeWithFont:(UIFont *)font;

- (NSString *)nim_MD5String;

- (NSUInteger)nim_getBytesLength;

- (NSString *)nim_stringByDeletingPictureResolution;

- (UIColor *)nim_hexToColor;

@end

NS_ASSUME_NONNULL_END
