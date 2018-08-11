//
//  IMTextHeaderView.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMListHeader.h"

@interface IMTextHeaderView : UIButton<IMListHeaderView>

@property (nonatomic, strong) UILabel *label;

@end
