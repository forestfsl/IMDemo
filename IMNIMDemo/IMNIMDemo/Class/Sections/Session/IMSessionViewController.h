//
//  IMSessionViewController.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMSessionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMSessionViewController : NIMSessionViewController

@property (nonatomic, assign) BOOL disableCommandTyping; //需要在导航条上显示正在输入

@property (nonatomic, assign) BOOL disableOnlineState; //需要在导航条上显示在线状态

@end

NS_ASSUME_NONNULL_END
