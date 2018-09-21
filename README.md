QLTabScrollTableView
==============
QLTabScrollTableView is a lots(most four view or tableview) of view can scroll in Horizontal and vertical in  iOS components.

横竖屏多页面嵌套滑动组件 实现多个(最多四个tableview或view)并列排布 并且带左右滑动和上下滑动 选择效果



Demo Project
==============
See `QLTabScrollTableView/TabTableviewDemo.xcodeproj`

<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/1.png" width="320"><br/>
<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/2.png" width="320"> <br/>
<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/6.png" width="320">
<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/3.png" width="320"><br/>

Requirements
==============
This library requires `iOS 6.0+` and `Xcode 8.0+`.

Notice
==============




Code Example
==============

tabTableView = [[QLTabScrollTableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT) vcDelegate:self headScrollType:QLTabHeadNotScrollType];
tabTableView.delegate = self;
tabTableView.navHeight = navHei;
tabTableView.extraTopHei = 0.f;

NSMutableArray *viewArr = [[NSMutableArray alloc]initWithCapacity:3];
[viewArr addObject:view1];
[viewArr addObject:view2];
[viewArr addObject:view3];
[viewArr addObject:view4];

tabTableView.headView = topHeadView;
tabTableView.tabbarView = tabbarView;
tabTableView.tabViewArray = viewArr;
tabTableView.tabCount = 4;

tabTableView.backgroundColor = [UIColor clearColor];
[self.view addSubview:tabTableView];


