//
//  IMDemoFetchChatroomTask.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMDemoServiceTask.h"
#import "IMChatroomMaker.h"

typedef void(^IMChatroommListHandler)(NSError *error,NSArray<NIMChatroom *> *chatroom);

@interface IMDemoFetchChatroomTask : NSObject

@property (nonatomic, copy) IMChatroommListHandler handler;

@end
