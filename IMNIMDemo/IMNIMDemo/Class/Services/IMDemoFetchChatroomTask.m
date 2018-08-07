//
//  IMDemoFetchChatroomTask.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMDemoFetchChatroomTask.h"
#import "IMDemoConfig.h"
#import "NSDictionary+IMJson.h"

@implementation IMDemoFetchChatroomTask


- (NSURLRequest *)taskRequest
{
    NSString *urlString = [[[IMDemoConfig sharedConfig] apiURL] stringByAppendingString:@"/chatroom/homeList"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"GET"];
    [request addValue:[IMDemoConfig sharedConfig].appKey forHTTPHeaderField:@"appkey"];
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    return request;
    
}


- (void)onGetResponse:(id)jsonObject
                error:(NSError *)error
{
    NSMutableArray *chatrooms = nil;
    NSError *resultError = error;
    
    if (error == nil && [jsonObject isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary *)jsonObject;
        NSInteger code = [dict jsonInteger:@"res"];
        resultError = code == 200 ? nil : [NSError errorWithDomain:@"ntes domain"
                                                              code:code
                                                          userInfo:nil];
        if (resultError == nil)
        {
            chatrooms = [NSMutableArray array];
            NSDictionary *msg = [dict jsonDict:@"msg"];
            NSArray *list = [msg jsonArray:@"list"];
            for (NSDictionary *item in list) {
                NIMChatroom *chatroom = [IMChatroomMaker makeChatroom:item];
                if (chatroom)
                {
                    [chatrooms addObject:chatroom];
                }
            }
        }
    }
    
    
    if (_handler) {
        _handler(resultError,chatrooms);
    }
    
    
    
    
}
@end
