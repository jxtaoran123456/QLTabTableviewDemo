//
//  QLTabScrollTableView.h
//  横向 纵向滚动tab scroll tableview
//
//

//先设置navHeight 然后headview 再设置tabbarView 最后tabViewArray

#import <UIKit/UIKit.h>
@class QLTabScrollTableView;
#define QLNeedRefreshTableReloadDataNotification @"QLNeedRefreshTableReloadDataNotification"



typedef NS_ENUM(NSUInteger, QLTavHeadScrollType) {
    QLTavHeadFollowScrollType = 1, //跟随scroll
    QLTabHeadNotScrollType = 2, //不跟随scroll
};

@protocol QLTabScrollTableViewSelect<NSObject>

@optional
- (void)scrollTabSelect:(QLTabScrollTableView *)scrollTableView index:(NSInteger)index ifScroll:(BOOL)ifScrooll;//滚动还是点击

@end

#import <UIKit/UIKit.h>


@interface QLTabScrollTableView : UIView<QLTabScrollTableViewSelect,UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,assign)QLTavHeadScrollType headScrollType;
@property(nonatomic,assign)NSInteger tabCount;
@property(nonatomic,strong)NSArray* tabTitleArray;
@property(nonatomic,strong)NSArray* tabViewArray;

@property(nonatomic,assign)CGFloat headViewHei;//不传的话 默认为headview的高度
@property(nonatomic,strong)UIView *headView;

@property(nonatomic,assign)CGFloat tabbarViewHei;
@property(nonatomic,strong)UIView *tabbarView;//可不传 使用默认样式

@property(nonatomic,weak)id<QLTabScrollTableViewSelect,UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate> delegate;
@property(nonatomic,weak)UIViewController *vcDelegate;

@property(nonatomic,assign)CGFloat navHeight;//往上滑动后 导航栏的高度

@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,assign)BOOL isInTopStatus;//是否撑 但是并不一定是tableview顶到顶部
@property(nonatomic,assign)BOOL isInBottomStatus;//是否在底部 最初使状态
@property(nonatomic,assign)CGFloat extraTopHei;//额外的继续往上推的像素 需求需要



- (instancetype)initWithFrame:(CGRect)frame vcDelegate:(UIViewController *)vcDelegate headScrollType:(QLTavHeadScrollType)hsType;
- (UIScrollView *)tabMainScrollView;//横向主scroll view
- (UITableView *)subTableView:(NSInteger)index;

- (void)tabSelectIndex:(NSInteger)index animated:(BOOL)animated;
- (void)scrollToTopBarPos:(BOOL)animating;//滚动到tabbar置顶的位置
- (void)reloadData:(NSInteger)index;

@end
