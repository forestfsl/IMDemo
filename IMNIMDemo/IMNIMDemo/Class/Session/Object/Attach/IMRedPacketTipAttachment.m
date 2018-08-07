//
//  IMRedPacketTipAttachment.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMRedPacketTipAttachment.h"
#import "M80AttributedLabel.h"
#import "NIMKit.h"

@interface IMRedPacketTipAttachment ()

@property (nonatomic, weak) NIMMessage *message;

@end

@implementation IMRedPacketTipAttachment

- (NSString *)encodeAttachment{
    NSDictionary *dictContent = @{
                                  CMRedPacketSendId:self.sendPacketId,
                                  CMRedPacketOpenId:self.openPacketId,
                                  CMRedPacketId:self.packetId,
                                  CMRedPacketDone:self.isGetDone,
                                  };
    NSDictionary *dict = @{CMType:@(CustomMessageTypeRedPacketTip),CMData:dictContent};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width
{
    self.message = message;
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:Notification_Font_Size];
    CGFloat messageWidth = width;
    
    [label appendImage:[UIImage imageNamed:@"icon_redpacket_tip"]];
    [label appendText:self.formatedMessage];
    label.numberOfLines = 0;
    label.autoDetectLinks = NO;
    CGFloat padding = [NIMKit sharedKit].config.maxNotificationTipPadding;
    CGSize size = [label sizeThatFits:CGSizeMake(width - 2 * padding, CGFLOAT_MAX)];
    CGFloat cellPadding = 11.f;
    CGSize contentSize = CGSizeMake(messageWidth, size.height + 2 * cellPadding);
    return contentSize;
}


@end
