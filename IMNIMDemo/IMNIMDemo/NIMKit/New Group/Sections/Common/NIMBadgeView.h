//
//  NIMBadgeView.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/10.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface NIMBadgeView : UIView

@property (nonatomic, copy) NSString *badgeValue;

+ (instancetype)viewWithBadgeTip:(NSString *)badgeValue;

@end

NS_ASSUME_NONNULL_END
