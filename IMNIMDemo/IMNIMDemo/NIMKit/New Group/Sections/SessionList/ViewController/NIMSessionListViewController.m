//
//  NIMSessionListViewController.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "NIMSessionListViewController.h"
#import "UIView+IM.h"
#import "IMBundleSetting.h"
#import "IMSessionUtil.h"
#import "IMRedPacketTipAttachment.h"
#import "NIMKit.h"
#import "NIMSessionViewController.h"
#import "NIMKitUtil.h"

#define SessionListTitle @"云信 Demo"

@interface NIMSessionListViewController ()<NIMLoginManagerDelegate,NIMEventSubscribeManagerDelegate,UIViewControllerPreviewingDelegate>

@end

@implementation NIMSessionListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
    [[NIMSDK sharedSDK].loginManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _recentSessions = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    if (!self.recentSessions.count) {
        _recentSessions = [NSMutableArray array];
    }
    else
    {
        _recentSessions = [self customSortRecents:_recentSessions];
    }
    
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
    
    extern NSString *const NIMKitTeamInfoHasUpdatedNotification;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTeamInfoHasUpdatedNotification:) name:NIMKitTeamInfoHasUpdatedNotification object:nil];
    
    extern NSString *const NIMKitTeamMembersHasUpdatedNotification;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTeamMembersHasUpdatedNotification:) name:NIMKitTeamMembersHasUpdatedNotification object:nil];
    
    extern NSString *const NIMKitUserInfoHasUpdatedNotification;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserInfoHasUpdatedNotification:) name:NIMKitUserInfoHasUpdatedNotification object:nil];
    
}

#pragma mark - Notification
- (void)onUserInfoHasUpdatedNotification:(NSNotification *)notification{
    [self refresh];
}

- (void)onTeamInfoHasUpdatedNotification:(NSNotification *)notification{
    [self refresh];
}

- (void)onTeamMembersHasUpdatedNotification:(NSNotification *)notification{
    [self refresh];
}

- (void)refresh{
    if (!self.recentSessions.count) {
        self.tableView.hidden = YES;
    }else{
        self.tableView.hidden = NO;
    }
    [self.tableView reloadData];
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NIMRecentSession *recentSession = self.recentSessions[indexPath.row];
    [self onSelectedRecent:recentSession atIndexPath:indexPath];
}


#pragma mark - UITableViewDataSource



#pragma mark - Override

-(void)onSelectedAvatar:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath{};

- (void)onSelectedRecent:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath
{
    NIMSessionViewController *vc = [[NIMSessionViewController alloc]initWithSession:recent.session];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSString *)nameForRecentSession:(NIMRecentSession *)recent{
    if (recent.session.sessionType == NIMSessionTypeP2P) {
        return [NIMKitUtil showNick:recent.session.sessionId inSession:recent.session];
    }else{
        NIMTeam *team = [[NIMSDK sharedSDK].teamManager teamById:recent.session.sessionId];
        return team.teamName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
