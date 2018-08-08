//
//  NIMSessionViewController.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NIMSessionViewController : UIViewController



/**
 初始化会话

 @param session 所属会话
 @return 会话页实例
 */
- (instancetype)initWithSession:(NIMSession *)session;

@end
