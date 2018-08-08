//
//  IMListHeader.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IMListHeaderType) {
    ListHeaderTypeCommonText = 1,
    ListHeaderTypeNetStauts,
    ListHeaderTypeLoginClients,
};


@protocol IMListHeaderView<NSObject>


@required

- (void)setContentText:(NSString *)content;

@end

@protocol IMListHeaderViewDelegate <NSObject>


@optional
- (void)didSelectRowType:(IMListHeaderType)type;

@end


@interface IMListHeader : UIView

@property (nonatomic, weak) id<IMListHeaderViewDelegate> delegate;

- (void)refreshWithType:(IMListHeaderType)type value:(id)value;

@end
