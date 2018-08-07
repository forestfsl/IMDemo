//
//  IMLoginData.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMLoginData : NSObject

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *token;

@end

@interface IMLoginManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) IMLoginData *currentLoginData;

@end


