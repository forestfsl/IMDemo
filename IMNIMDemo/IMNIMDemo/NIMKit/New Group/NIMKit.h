//
//  NIMKit.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  基础Model
 */
#import "NIMKitInfo.h"
#import "NIMKitInfoFetchOption.h"

/**
 * 协议
 */
#import "NIMCellConfig.h"           //message cell配置协议
#import "NIMKitDataProvider.h"      //APP内容提供器

/**
 *  UI 配置器
 */
#import "NIMKitConfig.h"


#import "NIMCellLayoutConfig.h"


/*
 *  独立聊天室模式下需注入的信息
 */
#import "NIMKitIndependentModeExtraInfo.h"


@interface NIMKit : NSObject

+ (instancetype)sharedKit;

/**
 * 注册自定义的排版配置，通过注册自定义排版配置来实现自定义消息的定制化排版
 */
- (void)registerLayoutConfig:(NIMCellLayoutConfig *)layoutConfig;

/**
 * 返回当前的排版配置
 */
- (id<NIMCellLayoutConfig>)layoutConfig;


/**
 * UI 配置器
 */
@property (nonatomic, strong) NIMkitConfig *config;


/**
 * 内容提供者，由上层开发者注入，如果没有则使用默认provider
 */
@property (nonatomic, strong) id<NIMKitDataProvider> provider;

/**
 *  由于在独立聊天室模式下, IM 部分服务不可用，需要上层注入一些额外信息供组件显示使用。 默认为 nil，上层在独立聊天室模式下注入，注入时需要创建此对象并注入对象相关字段信息。
 *
 *  此字段需要配合默认的 NIMKitDataProvider ( NIMKitDataProviderImpl ) 使用，如果上层自己定义了 provider ， 则忽略此字段。
 */
@property (nonatomic,strong)  NIMKitIndependentModeExtraInfo *independentModeExtraInfo;

/**
 * NIMKit 图片资源所在的bundle名称
 */
@property (nonatomic, copy) NSString *resourceBundleName;

/**
 * NIMKit 表情资源所在的bundle名称
 */
@property (nonatomic, copy) NSString *emoticonBundleName;

/**
 * 用户信息变更通知接口
 * @param userIds 用户 id集合
 */
- (void)notifyUserInfoChanged:(NSArray *)userIds;

/**
 * 群消息变更通知接口
 * @param teamIds 群 id 集合
 */
- (void)notifyTeamInfoChanged:(NSArray *)teamIds;

/**
 * 群成员变更通知接口
 * @param teamIds 群id
 */
- (void)notifyTeamMembersChanged:(NSArray *)teamIds;

/**
 * 返回用户信息
 */
- (NIMKitInfo *)infoByUser:(NSString *)userId
                    option:(NIMKitInfoFetchOption *)option;

/**
 * 返回群消息
 */
- (NIMKitInfo *)infoByTeam:(NSString *)teamId
                    option:(NIMKitInfoFetchOption *)option;





@end
