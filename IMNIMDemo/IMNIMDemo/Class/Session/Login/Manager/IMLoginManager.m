//
//  IMLoginData.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMLoginManager.h"
#import "IMFileLocationHelper.h"


#define NIMAccount      @"account"
#define NIMToken        @"token"

@interface IMLoginData()<NSCoding>


@end

@implementation IMLoginData

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _account = [aDecoder decodeObjectForKey:NIMAccount];
        _token = [aDecoder decodeObjectForKey:NIMToken];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if ([_account length]) {
        [aCoder encodeObject:_account forKey:NIMAccount];
    }
    if ([_token length]) {
        [aCoder encodeObject:_token forKey:NIMToken];
    }
}

@end


@interface IMLoginManager ()

@property (nonatomic, copy) NSString *filePath;


@end

@implementation IMLoginManager

+ (instancetype)sharedManager
{
    static IMLoginManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filepath = [[IMFileLocationHelper getAppDocumentPath] stringByAppendingPathComponent:@"nim_sdk_ntes_login_data"];
        instance = [[IMLoginManager alloc] initWithPath:filepath];
    });
    return instance;
}

- (void)setCurrentLoginData:(IMLoginData *)currentLoginData
{
    _currentLoginData = currentLoginData;
    [self saveData];
}



- (instancetype)initWithPath:(NSString *)filePath
{
    if (self = [super init]) {
        _filePath = filePath;
        [self readData];
    }
    return self;
}


- (void)saveData
{
    NSData *data = [NSData data];
    if (_currentLoginData) {
        data = [NSKeyedArchiver archivedDataWithRootObject:_currentLoginData];
    }
    [data writeToFile:[self filePath] atomically:YES];
}

- (void)readData
{
    NSString *filepath = [self filePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
        _currentLoginData = [object isKindOfClass:[IMLoginData class]] ? object : nil;
    }
}
@end
