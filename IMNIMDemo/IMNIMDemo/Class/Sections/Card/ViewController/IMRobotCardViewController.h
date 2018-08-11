//
//  IMRobotCardViewController.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMAvatarImageView.h"
#import "IMColorButtonnCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMRobotCardViewController : UIViewController

@property (nonatomic,strong) IBOutlet NIMAvatarImageView *avatarImageView;

@property (nonatomic,strong) IBOutlet UILabel *userIdLabel;

@property (nonatomic,strong) IBOutlet UILabel *nickLabel;

@property (nonatomic,strong) IBOutlet UILabel *introLabel;

- (instancetype)initWithUserId:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
