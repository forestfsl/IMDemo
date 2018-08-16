//
//  NIMSessionListCell.m
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/10.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMSessionListCell.h"
#import "NIMAvatarImageView.h"
#import "UIView+NIMKit.h"
#import "NIMKitUtil.h"
#import "NIMBadgeView.h"

@implementation NIMSessionListCell
#define AvatarWidth 40


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [[NIMAvatarImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:_avatarImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:_nameLabel];
        
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _messageLabel.backgroundColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:14.f];
        _messageLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_messageLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_timeLabel];
        _badgeView = [NIMBadgeView viewWithBadgeTip:@""];
        [self addSubview:_badgeView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#define NameLabelMaxWidth 160.f
#define MessageLabelMaxWidth 200.f

- (void)refresh:(NIMRecentSession *)recent
{
    self.nameLabel.nim_width = self.nameLabel.nim_width > NameLabelMaxWidth ? NameLabelMaxWidth : self.nameLabel.nim_width;
    self.messageLabel.nim_width = self.messageLabel.nim_width > MessageLabelMaxWidth ? MessageLabelMaxWidth : self.messageLabel.nim_width;
    if (recent.unreadCount) {
        self.badgeView.hidden = NO;
        self.badgeView.badgeValue = @(recent.unreadCount).stringValue;
    }else{
        self.badgeView.hidden = YES;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //Session List
    NSInteger sessionListAvatarLeft             = 15;
    NSInteger sessionListNameTop                = 15;
    NSInteger sessionListNameLeftToAvatar       = 15;
    NSInteger sessionListMessageLeftToAvatar    = 15;
    NSInteger sessionListMessageBottom          = 15;
    NSInteger sessionListTimeRight              = 15;
    NSInteger sessionListTimeTop                = 15;
    NSInteger sessionBadgeTimeBottom            = 15;
    NSInteger sessionBadgeTimeRight             = 15;
    
    _avatarImageView.nim_left    = sessionListAvatarLeft;
    _avatarImageView.nim_centerY = self.nim_height * .5f;
    _nameLabel.nim_top           = sessionListNameTop;
    _nameLabel.nim_left          = _avatarImageView.nim_right + sessionListNameLeftToAvatar;
    _messageLabel.nim_left       = _avatarImageView.nim_right + sessionListMessageLeftToAvatar;
    _messageLabel.nim_bottom     = self.nim_height - sessionListMessageBottom;
    _timeLabel.nim_right         = self.nim_width - sessionListTimeRight;
    _timeLabel.nim_top           = sessionListTimeTop;
    _badgeView.nim_right         = self.nim_width - sessionBadgeTimeRight;
    _badgeView.nim_bottom        = self.nim_height - sessionBadgeTimeBottom;
}
@end
