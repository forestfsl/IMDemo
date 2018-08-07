//
//  IMDemoConfig.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>


@class IMRedPacketConfig;

@interface IMDemoConfig : NSObject

+ (instancetype)sharedConfig;

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *apiURL;
@property (nonatomic, copy) NSString *apnsCername;
@property (nonatomic, copy) NSString *pkCername;
@property (nonatomic, strong) IMRedPacketConfig *redPacketConfig;

- (void)registerConfig:(NSDictionary *)config;


@end



@interface IMRedPacketConfig : NSObject

@property (nonatomic, assign) BOOL useOnlineEnv;
@property (nonatomic, strong) NSString *aliPaySchemeUrl;
@property (nonatomic, strong) NSString *weChatSchemeUrl;
@end
