//
//  NIMSessionListCell.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/10.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NIMAvatarImageView;
@class NIMRecentSession;
@class NIMBadgeView;

NS_ASSUME_NONNULL_BEGIN

@interface NIMSessionListCell : UITableViewCell

@property (nonatomic, strong) NIMAvatarImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) NIMBadgeView *badgeView;

- (void)refresh:(NIMRecentSession *)recent;

@end

NS_ASSUME_NONNULL_END
