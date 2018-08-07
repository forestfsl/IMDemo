//
//  IMService.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMService.h"

#pragma mark -NIMServiceManagerImpl

@interface IMServiceManagerImpl : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSMutableDictionary *singletons;
@end

@implementation IMServiceManagerImpl

+ (IMServiceManagerImpl *)coreImpl:(NSString *)key{
    IMServiceManagerImpl *impl = [[IMServiceManagerImpl alloc]init];
    impl.key = key;
    return impl;
}

- (instancetype)init{
    if (self = [super init]) {
        _singletons = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (instancetype)singletonByClass:(Class)singletonClass{
    NSString *singletonClassName = NSStringFromClass(singletonClass);
    id singleton = [_singletons objectForKey:singletonClassName];
    if (!singleton) {
        singleton = [[singletonClass alloc]init];
        [_singletons setObject:singleton forKey:singletonClassName];
    }
    return singleton;
}

- (void)callSingletonSelector:(SEL)selector{
    NSArray *array = [_singletons allValues];
    for (id obj in array) {
        if ([obj respondsToSelector:selector]) {
            SuppressPerformSelectorLeakWarning([obj performSelector:selector]);
        }
    }
}
@end


#pragma mark - IMServiceManager()

@interface IMServiceManager()

@property (nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic, strong) IMServiceManagerImpl *core;
+ (instancetype)sharedManager;
- (id)singletonByClass:(Class)singletonClass;

@end



@implementation IMService

+ (instancetype)sharedInstance{
    return [[IMServiceManager sharedManager] singletonByClass:[self class]];
}

- (void)start{
//     DDLogDebug(@"NIMService %@ Started", self);
}

@end

#pragma mark - IMServiceManager

@implementation IMServiceManager

+ (instancetype)sharedManager{
    static IMServiceManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IMServiceManager alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callAppWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)start{
    [_lock lock];
    NSString *key = [[[NIMSDK sharedSDK] loginManager] currentAccount];
    _core = [IMServiceManagerImpl coreImpl:key];
    [_lock unlock];
}

- (void)destory{
    [_lock lock];
    [self callSingletonClean];
    _core = nil;
    [_lock unlock];
}

- (id)singletonByClass:(Class)singletonClass{
    id instance = nil;
    [_lock lock];
    instance = [_core singletonByClass:singletonClass];
    [_lock unlock];
    return instance;
}

#pragma mark - Call Functions
- (void)callSingletonClean{
    [self callSelector:@selector(onCleanData)];
}

- (void)callReceiveMemoryWarning{
    [self callSelector:@selector(onReceiveMemoryWarning)];
}

- (void)callEnterBackground{
    [self callSelector:@selector(onEnterBackground)];
}

- (void)callEnterForeground{
    [self callSelector:@selector(onEnterForeground)];
}

- (void)callAppWillTerminate{
    [self callSelector:@selector(onAppWillTerminate)];
}

- (void)callSelector:(SEL)selector{
    [_core callSingletonSelector:selector];
}
@end
