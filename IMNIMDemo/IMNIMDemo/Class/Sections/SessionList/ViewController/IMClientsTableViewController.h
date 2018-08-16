//
//  IMClientsTableViewController.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMClientsTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end


@interface IMClientsTableHeader : UIView


@property (nonatomic, strong) UIImageView *icon;
@end

NS_ASSUME_NONNULL_END
