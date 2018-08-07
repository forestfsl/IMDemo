//
//  IMService.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMService <NSObject>
@optional
- (void)onCleanData;
- (void)onReceiveMemoryWarning;
- (void)onEnterBackground;
- (void)onEnterForeground;
- (void)onAppWillTerminate;

@end

@interface IMService : NSObject<IMService>
+ (instancetype)sharedInstance;

//空方法，只是输出log而已
//大部分的NIMService懒加载即可，但是有些因为业务需要在登录后就需要立马生成
- (void)start;

@end


@interface IMServiceManager: NSObject

+ (instancetype)sharedManager;

- (void)start;
- (void)destory;

@end
