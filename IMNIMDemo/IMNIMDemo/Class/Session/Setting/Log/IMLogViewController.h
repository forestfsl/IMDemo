//
//  IMLogViewController.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMLogViewController : UIViewController
- (instancetype)initWithFilepath:(NSString *)path;
- (instancetype)initWithContent:(NSString *)content;
@end
