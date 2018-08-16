//
//  NIMInputEmoticonTabView.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/15.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIMInputEmoticonTabView;

@protocol NIMInputEmoticonTabDelegate <NSObject>

- (void)tableView:(NIMInputEmoticonTabView *)tableView didSelectTableIndex:(NSInteger)index;


@end

@interface NIMInputEmoticonTabView : UIControl

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, weak) id<NIMInputEmoticonTabDelegate> delegate;

- (void)selectTabIndex:(NSInteger)index;
- (void)loadCatalogs:(NSArray *)emoticonCatalogs;

@end
