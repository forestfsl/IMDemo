//
//  NIMMediaItem.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/5.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIMMediaItem : NSObject

@property (nonatomic, assign) SEL selctor;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, copy) NSString *title;

+ (NIMMediaItem *)item:(NSString *)selector
           normalImage:(UIImage *)normalImage
         selectedImage:(UIImage *)selectedImage
                 title:(NSString *)title;


@end
