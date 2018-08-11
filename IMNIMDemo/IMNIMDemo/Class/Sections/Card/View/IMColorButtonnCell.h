//
//  IMColorButtonnCell.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, ColorButtonCellStyle) {
    ColorButtonCellStyleRed,
    ColorButtonCellStyleBlue,
};

@class IMColorButton;

@interface IMColorButtonnCell : UITableViewCell<NIMCommonTableViewCell>

@property (nonatomic, strong) IMColorButton *button;

@end


@interface IMColorButton : UIButton
@property (nonatomic,assign) ColorButtonCellStyle style;


@end

NS_ASSUME_NONNULL_END
