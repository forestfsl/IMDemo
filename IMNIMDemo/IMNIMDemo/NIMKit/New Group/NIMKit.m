//
//  NIMKit.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMKit.h"



extern NSString *const NIMKitUserInfoHasUpdateNotification;
extern NSString *const NIMKitTeamInfoHasUpdatedNotification;


@interface NIMKit (){
    NSRegularExpression *_urlRegex;
}

@property (nonatomic, strong) id<NIMCellLayoutConfig> layoutConfig;
@end

@implementation NIMKit

- (instancetype)init{
    if (self = [super init]) {
        _resourceBundleName = @"NIMKitResource.bundle";
        _emoticonBundleName = @"NIMKitEmoticon.bundle";
        
        _layoutConfig = [[NIMCellLayoutConfig alloc]init];
       
    }
    return self;
}


+ (instancetype)sharedKit{
    static NIMKit *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NIMKit alloc]init];
    });
    return instance;
}

- (void)registerLayoutConfig:(NIMCellLayoutConfig *)layoutConfig{
    if ([layoutConfig isKindOfClass:[NIMCellLayoutConfig class]]) {
        self.layoutConfig = layoutConfig;
    }
    else
    {
        NSAssert(0, @"class should be subclass or NIMLayoutConfig");
    }
}


- (NIMkitConfig *)config
{
    //不要放在NIMKit初始化里面，因为UIConfig初始化会使用NIMKit，防止死循环
    if (!_config) {
        _config = [[NIMkitConfig alloc]init];
    }
    return _config;
}

- (id<NIMCellLayoutConfig>)layoutConfig{
    return _layoutConfig;
}
@end
