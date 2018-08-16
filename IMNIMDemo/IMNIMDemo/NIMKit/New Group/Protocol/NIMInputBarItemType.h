//
//  NIMInputBarItemType.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#ifndef NIMInputBarItemType_h
#define NIMInputBarItemType_h

typedef NS_ENUM(NSUInteger, NIMInputBarItemType) {
    NIMInputBarItemTypeVoice,         //录音文本切换按钮
    NIMInputBarItemTypeTextAndRecord, //文本输入框或录音按钮
    NIMInputBarItemTypeEmoticon,      //表情贴图
    NIMInputBarItemTypeMore,          //更多菜单
};

#endif /* NIMInputBarItemType_h */
