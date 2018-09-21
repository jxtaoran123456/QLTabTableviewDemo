QLTabScrollTableView
==============
QLTabScrollTableView is a lots(most four view or tableview) of view can scroll in Horizontal and vertical in  iOS components.

横竖屏多页面嵌套滑动组件 实现多个(最多四个tableview或view)并列排布 并且带左右滑动和上下滑动 选择效果



Demo Project
==============
See `QLTabScrollTableView/TabTableviewDemo.xcodeproj`

<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/1.png" width="320"><br/>
<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/2.png" width="320"> <br/>
<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/6.png" width="320"> <br/>
<img src="https://github.com/jxtaoran123456/QLTabTableviewDemo/blob/master/image/Snapshots/3.png" width="320"><br/>

Requirements
==============
This library requires `iOS 6.0+` and `Xcode 8.0+`.

Notice
==============
most four view or tableview in the  Horizontal

最多使用四个view并列


Code Example
==============

tabTableView = [[QLTabScrollTableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT) vcDelegate:self headScrollType:QLTabHeadNotScrollType];<br/>
tabTableView.delegate = self;<br/>
tabTableView.navHeight = navHei;<br/>
tabTableView.extraTopHei = 0.f;<br/>

NSMutableArray *viewArr = [[NSMutableArray alloc]initWithCapacity:3];<br/>
[viewArr addObject:view1];<br/>
[viewArr addObject:view2];<br/>
[viewArr addObject:view3];<br/>
[viewArr addObject:view4];<br/><br/><br/>

tabTableView.headView = topHeadView;<br/>
tabTableView.tabbarView = tabbarView;<br/>
tabTableView.tabViewArray = viewArr;<br/>
tabTableView.tabCount = 4;<br/><br/><br/>

tabTableView.backgroundColor = [UIColor clearColor];<br/>
[self.view addSubview:tabTableView];<br/>


