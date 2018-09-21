//
//  ACTabScrollTableView.m
//  横向 纵向滚动tab scroll tableview
//
//  Created by ellenato on 17-04-14.
//  Copyright (c) 2016年 ellentao. All rights reserved.
//

#import "ACTabScrollTableView3.h"
#import "ACBigClickButton.h"

#define TabBarBtnTag 12102
#define tableViewIndexTag 10212

@implementation ACIgnoreHeaderTouchTableView

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    if (self.tableHeaderView && CGRectContainsPoint(self.tableHeaderView.frame, point)) {
//        return NO;
//    }
//    return [super pointInside:point withEvent:event];
//}

@end

@interface ACTabScrollTableView3 ()
{
    UIScrollView *tabScrollView;//水平scroll
    UIView *tabBarView;
    
    UIView *subScrollView1;
    UIView *subScrollView2;
    UIView *subScrollView3;
    UIView *subScrollView4;
    
    UITableView *tableView1;
    UITableView *tableView2;
    UITableView *tableView3;
    UITableView *tableView4;
    
    CGFloat oriTabbarViewY;
    CGFloat oriHeadViewY;
    
    //写在业务需求里
//    CGFloat cellTotalHei;//所有cell的高度
//    NSMutableDictionary *heightKeyData;
//    NSInteger rowCount;
//    NSInteger sectionCount;
    
}

@end

@implementation ACTabScrollTableView3


- (instancetype)initWithFrame:(CGRect)frame vcDelegate:(UIViewController *)vcDelegate headScrollType:(ACTavHeadScrollType3)hsType
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.headScrollType = hsType;
        //heightKeyData = [[NSMutableDictionary alloc]initWithCapacity:10];
        
        tabScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, SCREEN_HEIGHT)];
        tabScrollView.backgroundColor = [UIColor clearColor];
        tabScrollView.pagingEnabled = YES;
        tabScrollView.bounces = NO;
        tabScrollView.delegate = self;
        tabScrollView.scrollsToTop = NO;
        tabScrollView.showsHorizontalScrollIndicator = NO;
        tabScrollView.showsVerticalScrollIndicator = NO;
        self.vcDelegate = vcDelegate;

        [self addSubview:tabScrollView];

        //ellentao 解决ios右滑返回时候与scrollview滑动冲突的问题
        if ([self.vcDelegate.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            [tabScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.vcDelegate.navigationController.interactivePopGestureRecognizer];
        }
        [self loadNotification];
        
    }
    return self;
    
}

- (void)loadNotification
{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableReloadData:) name:ACNeedRefreshTableReloadDataNotification object:nil];
    
}

- (void)refreshTableReloadData:(NSNotification*)notification
{
    //一定要在主线程执行 否则可能因为当前在子线程 刷不出数据甚至crash
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //object为需要刷新的子控件对象
            UITableView *freshTable = nil;
            if(notification.object != nil)
            {
                if([notification.object isEqual:subScrollView1])
                {
                    freshTable = tableView1;
                }
                else if([notification.object isEqual:subScrollView2])
                {
                    freshTable = tableView2;
                }
                else if([notification.object isEqual:subScrollView3])
                {
                    freshTable = tableView3;
                }
                else if([notification.object isEqual:subScrollView4])
                {
                    freshTable = tableView4;
                }
            }
            [self reloadTableData:freshTable];
            //[self reloadData:0];
        });
    });
    
}


- (void)setScrollsToTop:(BOOL)scrollsToTop
{
    
}

- (void)setTabTitleArray:(NSArray *)tabTitleArray
{
    _tabTitleArray = tabTitleArray;
    tabScrollView.contentSize = CGSizeMake(self.frame.size.width*tabTitleArray.count, 0.f);
    
    ACBigClickButton *view = [[ACBigClickButton alloc]initWithFrame:CGRectMake(0.f, _headView.frame.origin.y+_headView.frame.size.height, self.frame.size.width, 55.f)];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat titleLbWid = self.frame.size.width/self.tabTitleArray.count;
    
    if(self.tabTitleArray.count == 2)
    {
        //为2的时候  先按需求把样式写死
        ACBigClickButton *sectionTitleLb1 = [[ACBigClickButton alloc] initWithFrame:CGRectMake(0.f, 0.f,titleLbWid-77.f/2.f,55.f)];
        [sectionTitleLb1 setTitle:[self.tabTitleArray stringObjectAtIndex:0] forState:UIControlStateNormal];
        [sectionTitleLb1 setTitleColor:ACThemeColor forState:UIControlStateNormal];
        sectionTitleLb1.titleLabel.font = BoldACFontWithSize(17.f);
        sectionTitleLb1.tag = TabBarBtnTag+0;
        sectionTitleLb1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        sectionTitleLb1.backgroundColor = [UIColor clearColor];
        [sectionTitleLb1 addTarget:self action:@selector(tabSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:sectionTitleLb1];
        
        ACBigClickButton *sectionTitleLb2 = [[ACBigClickButton alloc] initWithFrame:CGRectMake(titleLbWid+77.f/2.f, 0.f,titleLbWid-77.f/2.f,55.f)];
        [sectionTitleLb2 setTitle:[self.tabTitleArray stringObjectAtIndex:1] forState:UIControlStateNormal];
        [sectionTitleLb2 setTitleColor:ACTextColor forState:UIControlStateNormal];
        sectionTitleLb2.titleLabel.font = BoldACFontWithSize(17.f);
        sectionTitleLb2.tag = TabBarBtnTag+1;
        sectionTitleLb2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        sectionTitleLb2.backgroundColor = [UIColor clearColor];
        [sectionTitleLb2 addTarget:self action:@selector(tabSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:sectionTitleLb2];
        
        UIImageView *selectLine = [[UIImageView alloc] initWithFrame:CGRectMake(titleLbWid-77.f/2.f-17.f-6.f,55.f-SIZE_H(7.f), SIZE_W(20.f), SIZE_H(7.f))];
        selectLine.backgroundColor = ACThemeColor;
        selectLine.layer.cornerRadius = SIZE_H(7) / 2.f;
        selectLine.layer.masksToBounds = YES;
        [view addSubview:selectLine];
    }
    else
    {
        for(int i = 0;i<self.tabTitleArray.count;i++)
        {
            ACBigClickButton *sectionTitleLb = [[ACBigClickButton alloc] initWithFrame:CGRectMake(i*titleLbWid, 0.f,titleLbWid,55.f)];
            [sectionTitleLb setTitle:[self.tabTitleArray stringObjectAtIndex:i] forState:UIControlStateNormal];
            [sectionTitleLb setTitleColor:i==0?ACThemeColor:ACTextColor forState:UIControlStateNormal];
            sectionTitleLb.titleLabel.font = BoldACFontWithSize(17.f);
            sectionTitleLb.tag = TabBarBtnTag+i;
            sectionTitleLb.backgroundColor = [UIColor clearColor];
            [sectionTitleLb addTarget:self action:@selector(tabSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:sectionTitleLb];
            
        }
        
        ACBigClickButton *btOne = (ACBigClickButton *)[view viewWithTag:TabBarBtnTag];
        UIImageView *selectLine = [[UIImageView alloc] initWithFrame:CGRectMake(btOne.frame.origin.x+(btOne.frame.size.width-SIZE_W(20.f))/2.f,55.f-SIZE_H(7.f), SIZE_W(20.f), SIZE_H(7.f))];
        selectLine.backgroundColor = ACThemeColor;
        selectLine.layer.cornerRadius = SIZE_H(7) / 2.f;
        selectLine.layer.masksToBounds = YES;
        [view addSubview:selectLine];
        
    }
    
    UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(0, 54.5f, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHex:0xc5c5c5];
    [view addSubview:lineView];
    
    _tabbarView = view;
    [self addSubview:view];
    
    self.tabCount = _tabTitleArray.count;
    
}

- (void)setTabCount:(NSInteger)tabCount
{
    _tabCount = tabCount;
    tabScrollView.contentSize = CGSizeMake(self.frame.size.width*tabCount, 0.f);
}

- (void)tabSelectAction:(id)sender
{
    if(self.tabCount <= 0)return;
    self.currentIndex = ((UIButton *)sender).tag - TabBarBtnTag;
    [self tabSelectIndex:self.currentIndex];

}

- (void)setTabbarCount:(NSInteger)tabbarCount
{
    self.tabCount = tabbarCount;
    
}

- (void)tabSelectIndex:(NSInteger)index
{
    if(self.tabCount <= 0)return;
    self.currentIndex = index;
    [tabScrollView setContentOffset:CGPointMake((tabScrollView.contentSize.width/self.tabCount)*self.currentIndex, tabScrollView.contentOffset.y) animated:YES];
    [self freshSelectViewWithAnimation:self.currentIndex];
    
    if([self.delegate respondsToSelector:@selector(scrollTabSelect:index:ifScroll:)])
    {
        [self.delegate scrollTabSelect:self index:self.currentIndex ifScroll:NO];
    }
    
}


//移动tabbar line和重制新的tableview的contentoffset 在这之前 已经保证了tableview有足够的contentsize
- (void)freshSelectViewWithAnimation:(NSInteger)index
{
    //在didiscroll中 也要做到顶处理 这里貌似可以屏蔽
//    UITableView *newTable = nil;
//    if(index == 0)
//    {
//        newTable = tableView1;
//    }
//    else if(index == 1)
//    {
//        newTable = tableView2;
//    }
//    else if(index == 2)
//    {
//        newTable = tableView3;
//    }
//    else if(index == 3)
//    {
//        newTable = tableView4;
//    }
//    if(newTable != nil)
//    {
//        newTable.contentOffset = CGPointMake(newTable.contentOffset.x, oriTabbarViewY - _tabbarView.frame.origin.y);
//    }
    
}

- (void)generateTableView:(UIView *)view index:(NSInteger)index
{
    UITableView *newtTabel = nil;
    if([view isKindOfClass:[UITableView class]])
    {
        if(index == 0)
        {
            tableView1 = (UITableView *)view;
            newtTabel = tableView1;
        }
        else if(index == 1)
        {
            tableView2 = (UITableView *)view;
            newtTabel = tableView2;
        }
        else if(index == 2)
        {
            tableView3 = (UITableView *)view;
            newtTabel = tableView3;
        }
        else if(index == 3)
        {
            tableView4 = (UITableView *)view;
            newtTabel = tableView4;
        }
    }
    else
    {
        newtTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, _navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - _navHeight) style:UITableViewStylePlain];
        newtTabel.dataSource = self;
        newtTabel.delegate = self;
        newtTabel.separatorColor = [UIColor clearColor];
        newtTabel.backgroundColor = [UIColor clearColor];
        newtTabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if(index == 0)
        {
            tableView1 = newtTabel;
        }
        else if(index == 1)
        {
            tableView2 = newtTabel;
        }
        else if(index == 2)
        {
            tableView3 = newtTabel;
        }
        else if(index == 3)
        {
            tableView4 = newtTabel;
        }

    }
//    newtTabel.frame = CGRectMake(SCREEN_WIDTH*index, 0, SCREEN_WIDTH, SCREEN_HEIGHT - _navHeight - _tabbarViewHei+self.extraTopHei);
    newtTabel.frame = CGRectMake(SCREEN_WIDTH*index, _tabbarViewHei-self.extraTopHei, SCREEN_WIDTH, SCREEN_HEIGHT - _navHeight - (_tabbarViewHei-self.extraTopHei));
    newtTabel.tag = tableViewIndexTag+index;
    
    newtTabel.showsHorizontalScrollIndicator = NO;
    newtTabel.showsVerticalScrollIndicator = NO;
    
    //不能这样设置 有像素偏移
//    if(_headView != nil)
//    {
//        newtTabel.tableHeaderView = _headView;
//    }
//    else
    {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, _headViewHei-_navHeight+self.extraTopHei)];
        headView.backgroundColor = [UIColor clearColor];
        newtTabel.tableHeaderView = headView;
    }

    newtTabel.dataSource = self;
    newtTabel.delegate = self;
    
    [tabScrollView addSubview:newtTabel];
    //[newtTabel reloadData];
    [self reloadTableData:newtTabel];

}

- (void)setTabViewArray:(NSArray *)tabViewArray
{
    _tabViewArray = tabViewArray;
    for(int i = 0;i<tabViewArray.count;i++)
    {
        UIView *view = (UIView *)[tabViewArray safeObjectAtIndex:i];
        
        if(i == 0)
        {
            subScrollView1 = (UIView *)view;
        }
        if(i == 1)
        {
            subScrollView2 = (UIView *)view;
        }
        if(i == 2)
        {
            subScrollView3 = (UIView *)view;
        }
        if(i == 3)
        {
            subScrollView4 = (UIView *)view;
        }
        [self generateTableView:view index:i];
        tabScrollView.contentSize = CGSizeMake(self.frame.size.width*_tabViewArray.count,0.f);
        
    }

}

- (void)setHeadViewHei:(CGFloat )headViewHei
{
    _headViewHei = headViewHei;
    
}

- (void)setHeadView:(UIView *)headView
{
    self.headViewHei = headView.frame.size.height;
    
    if(_headView != nil && ![_headView isEqual:headView])//有可能进行重用
    {
        [_headView removeFromSuperview];
    }
    _headView = headView;
    _headView.frame = CGRectMake(0.f, headView.frame.origin.y, SCREEN_WIDTH, headView.frame.size.height);
    
    [self addSubview:_headView];
    
    if(_tabbarView != nil)
    {
         _tabbarView.frame = CGRectMake(_tabbarView.frame.origin.x, _headView.frame.origin.y+_headView.frame.size.height, _tabbarView.frame.size.width, _tabbarView.frame.size.height);
        tabScrollView.frame = CGRectMake(tabScrollView.frame.origin.x, _tabbarView.frame.origin.y+_tabbarView.frame.size.height, tabScrollView.frame.size.width, self.frame.size.height- _tabbarView.frame.size.height-_navHeight>0.f?self.frame.size.height-_tabbarView.frame.size.height-_navHeight:0.f);
    }
    else
    {
        tabScrollView.frame = CGRectMake(_headView.frame.origin.x, _headView.frame.origin.y+_headView.frame.size.height, tabScrollView.frame.size.width, self.frame.size.height- _navHeight>0.f?self.frame.size.height-_navHeight:0.f);
    }
    
    self.headViewHei = _headView.frame.size.height;
    
    [self bringSubviewToFront:tabScrollView];
    
}

- (void)setNavHeight:(CGFloat)navHeight
{
    _navHeight = navHeight;
    tabScrollView.frame = CGRectMake(tabScrollView.frame.origin.x, navHeight, tabScrollView.frame.size.width, self.frame.size.height - navHeight);
    
}

- (void)setTabbarView:(UIView *)tabbarView
{
    self.tabbarViewHei = tabbarView.frame.size.height;
    if(_tabbarView != nil)
    {
        [_tabbarView removeFromSuperview];
    }
    _tabbarView = tabbarView;
    [self addSubview:_tabbarView];
    [self bringSubviewToFront:_tabbarView];
    if(_headView != nil)
    {
        _tabbarView.frame = CGRectMake(_tabbarView.frame.origin.x, _headView.frame.origin.y + _headView.frame.size.height, _tabbarView.frame.size.width, _tabbarView.frame.size.height);
//        tabScrollView.frame = CGRectMake(tabScrollView.frame.origin.x, self.tabbarViewHei + _navHeight - self.extraTopHei, tabScrollView.frame.size.width,self.frame.size.height - (self.tabbarViewHei + _navHeight - self.extraTopHei));
        tabScrollView.frame = CGRectMake(tabScrollView.frame.origin.x,_navHeight, tabScrollView.frame.size.width,self.frame.size.height - _navHeight);//self.tabbarViewHei + _navHeight - self.extraTopHei
    }
    
    oriTabbarViewY = _tabbarView.frame.origin.y;
    oriHeadViewY = _headView.frame.origin.y;
    
}

#pragma mark tableview delegate

- (BOOL)needThroughDelegate:(NSInteger)index
{
    UITableView *newtTabel = nil;
    UIView *subView = nil;
    if(index == 0)
    {
        newtTabel = tableView1;
        subView = subScrollView1;
    }
    else if(index == 1)
    {
        newtTabel = tableView2;
        subView = subScrollView2;
    }
    else if(index == 2)
    {
        newtTabel = tableView3;
        subView = subScrollView3;
    }
    else if(index == 3)
    {
        newtTabel = tableView4;
        subView = subScrollView4;
    }
    if([subView isKindOfClass:[UITableView class]])
    {
        return YES;
    }

    return NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sectionCount;
    if([_delegate respondsToSelector:@selector(numberOfSectionsInTableView:)] && [self needThroughDelegate:tableView.tag - tableViewIndexTag])
    {
        sectionCount = [_delegate numberOfSectionsInTableView:tableView];
    }
    else
    {
        sectionCount = 1;
    }
    return sectionCount;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount;
    if([_delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)] && [self needThroughDelegate:tableView.tag - tableViewIndexTag])
    {
        rowCount = [_delegate tableView:tableView numberOfRowsInSection:section];
    }
    else
    {
        rowCount = 1;
    }
    return rowCount;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHei = 0.f;
    
    if([_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)] && [self needThroughDelegate:tableView.tag - tableViewIndexTag])
    {
        rowHei = [_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else
    {
        rowHei = [self subViewFromTableView:tableView].frame.size.height;
    }
    
//    /*********************存储和计算高度 补高 防止出现缝隙 这里只认为section只有一个的情况 才会出现这种现象******************/
//    if(sectionCount <= 1 && rowCount <= 6)
//    {
//        NSString *key = [NSString stringWithFormat:@"%d_%d",(int)indexPath.section,(int)indexPath.row];
//        CGFloat oldHei = [heightKeyData floatValueForKey:key];
//        if(oldHei > 0.f)
//        {
//            cellTotalHei -= oldHei;
//        }
//        [heightKeyData setSafeObject:[NSNumber numberWithFloat:rowHei] forKey:key];
//        cellTotalHei += rowHei;
//        
//        //高度不够·的话 补充添加高度 前提是存储了所有高度
//        CGFloat minCellHei = tabScrollView.frame.size.height - _headViewHei - _tabbarViewHei;
//        if([heightKeyData count] == rowCount && cellTotalHei < minCellHei)
//        {
//            rowHei = rowHei + (minCellHei - cellTotalHei);
//        }
//        /*********************存储和计算高度 补高 防止出现缝隙 才会出现这种现象*******************/
//    }

    return rowHei;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell太矮的话 要设置占满下半屏幕 让tableview可以滑上去 tableview的contentsize只能在这个方法执行
    //解决上滑之后 左右滑动 回弹问题 主要是为了可以滑动 遮挡问题在height中处理
    if(tableView.contentSize.height < tableView.frame.size.height + _headViewHei + self.extraTopHei -_navHeight)
    {
        tableView.contentSize = CGSizeMake(tableView.contentSize.width, tableView.frame.size.height + _headViewHei + self.extraTopHei -_navHeight);
    }
    
    UITableViewCell *cell = nil;
    if([_delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)] && [self needThroughDelegate:tableView.tag - tableViewIndexTag])
    {
        cell = [_delegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        NSString *preStr = @"";
        if([tableView isEqual:tableView1])
        {
            preStr = @"table1";
        }
        else if([tableView isEqual:tableView2])
        {
            preStr = @"table2";
        }
        else if([tableView isEqual:tableView3])
        {
            preStr = @"table3";
        }
        else if([tableView isEqual:tableView4])
        {
            preStr = @"table4";
        }
        NSString *identifier = [NSString stringWithFormat:@"%@_tablecell",preStr];//千万不要以_currentIdex作为标识 否则会出现你来切换 多个cell产生的情况 因为产生了本可以负用但是不同的标识
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:[self subViewFromTableView:tableView]];
        }
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([_delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)] && [self needThroughDelegate:tableView.tag - tableViewIndexTag])
    {
        return [_delegate tableView:tableView heightForHeaderInSection:section];
    }
    else
    {
        return 0.f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if([_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)] && [self needThroughDelegate:tableView.tag - tableViewIndexTag])
    {
        return  [_delegate tableView:tableView viewForHeaderInSection:section];
    }
    else
    {
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)] && [self needThroughDelegate:tableView.tag - tableViewIndexTag])
    {
        return  [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        
    }
    
}


#pragma mark - uiscrollowview delegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if([_delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
    {
        [_delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
    {
        [_delegate scrollViewWillBeginDragging:scrollView];
    }
    
    if([scrollView isEqual:tabScrollView])
    {
        
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if([scrollView isEqual:tabScrollView])
    {
        NSInteger newIndex = scrollView.contentOffset.x/CGRectGetWidth(self.frame);
        if(self.currentIndex != newIndex)
        {
            [self freshSelectViewWithAnimation:newIndex];
        }
        self.currentIndex = newIndex;

        if([self.delegate respondsToSelector:@selector(scrollTabSelect:index:ifScroll:)])
        {
            [self.delegate scrollTabSelect:self index:self.currentIndex ifScroll:YES];
        }
    }
    
    if([_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
    {
        [_delegate scrollViewDidEndDecelerating:scrollView];
    }



}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if([_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
    {
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(![scrollView isEqual:tabScrollView])
    {
        CGFloat newY = oriTabbarViewY-scrollView.contentOffset.y;
        if(newY <=  _navHeight-self.extraTopHei)//顶部
        {
            newY = _navHeight-self.extraTopHei;
        }
        _tabbarView.frame = CGRectMake(0, newY, _tabbarView.frame.size.width, _tabbarView.frame.size.height);
        
        //这里默认headview的位置都是0像素点开始 有需要排版的 自己加参数调整
        if(scrollView.contentOffset.y < 0.f)
        {
            _headView.frame = CGRectMake(0, oriHeadViewY-1.f*scrollView.contentOffset.y, _headView.frame.size.width, _headView.frame.size.height);
        }
        else
        {
            _headView.frame = CGRectMake(0, oriHeadViewY, _headView.frame.size.width, _headView.frame.size.height);
        }
        
        if(scrollView.contentOffset.y <= 0.f)//底部
        {
            self.isInTopStatus = NO;
            self.isInBottomStatus = YES;
        }
        else if(_tabbarView.frame.origin.y <= _navHeight - self.extraTopHei)//顶部
        {
            self.isInTopStatus = YES;
            self.isInBottomStatus = NO;
        }
        else
        {
            self.isInTopStatus = NO;
            self.isInBottomStatus = NO;
        }
        
    }
    
    //其他子tableview同步滑动
    CGFloat maxContentY = oriTabbarViewY + self.extraTopHei - _navHeight;
    CGFloat newContentY = 0.f;
    if(self.isInTopStatus == YES)//顶部
    {
        newContentY = maxContentY;
    }
    else
    {
        newContentY = scrollView.contentOffset.y;
    }
    if(![tabScrollView isEqual:scrollView] && [scrollView isKindOfClass:[UITableView class]])
    {
        if(![tableView1 isEqual:scrollView] && tableView1.contentOffset.y != newContentY)
        {
            tableView1.contentOffset = CGPointMake(tableView1.contentOffset.x, newContentY);
        }
        if(![tableView2 isEqual:scrollView] && tableView2.contentOffset.y != newContentY)
        {
            tableView2.contentOffset = CGPointMake(tableView2.contentOffset.x, newContentY);
        }
        if(![tableView3 isEqual:scrollView] && tableView3.contentOffset.y != newContentY)
        {
            tableView3.contentOffset = CGPointMake(tableView3.contentOffset.x, newContentY);
        }
        if(![tableView4 isEqual:scrollView] && tableView4.contentOffset.y != newContentY)
        {
            tableView4.contentOffset = CGPointMake(tableView4.contentOffset.x, newContentY);
        }
    }
    
    if([_delegate respondsToSelector:@selector(scrollViewDidScroll:)])
    {
         [_delegate scrollViewDidScroll:scrollView];
    }
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if([_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
    {
         return [_delegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
    
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if([_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
    {
        return [_delegate scrollViewDidScrollToTop:scrollView];
    }
    
}


- (UIScrollView *)tabMainScrollView
{
    return tabScrollView;
    
}

- (UIView *)currentSubView:(NSInteger)index
{
    switch (index) {
        case 0:
            return subScrollView1;
        case 1:
            return subScrollView2;
        case 2:
            return subScrollView3;
        case 3:
            return subScrollView4;
        default:
            return subScrollView1;
    }
    
}

- (UITableView *)subTableView:(NSInteger)index
{
    switch (index) {
        case 0:
            return tableView1;
        case 1:
            return tableView2;
        case 2:
            return tableView3;
        case 3:
            return tableView4;
        default:
            return tableView1;
    }
    
}

- (UIView *)subViewFromTableView:(UITableView *)tableView
{
    int index = 0;
    if([tableView isEqual:tableView1])
    {
        index = 0;
    }
    else if([tableView isEqual:tableView2])
    {
        index = 1;
    }
    else if([tableView isEqual:tableView3])
    {
        index = 2;
    }
    else if([tableView isEqual:tableView4])
    {
        index = 3;
    }

    return [self currentSubView:index];
    
}

- (void)scrollToTopBarPos:(BOOL)animating
{
    UITableView *table = [self subTableView:self.currentIndex];
    [table setContentOffset:CGPointMake(table.contentOffset.x, self.headViewHei+self.tabbarViewHei-(self.tabbarViewHei-self.extraTopHei)-_navHeight) animated:animating];
    
}

- (void)reloadTableData:(UITableView *)table
{
    [table reloadData];
    
}

- (void)reloadData:(NSInteger)index
{
    [[self subTableView:index]reloadData];
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
