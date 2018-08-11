//
//  IMPersonalCardViewController.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMPersonalCardViewController : UIViewController
- (instancetype)initWithUserId:(NSString *)userId;

@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
