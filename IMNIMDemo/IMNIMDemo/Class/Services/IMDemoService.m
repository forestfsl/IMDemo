//
//  IMDemoService.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMDemoService.h"

@interface IMDemoService ()
@property (nonatomic,strong)    NSURLSession    *session;
@end

@implementation IMDemoService

+ (instancetype)sharedService{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}



- (void)registerUser:(IMRegisterData *)data
          completion:(IMRegisterHandler)completion{
    IMDemoRegisterTask *task = [[IMDemoRegisterTask alloc] init];
    task.data = data;
    task.handler = completion;
    [self runTask:task];
}

- (void)fetchDemoChatrooms:(IMChatroommListHandler)completion{
    IMDemoFetchChatroomTask *task = [[IMDemoFetchChatroomTask alloc] init];
    task.handler = completion;
    [self runTask:task];
}

- (void)runTask:(id<IMDemoServiceTask>)task
{
    if ([[NIMSDK sharedSDK] isUsingDemoAppKey])
    {
        NSURLRequest *request = [task taskRequest];
        
        NSURLSessionTask *sessionTask = [_session dataTaskWithRequest:request
                                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable connectionError) {
                                                        id jsonObject = nil;
                                                        NSError *error = connectionError;
                                                        if (connectionError == nil &&
                                                            [response isKindOfClass:[NSHTTPURLResponse class]] &&
                                                            [(NSHTTPURLResponse *)response statusCode] == 200)
                                                        {
                                                            if (data)
                                                            {
                                                                jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                             options:0
                                                                                                               error:&error];
                                                            }
                                                            else
                                                            {
                                                                error = [NSError errorWithDomain:@"ntes domain"
                                                                                            code:-1
                                                                                        userInfo:@{@"description" : @"invalid data"}];
                                                                
                                                            }
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [task onGetResponse:jsonObject
                                                                          error:error];
                                                        });
                                                        
                                                        
                                                    }];
        [sessionTask resume];
    }
    else
    {
        //Demo Service中我们模拟了APP服务器所应该实现的部分功能，上层开发需要构建相应的APP服务器，而不是直接使用我们的DEMO服务器
        [task onGetResponse:nil
                      error:[NSError errorWithDomain:@"ntes domain"
                                                code:-1
                                            userInfo:@{@"description" : @"use your own app server"}]];
    }
}

@end
