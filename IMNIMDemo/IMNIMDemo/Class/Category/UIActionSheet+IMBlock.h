//
//  UIActionSheet+IMBlock.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetBlock)(NSInteger);

@interface UIActionSheet (IMBlock)<UIActionSheetDelegate>

- (void)showInView:(UIView *)view completionHandler:(ActionSheetBlock)block;

- (void)clearActionBlock;

@end
