//
//  IMDemoServiceTask.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/7.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMDemoServiceTask <NSObject>
- (NSURLRequest *)taskRequest;
- (void)onGetResponse:(id)jsonObject
                error:(NSError *)error;

@end
