//
//  IMClientUtil.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMClientUtil.h"

@implementation IMClientUtil

+ (NSString *)clientName:(NIMLoginClientType)clientType
{
    switch (clientType) {
        case NIMLoginClientTypeiOS:
        case NIMLoginClientTypeAOS:
        case NIMLoginClientTypeWP:
            return @"移动";
            break;
        case NIMLoginClientTypePC:
        case NIMLoginClientTypemacOS:
            return @"电脑";
            break;
        case NIMLoginClientTypeWeb:
            return @"网页";
            break;
        default:
            return @"";
            break;
    }
}

@end
