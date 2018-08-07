//
//  IMAVNotifier.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMAVNotifier : NSObject

- (void)start:(NSString *)text;

- (void)stop;

@end
