//
//  IMMutiClientsCell.m
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/8.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMMutiClientsCell.h"
#import "IMClientUtil.h"
#import "UIView+IM.h"
#import "IMGlobalMacro.h"

@implementation IMMutiClientsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textLabel.font = [UIFont systemFontOfSize:17.f];
    self.textLabel.textColor = UIColorFromRGB(0x333333);
}

- (void)refreshWidthCilent:(NIMLoginClient *)client{
//    self.textLabel.text = [self ]
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect hitRect = self.kickBtn.frame;
    return CGRectContainsPoint(hitRect, point) ? self : nil;
}
- (NSString *)nameWithClient:(NIMLoginClient *)client
{
    NSString *name = [IMClientUtil clientName:client.type];
    return name.length ? [NSString stringWithFormat:@"正在使用云信%@版",name] : @"正在使用云信未知版本";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.textLabel sizeToFit];
    self.textLabel.centerY = self.height * .5f;
}

@end
