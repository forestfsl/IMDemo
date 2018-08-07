//
//  IMDemoService.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMDemoRegisterTask.h"
#import "IMDemoFetchChatroomTask.h"

@interface IMDemoService : NSObject

+ (instancetype)sharedService;

- (void)registerUser:(IMRegisterData *)data
          completion:(IMRegisterHandler)completion;

- (void)fetchDemoChatrooms:(IMChatroommListHandler)completion;

@end
