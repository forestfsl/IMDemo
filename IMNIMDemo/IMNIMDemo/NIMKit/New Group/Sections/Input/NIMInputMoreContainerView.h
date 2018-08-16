//
//  NIMInputMoreContainerView.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/15.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMSessionConfig.h"
#import "NIMInputProtocol.h"

@interface NIMInputMoreContainerView : UIView

@property (nonatomic, weak) id<NIMSessionConfig> config;
@property (nonatomic, weak) id<NIMInputActionDelegate>actionDelegate;


@end
