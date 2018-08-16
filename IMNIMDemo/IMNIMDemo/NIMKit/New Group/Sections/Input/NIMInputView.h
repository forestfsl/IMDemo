//
//  NIMInputView.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/15.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMInputProtocol.h"
#import "NIMSessionConfig.h"
#import "NIMInputToolBar.h"
#import "NIMInputAtCache.h"

@class NIMInputMoreContainerView;
@class NIMInputEmoticonContainerView;

typedef NS_ENUM(NSInteger, NIMAudioRecordPhase) {
    AudioRecordPhaseStart,
    AudioRecordPhaseRecording,
    AudioRecordPhaseCancelling,
    AudioRecordPhaseEnd
};


@protocol NIMInputDelegate <NSObject>

@optional

- (void)didChangeInputHeight:(CGFloat)inputHeight;

@end

@interface NIMInputView : UIView

@end
