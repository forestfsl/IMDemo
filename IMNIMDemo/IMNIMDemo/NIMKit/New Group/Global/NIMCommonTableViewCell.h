//
//  NIMCommonTableViewCell.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NIMCommonTableRow;

@protocol NIMCommonTableViewCell <NSObject>

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@optional
- (void)refreshData:(NIMCommonTableRow *)rowData tableView:(UITableView *)tableView;

@end
