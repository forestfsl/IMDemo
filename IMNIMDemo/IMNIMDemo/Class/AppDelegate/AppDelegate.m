//
//  AppDelegate.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "AppDelegate.h"
#import "IMMainTabController.h"
#import "IMSDKConfigDelegate.h"
#import "IMBundleSetting.h"
#import "IMDemoConfig.h"
#import "IMService.h"
#import "IMLoginManager.h"
#import "IMLoginViewController.h"
#import "IMClientUtil.h"
#import "IMSessionUtil.h"

NSString *IMNotificationLogout = @"IMNotificationLogout";

@interface AppDelegate ()<NIMLoginManagerDelegate>

@property (nonatomic, strong) IMSDKConfigDelegate *sdkConfigDelegate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupNIMSDK];
    
    [self commonInitListenEvents];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setupMainViewController];
    return YES;
}


- (void)setupNIMSDK
{
    //配置额外配置信息（需要在注册appkey前完成）
    self.sdkConfigDelegate = [[IMSDKConfigDelegate alloc]init];
    [[NIMSDKConfig sharedConfig] setDelegate:self.sdkConfigDelegate];
    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:0];
    [[NIMSDKConfig sharedConfig] setMaximumLogDays:[[IMBundleSetting sharedConfig] maximumLogDays]];
    [[NIMSDKConfig sharedConfig] setShouldCountTeamNotification:[[IMBundleSetting sharedConfig] countTeamNotification]];
    [[NIMSDKConfig sharedConfig] setAnimatedImageThumbnailEnabled:[[IMBundleSetting sharedConfig] animatedImageThumbnailEnabled]];
    
    //appkey 是应用的标识，不同应用之间的数据（用户，消息，群组等）是完全隔离的
    //如需打网易云信 Demo 包，请勿修改 appkey ，开发自己的应用时，请替换为自己的 appkey 。
    //并请对应更换 Demo 代码中的获取好友列表、个人信息等网易云信 SDK 未提供的接口。
    NSString *appKey = [[IMDemoConfig sharedConfig] appKey];
    NIMSDKOption *option = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername = [[IMDemoConfig sharedConfig] apnsCername];
    option.pkCername = [[IMDemoConfig sharedConfig] pkCername];
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    //注册自定义消息的解析器
//    [NIMCustomObject registerCustomDecoder:<#(nonnull id<NIMCustomAttachmentCoding>)#>]
    //注册 NIMKit 自定义排版配置
//    [[NIMKit sharedKit] registerLayoutConfig:[NTESCellLayoutConfig new]];
    BOOL isUsingDemoAppKey = [[NIMSDK sharedSDK] isUsingDemoAppKey];
    [[NIMSDKConfig sharedConfig] setTeamReceiptEnabled:isUsingDemoAppKey];
    
}

- (void)setupMainViewController
{
    IMLoginData *data = [[IMLoginManager sharedManager] currentLoginData];
    NSString *account = [data account];
    NSString *token = [data token];
    
    //如果有缓存用户名密码，推荐使用自动登录
    if ([account length] && [token length]) {
        NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
        loginData.account = account;
        loginData.token = token;
        
        [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];
        [[IMServiceManager sharedManager] start];
        IMMainTabController *mainTab = [[IMMainTabController alloc] initWithNibName:nil bundle:nil];
        self.window.rootViewController = mainTab;
    }
    else
    {
        [self setupLoginViewController];
    }
    
}

- (void)commonInitListenEvents
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:IMNotificationLogout object:nil];
    [[[NIMSDK sharedSDK] loginManager ] addDelegate:self];
}


- (void)setupLoginViewController
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    IMLoginViewController *loginVC = [[IMLoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}


#pragma mar - 注销
- (void)logout:(NSNotification *)note
{
    [self doLogout];
}

- (void)doLogout
{
    [[IMLoginManager sharedManager] setCurrentLoginData:nil];
    [[IMServiceManager sharedManager] destory];
    [self setupLoginViewController];
}


#pragma NIMLoginManagerDelegate

- (void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType
{
    NSString *reason = @"你被踢下线";
    switch (code) {
        case NIMKickReasonByClient:
        case NIMKickReasonByClientManually:
        {
            NSString *clientName = [IMClientUtil clientName:clientType];
            reason = clientName.length ? [NSString stringWithFormat:@"你的账号被%@端踢出下线，请注意账号信息安全",clientName] : @"你的账号被踢出下线，请注意账号信息安全";
        }
            break;
        case NIMKickReasonByServer:
            reason = @"你被服务器踢下线";
            break;
        default:
            break;
    }
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:IMNotificationLogout object:nil];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"下线通知" message:reason delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)onAutoLoginFailed:(NSError *)error
{
    //只有连接发生严重错误才会走这个回调，在这个回调里应该登出，返回界面等待用户手动重新登录
    DDLogInfo(@"onAutoLoginFailed %zd",error.code);
    [self showAutoLoginErrorAlert:error];
}

#pragma mark - 登录错误回调
- (void)showAutoLoginErrorAlert:(NSError *)error
{
    NSString *message = [IMSessionUtil formatAutoLoginMessage:error];
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"自动登录失败" message:message preferredStyle:UIAlertControllerStyleAlert];
    if ([error.domain isEqualToString:NIMLocalErrorDomain] && error.code == NIMLocalErrorCodeAutoLoginRetryLimit) {
        UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            IMLoginData *data = [[IMLoginManager sharedManager] currentLoginData];
            NSString *account = [data account];
            NSString *token = [data token];
            if ([account length] && [token length]) {
                NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc]init];
                loginData.account = account;
                loginData.token = token;
                [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];
            }
        }];
        [vc addAction:retryAction];
    }
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:IMNotificationLogout object:nil];
        }];
    }];
    [vc addAction:logoutAction];
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
