//
//  NIMInputProtocol.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/15.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NIMMediaItem;


@protocol NIMInputActionDelegate <NSObject>

@optional

- (BOOL)onTapMediaItem:(NIMMediaItem *)item;

- (void)onTextChange:(id)sender;

- (void)onSendText:(NSString *)text
           atUsers:(NSArray *)atUsers;

- (void)onSelectCharlet:(NSString *)chartletId
                catalog:(NSString *)catalogId;

- (void)onCancelRecording;

- (void)onStopRecording;

- (void)onStartRecording;

- (void)onTapMoreBtn:(id)sender;

- (void)onTapEmoticonBtn:(id)sender;

- (void)onTapVoickBtn:(id)sender;

@end

