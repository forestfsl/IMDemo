//
//  IMDemoRegisterTask.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMDemoServiceTask.h"

typedef void(^IMRegisterHandler)(NSError *error, NSString *errorMsg);


@interface IMRegisterData : NSObject

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *nickname;

@end

@interface IMDemoRegisterTask : NSObject<IMDemoServiceTask>

@property (nonatomic, strong) IMRegisterData *data;
@property (nonatomic, copy) IMRegisterHandler handler;


@end
