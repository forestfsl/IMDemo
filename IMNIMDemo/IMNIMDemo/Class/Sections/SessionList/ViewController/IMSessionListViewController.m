//
//  IMSessionListViewController.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMSessionListViewController.h"
#import "UIView+IM.h"
#import "IMListHeader.h"
#import "IMRedPacketTipAttachment.h"
#import "IMSessionUtil.h"
#import "IMBundleSetting.h"
#import "IMSessionViewController.h"
#import "IMRobotCardViewController.h"
#import "IMPersonalCardViewController.h"

#define SessionListTitle @"云信 Demo"


@interface IMSessionListViewController ()<NIMLoginManagerDelegate,NIMEventSubscribeManagerDelegate,UIViewControllerPreviewingDelegate,IMListHeaderViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) IMListHeader *header;
@property (nonatomic, assign) BOOL supportsForceTouch;
@property (nonatomic, strong) NSMutableDictionary *previews;

@end

@implementation IMSessionListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _previews = [[NSMutableDictionary alloc]init];
        self.autoRemoveRemoteSession = [[IMBundleSetting sharedConfig] autoRemoveRemoteSession];
    }
    return self;
}

- (void)dealloc{
    [[NIMSDK sharedSDK].loginManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.supportsForceTouch = [self.traitCollection respondsToSelector:@selector(forceTouchCapability)] && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
    [[NIMSDK sharedSDK].subscribeManager addDelegate:self];
    self.header = [[IMListHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    self.header.delegate = self;
    [self.view addSubview:self.header];
    
    
    self.emptyTipLabel = [[UILabel alloc]init];
    self.emptyTipLabel.text = @"还没有会话，在通讯录中找个人聊聊吧";
    [self.emptyTipLabel sizeToFit];
    self.emptyTipLabel.hidden = self.recentSessions.count;
    [self.view addSubview:self.emptyTipLabel];
    
    NSString *userID = [[[NIMSDK sharedSDK] loginManager] currentAccount];
    self.navigationItem.titleView = [self titleView:userID];
    
    [self setupNavItem];
}

- (void)setupNavItem{
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:[UIImage imageNamed:@"icon_sessionlist_more_normal"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"icon_sessionlist_more_pressed"] forState:UIControlStateHighlighted];
    [moreBtn sizeToFit];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = moreItem;
}

- (void)refresh{
    [super refresh];
    self.emptyTipLabel.hidden = self.recentSessions.count;
}


- (void)more:(id)sender
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *markAllMessagesReadAction = [UIAlertAction actionWithTitle:@"标记所有消息为已读" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NIMSDK sharedSDK].conversationManager markAllMessagesRead];
    }];
    [vc addAction:markAllMessagesReadAction];
    
    UIAlertAction *cleanAllMessageAction = [UIAlertAction actionWithTitle:@"清理所有消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BOOL removeRecentSessions = [IMBundleSetting sharedConfig].removeSessionWhenDeleteMessages;
        BOOL removeTables = [IMBundleSetting sharedConfig].dropTableWhenDeleteMessages;
        
        NIMDeleteMessagesOption *option = [[NIMDeleteMessagesOption alloc]init];
        option.removeSession = removeRecentSessions;
        option.removeTable = removeTables;
        [[NIMSDK sharedSDK].conversationManager deleteAllMessages:option];
    }];
    [vc addAction:cleanAllMessageAction];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [vc addAction:cancel];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)onSelectedRecent:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath{
    IMSessionViewController *sessionVC = [[IMSessionViewController alloc]initWithSession:recent.session];
    [self.navigationController pushViewController:sessionVC animated:YES];
}


- (void)onSelectedAvatar:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath{
    if (recent.session.sessionType == NIMSessionTypeP2P) {
        UIViewController *vc;
        if ([[NIMSDK sharedSDK].robotManager isValidRobot:recent.session.sessionId]) {
            vc = [[IMRobotCardViewController alloc]initWithUserId:recent.session.sessionId];
        }
        else
        {
            vc = [[IMPersonalCardViewController alloc]initWithUserId:recent.session.sessionId];
        }
          [self.navigationController pushViewController:vc animated:YES];
    }
}

//右滑删除
- (void)onDeleteRecentAtIndexPath:(NIMRecentSession *)recent atIndexPaht:(NSIndexPath *)indexPath{
    id<NIMConversationManager> manager = [[NIMSDK sharedSDK] conversationManager];
    [manager deleteRecentSession:recent];
}

//置顶或者取消置顶
- (void)onTopRecenntAtIndexPath:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPaht isTop:(BOOL)isTop
{
    if (isTop) {
        //取消置顶
        [IMSessionUtil removeRecentSessionMark:recent.session type:IMRecentSessionMarkTypeTop];
    }
    else
    {
        [IMSessionUtil addRecentSessionMark:recent.session type:IMRecentSessionMarkTypeTop];
    }
    self.recentSessions = [self customSortRecents:self.recentSessions];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self refreshSubView];
}


- (NSMutableArray *)customSortRecents:(NSMutableArray *)recentSessions{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:recentSessions];
    
    [array sortedArrayUsingComparator:^NSComparisonResult(NIMRecentSession *obj1, NIMRecentSession *obj2) {
        NSInteger score1 = [IMSessionUtil recentSessionIsMark:obj1 type:IMRecentSessionMarkTypeTop] ? 10 : 0;
        NSInteger score2 = [IMSessionUtil recentSessionIsMark:obj2 type:IMRecentSessionMarkTypeTop] ? 10 : 0;
        if (obj1.lastMessage.timestamp > obj2.lastMessage.timestamp) {
            score1 += 1;
        }
        else if (obj1.lastMessage.timestamp < obj2.lastMessage.timestamp)
        {
            score2 += 1;
        }
        if (score1 == score2) {
            return NSOrderedSame;
        }
        return score1 > score2 ? NSOrderedAscending : NSOrderedDescending;
    }];
    return array;
}



#pragma mark - Private

- (void)refreshSubView{
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.navigationItem.titleView.width * .5f;
    if (@available(iOS 11.0,*)) {
        self.header.top = self.view.safeAreaInsets.top;
        self.tableView.top = self.header.bottom;
        CGFloat offset = self.view.safeAreaInsets.bottom;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, offset, 0);
    }
    else{
        self.tableView.top = self.header.height;
        self.header.bottom = self.tableView.top + self.tableView.contentInset.top;
    }
    self.tableView.height = self.view.height - self.tableView.top;
    self.emptyTipLabel.centerX = self.view.width * .5f;
    self.emptyTipLabel.centerY = self.tableView.height *.5f;
}

- (UIView *)titleView:(NSString *)userID{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = SessionListTitle;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [self.titleLabel sizeToFit];
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    subLabel.textColor = [UIColor grayColor];
    subLabel.font = [UIFont systemFontOfSize:12.f];
    subLabel.text = userID;
    subLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [subLabel sizeToFit];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.width = subLabel.width;
    titleView.height = self.titleLabel.height + subLabel.height;
    [titleView addSubview:self.titleLabel];
    [titleView addSubview:subLabel];
    return titleView;
}


@end
