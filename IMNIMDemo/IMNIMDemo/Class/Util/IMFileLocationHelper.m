//
//  IMFileLocationHelper.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMFileLocationHelper.h"
#import <sys/stat.h>
#import "IMDemoConfig.h"


#define RDVideo (@"video")
#define RDImage (@"image")

@interface IMFileLocationHelper ()
+ (NSString *)filepathForDir:(NSString *)dirname filename:(NSString *)filename;

@end

@implementation IMFileLocationHelper

+ (BOOL)addSkipBackupAttibuteToItemAtURL:(NSURL *)URL{
    assert([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (!success) {
        DDLogError(@"Error excluding %@ from backup %@",[URL lastPathComponent], error);
    }
    return success;
}


+ (NSString *)getAppDocumentPath{
    static NSString *appDocumentPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *apppKey = [[IMDemoConfig sharedConfig] appKey];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        appDocumentPath = [[NSString alloc]initWithFormat:@"%@/%@",[paths objectAtIndex:0],apppKey];
        if (![[NSFileManager defaultManager] fileExistsAtPath:appDocumentPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:appDocumentPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        [IMFileLocationHelper addSkipBackupAttibuteToItemAtURL:[NSURL fileURLWithPath:appDocumentPath]];
    });
    return appDocumentPath;
}

+ (NSString *)getAppTempPath{
    return NSTemporaryDirectory();
}

+ (NSString *)userDirectory{
    NSString *documentPath = [IMFileLocationHelper getAppDocumentPath];
    NSString *userID = [NIMSDK sharedSDK].loginManager.currentAccount;
    if ([userID length] == 0) {
        DDLogDebug(@"Error:Get User Directory While UserID Is Empty");
    }
    NSString *userDirectory = [NSString stringWithFormat:@"%@%@/",documentPath,userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:userDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:userDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return userDirectory;
}

+ (NSString *)resourceDir: (NSString *)resourceName
{
    NSString *dir = [[IMFileLocationHelper userDirectory] stringByAppendingString:resourceName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return dir;
}

+ (NSString *)filepathForVideo:(NSString *)filename{
    return [IMFileLocationHelper filepathForDir:RDVideo filename:filename];
}

+ (NSString *)filepathForImage:(NSString *)filename{
    return [IMFileLocationHelper filepathForDir:RDImage filename:filename];
}

+ (NSString *)genFilenameWithExt:(NSString *)ext{
    CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuid);
    CFRelease(uuid);
    NSString *uuidStr = [[uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
    NSString *name = [NSString stringWithFormat:@"%@",uuidStr];
    return [ext length] ? [NSString stringWithFormat:@"%@.%@",name,ext] : name;
}

#pragma mark - 辅助方法
+ (NSString *)filepathForDir:(NSString *)dirname filename:(NSString *)filename{
    return [[IMFileLocationHelper resourceDir:dirname] stringByAppendingString:filename];
}
@end
