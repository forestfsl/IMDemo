//
//  IMMutiClientsCell.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NIMSDK/NIMSDK.h>

@interface IMMutiClientsCell : UITableViewCell


@property (nonatomic,strong) IBOutlet UIButton *kickBtn;

- (void)refreshWidthCilent:(NIMLoginClient *)client;

@end
