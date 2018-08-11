//
//  IMSubscribeDefine.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#ifndef IMSubscribeDefine_h
#define IMSubscribeDefine_h

extern NSString *const IMSubscribeNetState;

extern NSString *const IMSubscribeOnlineState;

typedef NS_ENUM(NSInteger, IMCustomStateValue) {
    IMCustomStateValueOnlineExt = 10001,
};


typedef NS_ENUM(NSInteger, IMOnlineState){
    IMOnlineStateNormal, //在线
    IMOnlineStateBusy,   //忙碌
    IMOnlineStateLeave,  //离开
};



#endif /* IMSubscribeDefine_h */
