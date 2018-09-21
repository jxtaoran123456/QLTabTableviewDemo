//
//  ACTabScrollTableView.h
//  横向 纵向滚动tab scroll tableview
//
//  Created by ellenato on 17-04-14.
//  Copyright (c) 2016年 ellentao. All rights reserved.
//

//先设置navHeight 然后headview 再设置tabbarView 最后tabViewArray

#import <UIKit/UIKit.h>
@class ACTabScrollTableView3;
#define ACNeedRefreshTableReloadDataNotification @"ACNeedRefreshTableReloadDataNotification"

typedef NS_ENUM(NSUInteger, ACTavHeadScrollType3) {
    ACTavHeadFollowScrollType3 = 1, //跟随scroll
    ACTabHeadNotScrollType3 = 2, //不跟随scroll
};

@protocol ACTabScrollTableViewSelect3<NSObject>

@optional
- (void)scrollTabSelect:(ACTabScrollTableView3 *)scrollTableView index:(NSInteger)index ifScroll:(BOOL)ifScrooll;//滚动还是点击

@end

#import <UIKit/UIKit.h>

/**
 *  忽略tableHeaderView点击事件，使他可以往底层传递。
 */
@interface ACIgnoreHeaderTouchTableView : UITableView

@end



@interface ACTabScrollTableView3 : UIView<ACTabScrollTableViewSelect3,UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,weak)id<ACTabScrollTableViewSelect3,UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate> delegate;
@property(nonatomic,assign)ACTavHeadScrollType3 headScrollType;
@property(nonatomic,assign)CGFloat navHeight;//往上滑动后 导航栏的高度
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *tabbarView;
@property(nonatomic,strong)NSArray* tabViewArray;


//data
@property(nonatomic,assign)NSInteger tabCount;
@property(nonatomic,assign)CGFloat headViewHei;//不传的话 默认为headview的高度
@property(nonatomic,assign)CGFloat tabbarViewHei;
@property(nonatomic,strong)NSArray* tabTitleArray;
@property(nonatomic,weak)UIViewController *vcDelegate;//主要用于左右退出手势滑动
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)CGFloat extraTopHei;//额外的继续往上推的像素 需求需要

//status
@property(nonatomic,assign)BOOL isInTopStatus;//是否撑 但是并不一定是tableview顶到顶部
@property(nonatomic,assign)BOOL isInBottomStatus;//是否在底部 最初使状态



//常用函数
- (instancetype)initWithFrame:(CGRect)frame vcDelegate:(UIViewController *)vcDelegate headScrollType:(ACTavHeadScrollType3)hsType;
- (void)tabSelectIndex:(NSInteger)index;


//需求函数
- (UIScrollView *)tabMainScrollView;//横向主scroll view
- (UITableView *)subTableView:(NSInteger)index;

- (void)scrollToTopBarPos:(BOOL)animating;//滚动到tabbar置顶的位置
- (void)reloadData:(NSInteger)index;

@end
