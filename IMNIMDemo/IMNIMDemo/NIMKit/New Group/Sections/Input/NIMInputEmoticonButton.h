//
//  NIMInputEmoticonButton.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/16.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIMInputEmoticon;

@protocol NIMMEmoticonButtonTouchDelegate <NSObject>

- (void)selectedEmoticon:(NIMInputEmoticon *)emoticon catalogID:(NSString *)catalogID;

@end

@interface NIMInputEmoticonButton : UIButton

@property (nonatomic, strong) NIMInputEmoticon *emoticonData;
@property (nonatomic, copy) NSString *catalogID;

@property (nonatomic, weak) id<NIMMEmoticonButtonTouchDelegate> delegate;

+ (NIMInputEmoticonButton *)iconButtonWithData:(NIMInputEmoticon *)data
                                     catalogID:(NSString *)catalogID delegate:(id<NIMMEmoticonButtonTouchDelegate>)delegate;

- (void)onIconSelected:(id)sender;

@end
