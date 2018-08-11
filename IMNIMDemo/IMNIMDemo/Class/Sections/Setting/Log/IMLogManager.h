//
//  IMLogManager.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMLogManager : NSObject

+ (instancetype)sharedManager;

- (void)start;

- (UIViewController *)demoLogViewController;
- (UIViewController *)sdkLogViewController;
- (UIViewController *)sdkNetCallLogViewController;
- (UIViewController *)sdkNetDetectLogViewController;
- (UIViewController *)demoConfigViewController;

@end
