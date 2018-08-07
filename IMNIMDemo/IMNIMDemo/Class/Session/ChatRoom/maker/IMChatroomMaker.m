//
//  IMChatroomMaker.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMChatroomMaker.h"
#import "NSDictionary+IMJson.h"


@implementation IMChatroomMaker

+ (NIMChatroom *)makeChatroom:(NSDictionary *)dict
{
    BOOL status = [dict jsonInteger:@"status"];
    if (status)
    {
        NIMChatroom *chatroom = [[NIMChatroom alloc] init];
        chatroom.roomId  = [dict jsonString:@"roomid"];
        chatroom.name    = [dict jsonString:@"name"];
        chatroom.creator = [dict jsonString:@"creator"];
        chatroom.announcement = [dict jsonString:@"announcement"];
        chatroom.ext     = [dict jsonString:@"ext"];
        chatroom.onlineUserCount = [dict jsonInteger:@"onlineusercount"];
        return chatroom;
    }
    else
    {
        return nil;
    }
}

@end
