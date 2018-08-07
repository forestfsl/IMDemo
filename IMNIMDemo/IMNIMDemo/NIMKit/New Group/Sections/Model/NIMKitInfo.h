//
//  NIMKitInfo.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIMKitInfo : NSObject

/**
 *  id 如果是用户信息，为用户id；如果是群消息，为群id
 */
@property (nonatomic, copy) NSString *infoId;

/**
 *  显示名
 */
@property (nonatomic, copy) NSString *showName;

//如果avatarUrlString为nil，则显示头像图片
//如果avatarUrlString不为nil，则将头像图片当做占位图，当下载完成后显示头像url指定的图片

/**
 * 头像url
 */
@property (nonatomic, copy) NSString *avatarUrlString;

/**
 * 头像图片
 */
@property (nonatomic, strong) UIImage *avatarImage;




@end
