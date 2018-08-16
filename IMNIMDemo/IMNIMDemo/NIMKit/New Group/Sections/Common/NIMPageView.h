//
//  NIMPageView.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/15.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NIMPageView;

@protocol NIMPageViewDataSource <NSObject>

- (NSInteger)numberOfPages:(NIMPageView *)pageView;
- (UIView *)pageView:(NIMPageView *)pageView viewInPage:(NSInteger)index;
@end


@protocol NIMPageViewDelegate <NSObject>
@optional
- (void)pageViewScrollEnd:(NIMPageView *)pageView
             currentIndex:(NSInteger)index
               totalPages:(NSInteger)pages;

- (void)pageViewDidScroll:(NIMPageView *)pageView;
- (BOOL)needScrollAnimation;

@end

@interface NIMPageView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) id<NIMPageViewDataSource> dataSource;
@property (nonatomic, weak) id<NIMPageViewDelegate> pageViewDelegate;
- (void)scrollToPage:(NSInteger)pages;
- (void)reloadData;
- (UIView *)viewAtIndex:(NSInteger)index;
- (NSInteger)currentPage;


//旋转相关方法，这两个方法必须配对调用，否则会有问题
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration;

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration;

@end
