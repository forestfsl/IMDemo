//
//  NIMInputEmoticonButton.m
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/16.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMInputEmoticonButton.h"
#import "UIImage+NIMKit.h"
#import "NIMInputEmoticonManager.h"



@implementation NIMInputEmoticonButton

+ (NIMInputEmoticonButton *)iconButtonWithData:(NIMInputEmoticon *)data catalogID:(NSString *)catalogID delegate:(id<NIMMEmoticonButtonTouchDelegate>)delegate{
    NIMInputEmoticonButton *icon = [[NIMInputEmoticonButton alloc] init];
    [icon addTarget:icon action:@selector(onIconSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage nim_fetchEmoticon:data.filename];
    
    icon.emoticonData = data;
    icon.catalogID = catalogID;
    icon.userInteractionEnabled = YES;
    icon.exclusiveTouch = YES;
    icon.contentMode = UIViewContentModeScaleToFill;
    icon.delegate = delegate;
    [icon setImage:image forState:UIControlStateNormal];
    [icon setImage:image forState:UIControlStateHighlighted];
    return icon;
}

- (void)onIconSelected:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(selectedEmoticon:catalogID:)]) {
        [self.delegate selectedEmoticon:self.emoticonData catalogID:self.catalogID];
    }
}

@end
