//
//  NIMInputAtCache.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/16.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NIMInputAtStartChar  @"@"
#define NIMInputAtEndChar    @"\u2004"


@interface NIMInputAtItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) NSRange range;

@end

@interface NIMInputAtCache : NSObject

- (NSArray *)allAtUid:(NSString *)sendText;

- (void)clean;

- (void)addAtItem:(NIMInputAtItem *)item;

- (NIMInputAtItem *)item:(NSString *)name;

- (NIMInputAtItem *)removeName:(NSString *)name;
@end
