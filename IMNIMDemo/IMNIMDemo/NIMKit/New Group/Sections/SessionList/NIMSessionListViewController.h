//
//  NIMSessionListViewController.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NIMSDK/NIMSDK.h>
#import "NIMCellConfig.h"

@interface NIMSessionListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NIMLoginManagerDelegate,NIMConversationManagerDelegate>

/**
 * 会话列表tableView
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 * 最近会话集合
 */
@property (nonatomic, strong) NSMutableArray *recentSessions;

@end
