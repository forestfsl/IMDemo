//
//  IMMainTabController.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/4.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMMainTabController.h"
#import "AppDelegate.h"
#import "IMNotificationCenter.h"
#import "IMCustomNotificationDB.h"

#define TabbarVC @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabbarItemBadgeValue @"badgeValue"
#define TabbarCount 4

typedef NS_ENUM(NSUInteger, IMMainTabType) {
    IMMainTabTypeMessageList, //聊天
    IMMainTabTypeContact, //通讯录
    IMMainTabTypeChatroomList, //聊天室
    IMMainTabTypeSetting,   //设置
};

@interface IMMainTabController ()<NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate>

@property (nonatomic, strong) NSArray *navigationHandlers;
@property (nonatomic, assign) NSInteger sessionUnreadCount;
@property (nonatomic, assign) NSInteger systemUnreadCount;
@property (nonatomic, assign) NSInteger customSystemUnreadCount;
@property (nonatomic, copy) NSDictionary *configs;

@end

@implementation IMMainTabController

+ (instancetype)instance{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegate.window.rootViewController;
    if ([vc isKindOfClass:[IMMainTabController class]]) {
        return (IMMainTabController *)vc;
    }else{
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubNav];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCustomNotifyChanged:) name:IMCustomNotificationCountChanged object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpStatusBar];
}

- (void)dealloc
{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpStatusBar
{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:NO];
}

- (void)setUpSubNav{
    NSMutableArray *handleArray = [[NSMutableArray alloc]init];
    NSMutableArray *vcArray = [[NSMutableArray alloc]init];
    [self.tabbars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *item = [self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title = item[TabbarTitle];
        NSString *imageName = item[TabbarImage];
        NSString *imageSelected = item[TabbarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [[clazz alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = NO;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:imageSelected]];
        nav.tabBarItem.tag = idx;
        NSInteger badge = [item[TabbarItemBadgeValue] integerValue];
        if (badge) {
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        //TODO  NTESNavigationHandler *handler = [[NTESNavigationHandler alloc] initWithNavigationController:nav];
//        nav.delegate = handler;
        [vcArray addObject:nav];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
}

- (NSArray *)tabbars{
    self.sessionUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    self.systemUnreadCount = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
    //TODO 这个自定义系统通知功能还没有去了解，所以先不写
    self.customSystemUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    self.systemUnreadCount = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
    self.customSystemUnreadCount = [[IMCustomNotificationDB sharedInstance] unreadCount];
    NSMutableArray *items = [[NSMutableArray alloc]init];
    for (NSInteger tabbar = 0; tabbar < TabbarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}


#pragma mark -VC

- (NSDictionary *)vcInfoForTabType:(IMMainTabType)type
{
    if (_configs == nil) {
        _configs = @{
                     @(IMMainTabTypeMessageList):@{TabbarVC : @"IMSessionListViewController",
                                                   TabbarTitle : @"云信",
                                                   TabbarImage : @"icon_message_normal",
                                                   TabbarSelectedImage:@"icon_message_pressed",
                                                   TabbarItemBadgeValue:@(self.sessionUnreadCount)
                                                   },
                     @(IMMainTabTypeContact) : @{TabbarVC : @"IMContactViewController",
                                                 TabbarTitle : @"通讯录",
                                                 TabbarImage : @"icon_contact_normal",
                                                 TabbarSelectedImage : @"icon_contact_pressed",
                                                 TabbarItemBadgeValue : @(self.systemUnreadCount)
                                                 },
                     @(IMMainTabTypeChatroomList) : @{TabbarVC : @"IMChatroomListViewController",
                                                 TabbarTitle : @"直播间",
                                                 TabbarImage : @"icon_chatroom_normal",
                                                 TabbarSelectedImage : @"icon_chatroom_pressed",
                                                 TabbarItemBadgeValue : @(self.systemUnreadCount)
                                                 },
                     @(IMMainTabTypeSetting)     : @{
                             TabbarVC           : @"IMSettingViewController",
                             TabbarTitle        : @"设置",
                             TabbarImage        : @"icon_setting_normal",
                             TabbarSelectedImage: @"icon_setting_pressed",
                             TabbarItemBadgeValue: @(self.customSystemUnreadCount)
                             }
                     };
    }
    return _configs[@(type)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NIMSystemNotificationManagerDelegate

#pragma mark - Notification
- (void)onCustomNotifyChanged:(NSNotification *)notification
{
    IMCustomNotificationDB *db = [IMCustomNotificationDB sharedInstance];
    self.customSystemUnreadCount = db.unreadCount;
    [self refreshSettingBadge];
}

- (void)refreshSettingBadge
{
    UINavigationController *nav = self.viewControllers[IMMainTabTypeSetting];
    NSInteger badge = self.systemUnreadCount;
    nav.tabBarItem.badgeValue = badge ? @(badge).stringValue : nil;
}

@end
