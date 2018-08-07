//
//  NIMSessionConfigurateProtocol.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#ifndef NIMSessionConfigurateProtocol_h
#define NIMSessionConfigurateProtocol_h

#import <NIMSDK/NIMSDK.h>
#import "NIMMessageModel.h"

@protocol NIMSessionInteractorDelegate <NSObject>

- (void)didFetchMessageData;

- (void)didRefreshMessageData;

- (void)didPullUpMessageData;

@end


@protocol NIMSessionInteractor <NSObject>

//网络接口
- (void)sendMessage:(NIMMessage *)message;

- (void)sendMessageReceipt:(NSArray *)message;

//界面操作接口
- (void)addMessage:(NSArray *)message;

- (void)insertMessages:(NSArray *)messages;

- (NIMMessageModel *)updateMessage:(NIMMessage *)message;

- (NIMMessageModel *)deleteMessage:(NIMMessage *)message;

//数据接口
- (NSArray *)items;

- (void)markRead;

- (NIMMessageModel *)findMessageModel:(NIMMessageModel *)message;

- (BOOL)shouldHandleReceipt;

- (void)checkReceipts:(NSArray<NIMMessageReceipt *> *)receipts;

- (void)resetMessages:(void(^)(NSError *error))handler;

- (void)loadMessages:(void (^)(NSError *error))handler;

- (void)pullUpMessages:(void(^)(NSArray *messages,NSError *error))handler;

- (NSInteger)findMessageIndex:(NIMMessage *)message;

//排版接口
- (void)resetLayout;

- (void)changeLayout:(CGFloat)inputHeight;

- (void)cleanCache;

- (void)pullUp;

//按钮响应接口
- (void)mediaAudioPressed:(NIMMessageModel *)messageModel;

- (void)mediaPicturePressed;

- (void)mediaShootPressed;

- (void)mediaLocationPressed;

//页面转态同步接口
- (void)onViewWillAppear;

- (void)onViewDidDisappear;



@end
#endif /* NIMSessionConfigurateProtocol_h */
