//
//  NIMMediaItem.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/5.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMMediaItem.h"

@implementation NIMMediaItem

+ (NIMMediaItem *)item:(NSString *)selector normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    NIMMediaItem *item = [[NIMMediaItem alloc]init];
    item.selctor = NSSelectorFromString(selector);
    item.normalImage = normalImage;
    item.selectedImage = selectedImage;
    item.title = title;
    return item;
}

@end
