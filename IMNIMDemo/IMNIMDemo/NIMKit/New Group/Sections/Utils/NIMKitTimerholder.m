//
//  NIMKitTimerholder.m
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMKitTimerholder.h"

@interface NIMKitTimerholder()
{
    NSTimer *_timer;
    BOOL _repeats;
}

- (void)onTimer:(NSTimer *)timer;

@end


@implementation NIMKitTimerholder

- (void)dealloc
{
    [self stopTimer];
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
    _timerDelegate = nil;
}

- (void)startTimer:(NSTimeInterval)seconds delegaate:(id<NIMKitTimerHolderDelegate>)delegate repeats:(BOOL)repeats
{
    _timerDelegate = delegate;
    _repeats = repeats;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(onTimer:) userInfo:nil repeats:repeats];
}

- (void)onTimer:(NSTimer *)timer
{
    
    if (!_repeats) {
        _timer = nil;
    }
    if (_timerDelegate && [_timerDelegate respondsToSelector:@selector(onNIMKitTimerFired:)]) {
        [_timerDelegate onNIMKitTimerFired:self];
    }
}
@end
