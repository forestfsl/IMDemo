//
//  IMCustomNotificationCountChanged.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IMCustomNotificationDB;

extern NSString *IMCustomNotificationCountChanged;

@interface IMNotificationCenter : NSObject

+ (instancetype)sharedCenter;
- (void)start;

@end
