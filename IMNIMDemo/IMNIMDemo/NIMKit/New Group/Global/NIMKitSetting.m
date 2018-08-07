//
//  NIMKitSetting.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/5.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMKitSetting.h"
#import "UIImage+NIMKit.h"

@implementation NIMKitSetting

- (instancetype)init:(BOOL)isRight
{
    if (self = [super init]) {
        if (isRight) {
            _normalBackgroundImage = [[UIImage nim_imageInKit:@"icon_sender_text_node_normal"]
                                      resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
            _highLightBackgroundImage = [[UIImage nim_imageInKit:@"icon_sender_text_node_pressed"]
                                         resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
        }
        else
        {
            _normalBackgroundImage    =  [[UIImage nim_imageInKit:@"icon_receiver_node_normal"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
            _highLightBackgroundImage =  [[UIImage nim_imageInKit:@"icon_receiver_node_pressed"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
        }
    }
    return self;
}

@end
