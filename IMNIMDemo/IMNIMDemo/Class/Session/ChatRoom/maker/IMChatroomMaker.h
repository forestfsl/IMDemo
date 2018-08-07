//
//  IMChatroomMaker.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMChatroomMaker : NSObject

+ (nullable NIMChatroom *)makeChatroom:(nonnull NSDictionary *)dict;

@end
