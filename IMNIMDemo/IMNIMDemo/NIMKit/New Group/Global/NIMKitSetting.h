//
//  NIMKitSetting.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/5.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 气泡设置
 */

@interface NIMKitSetting : NSObject

/**
 * 设置消息ContentView 内间距
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;

/**
 * 设置消息ContentView的文字颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 * 设置消息ContentView的文字字体
 */
@property (nonatomic, strong) UIFont *font;

/**
 * 设置消息是否显示头像
 */
@property (nonatomic, assign) BOOL showAvatar;

/**
 * 设置消息普通模式下的背景图
 */
@property (nonatomic, strong) UIImage *normalBackgroundImage;

/**
 * 设置消息按压模式下的背景图
 */
@property (nonatomic, strong) UIImage *highLightBackgroundImage;

- (instancetype)init:(BOOL)isRight;

@end
