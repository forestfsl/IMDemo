//
//  IMSessionUtil.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMSessionUtil.h"

@implementation IMSessionUtil


+ (NSString *)formatAutoLoginMessage:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"自动登录失败 %@",error];
    NSString *domain = error.domain;
    NSInteger code = error.code;
    if ([domain isEqualToString:NIMLocalErrorDomain]) {
        if (code == NIMLocalErrorCodeAutoLoginRetryLimit) {
            message = @"自动登录错误次数超限，请检查网络后重试";
        }
    }else if ([domain isEqualToString:NIMRemoteErrorDomain])
    {
        if (code == NIMRemoteErrorCodeInvalidPass) {
            message = @"密码错误";
        }
        else if (code == NIMRemoteErrorCodeExist)
        {
            message = @"当前已经登录其他设备，请使用手动模式登录";
        }
    }
    return message;
}

@end
