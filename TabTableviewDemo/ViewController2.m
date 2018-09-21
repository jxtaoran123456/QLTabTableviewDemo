//
//  ViewController.m
//  TabTableviewDemo
//
//  Created by ellentao(陶然) on 2017/4/14.
//  Copyright © 2017年 ellentao(陶然). All rights reserved.
//

#import "ViewController2.h"

#import "QLTabScrollTableView.h"
#import "QLBigClickButton.h"

#import "UIColor+Hex.h"
#import "UIImage+ImageEffects.h"

#import "Common.h"

#define navHei (44.f+(([[UIApplication sharedApplication] statusBarFrame].size.height<=0.f)?20.f:[[UIApplication sharedApplication] statusBarFrame].size.height))
#define HeadTopImgHei (SCREEN_HEIGHT >= 736.f?220.f*(SCREEN_HEIGHT/667.f):220.f)
#define tabbarHei 50.f

#define btnTag 178102

@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource,QLTabScrollTableViewSelect>
{
    UIView *navbarView;
    
    UIView *topHeadView;
    UIImageView *headImageView;
    UIImageView *blurHeadImageView;
    
    UIImageView *view1;
    UITableView *view2;
    UIImageView *view3;
    UITableView *view4;
    
    QLBigClickButton *btn1;
    QLBigClickButton *btn2;
    QLBigClickButton *btn3;
    QLBigClickButton *btn4;
    
    QLTabScrollTableView *tabTableView;
    
}


@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self loadData];
    
    //load UI
    [self loadTopImageView];
    [self loadArrView];
    [self loadTabTable];
    [self loadNavView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadData
{

}

- (void)loadNavView
{
    navbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navbarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navbarView];
    navbarView.alpha = 0.f;
    
    // 标题
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(navbarView.frame), 44)];
    titleView.text = @"tab scroll tableview";
    titleView.textColor = titleColor;
    titleView.textAlignment = NSTextAlignmentCenter;
    [navbarView addSubview:titleView];
    
}

- (void)loadArrView
{
    view1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 30.f)];
    view1.backgroundColor = [UIColor orangeColor];
    view1.image = [UIImage imageNamed:@"timg2.jpeg"];
    
    view2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    view2.dataSource = self;
    view2.delegate = self;
    view2.separatorColor = [UIColor colorWithHex:0x969696 alpha:0.2];
    view2.backgroundColor = [UIColor clearColor];
    
    view3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view3.backgroundColor = [UIColor clearColor];
    
    view4 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    view4.dataSource = self;
    view4.delegate = self;
    view4.separatorColor = [UIColor colorWithHex:0x969696 alpha:0.2];
    view4.backgroundColor = [UIColor clearColor];
    
}

- (void)loadTopImageView
{
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width,HeadTopImgHei)];
    headImageView.backgroundColor = [UIColor clearColor];
    headImageView.image = [UIImage imageNamed:@"back2.png"];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.clipsToBounds = YES;
    [self.view addSubview:headImageView];
    
    blurHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width,HeadTopImgHei)];
    blurHeadImageView.backgroundColor = [UIColor clearColor];
    blurHeadImageView.alpha = 0.f;
    blurHeadImageView.contentMode = UIViewContentModeScaleAspectFill;
    blurHeadImageView.clipsToBounds = YES;
    [self.view addSubview:blurHeadImageView];
    
    //blur effective
    blurHeadImageView.image = [[UIImage imageNamed:@"back2.png"] applyBlurWithRadius:10.8f tintColor:[UIColor clearColor] saturationDeltaFactor:1.f maskImage:nil];
    
}

- (void)loadTabTable
{
    topHeadView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width,HeadTopImgHei)];
    topHeadView.backgroundColor = [UIColor clearColor];
    topHeadView.userInteractionEnabled = YES;
    
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 60.f, CGRectGetWidth(topHeadView.frame), 44.f)];
    titleLb.text = @"tab scroll tableview";
    titleLb.textColor = titleColor;
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.backgroundColor = [UIColor clearColor];
    titleLb.font = [UIFont fontWithName:@"Courier-BoldOblique" size:20.f];
    [topHeadView addSubview:titleLb];
    
    tabTableView = [[QLTabScrollTableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT) vcDelegate:self headScrollType:QLTavHeadFollowScrollType];
    tabTableView.delegate = self;
    tabTableView.navHeight = navHei;
    tabTableView.extraTopHei = 0.f;

    UIView *tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tabbarHei)];
    tabbarView.backgroundColor = [UIColor clearColor];
    
    CGFloat btWid = SCREEN_WIDTH/4.f;
    btn1 = [[QLBigClickButton alloc]initWithFrame:CGRectMake(0, 0.f, btWid, tabbarHei)];
    [btn1 addTarget:self action:@selector(tabAction:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = btnTag;
    [btn1 setTitle:@"loc image" forState:UIControlStateNormal];
    btn1.backgroundColor = tabBtSelectColor;
    btn1.titleLabel.font = [UIFont fontWithName:@"Courier-BoldOblique" size:14.f];
    [tabbarView addSubview:btn1];
    
    btn2 = [[QLBigClickButton alloc]initWithFrame:CGRectMake(btWid, 0.f, btWid, tabbarHei)];
    [btn2 addTarget:self action:@selector(tabAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = btnTag+1;
    [btn2 setTitle:@"tableview1" forState:UIControlStateNormal];
    tabbarView.userInteractionEnabled = YES;
    btn2.backgroundColor = tabBtUnSelectColor;
    btn2.titleLabel.font = [UIFont fontWithName:@"Courier-BoldOblique" size:14.f];
    [tabbarView addSubview:btn2];
    
    btn3 = [[QLBigClickButton alloc]initWithFrame:CGRectMake(btWid*2.f, 0.f, btWid, tabbarHei)];
    [btn3 addTarget:self action:@selector(tabAction:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = btnTag+2;
    [btn3 setTitle:@"net image" forState:UIControlStateNormal];
    btn3.backgroundColor = tabBtUnSelectColor;
    btn3.titleLabel.font = [UIFont fontWithName:@"Courier-BoldOblique" size:14.f];
    [tabbarView addSubview:btn3];
    
    btn4 = [[QLBigClickButton alloc]initWithFrame:CGRectMake(btWid*3.f, 0.f, btWid, tabbarHei)];
    [btn4 addTarget:self action:@selector(tabAction:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = btnTag+3;
    [btn4 setTitle:@"tableview2" forState:UIControlStateNormal];
    btn4.backgroundColor = tabBtUnSelectColor;
    btn4.titleLabel.font = [UIFont fontWithName:@"Courier-BoldOblique" size:14.f];
    [tabbarView addSubview:btn4];
    
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
    
    [self loadImage];
    
    QLBigClickButton *backBt = [[QLBigClickButton alloc]initWithFrame:CGRectMake(10, 30.f, 30.f, 30.f)];
    [backBt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBt setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.view addSubview:backBt];
    
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tabAction:(id)sender
{
    UIButton *bt = ((UIButton *)sender);
    NSInteger index = bt.tag-btnTag;
    [tabTableView tabSelectIndex:index animated:YES];
    
    bt.backgroundColor = tabBtSelectColor;
    if(![bt isEqual:btn1])
    {
        btn1.backgroundColor = tabBtUnSelectColor;
    }
    if(![bt isEqual:btn2])
    {
        btn2.backgroundColor = tabBtUnSelectColor;
    }
    if(![bt isEqual:btn3])
    {
        btn3.backgroundColor = tabBtUnSelectColor;
    }
    if(![bt isEqual:btn4])
    {
        btn4.backgroundColor = tabBtUnSelectColor;
    }
    
}


#pragma mark QLTabScrollTableView delegate
- (void)scrollTabSelect:(QLTabScrollTableView *)scrollTableView index:(NSInteger)index ifScroll:(BOOL)ifScroll
{
    if(index == 0)
    {
        btn1.backgroundColor = tabBtSelectColor;
        btn2.backgroundColor = tabBtUnSelectColor;
        btn3.backgroundColor = tabBtUnSelectColor;
        btn4.backgroundColor = tabBtUnSelectColor;
    }
    else if (index == 1)
    {
        btn1.backgroundColor = tabBtUnSelectColor;
        btn2.backgroundColor = tabBtSelectColor;
        btn3.backgroundColor = tabBtUnSelectColor;
        btn4.backgroundColor = tabBtUnSelectColor;
    }
    else if (index == 2)
    {
        btn1.backgroundColor = tabBtUnSelectColor;
        btn2.backgroundColor = tabBtUnSelectColor;
        btn3.backgroundColor = tabBtSelectColor;
        btn4.backgroundColor = tabBtUnSelectColor;
    }
    else if (index == 3)
    {
        btn1.backgroundColor = tabBtUnSelectColor;
        btn2.backgroundColor = tabBtUnSelectColor;
        btn3.backgroundColor = tabBtUnSelectColor;
        btn4.backgroundColor = tabBtSelectColor;
    }
    
}


#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:[tabTableView subTableView:1]])
    {
        return 100;
    }
    else if([tableView isEqual:[tabTableView subTableView:3]])
    {
        return 30;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:[tabTableView subTableView:1]])
    {
        return 88.f;
    }
    else if([tableView isEqual:[tabTableView subTableView:3]])
    {
        return 66.f;
    }
    return 0.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:[tabTableView subTableView:1]])
    {
        NSString *identifier = @"tableview1Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"this is test tableview1  %d row",(int)indexPath.row];
        
        return cell;
    }
    else if([tableView isEqual:[tabTableView subTableView:3]])
    {
        NSString *identifier = @"tableview2Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"this is test tableview4 %drow",(int)indexPath.row];
        
        return cell;
    }
    return nil;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isEqual:[tabTableView subTableView:tabTableView.currentIndex]])
    {
        //effect 1 top nav show/hide
        CGFloat maxContentY = HeadTopImgHei - navHei;
        navbarView.alpha = scrollView.contentOffset.y/maxContentY;
        
        //effect 2 top blur image show/hide
        if(tabTableView.tabbarView.frame.origin.y < HeadTopImgHei)
        {
            CGFloat maxCulP = HeadTopImgHei + tabTableView.extraTopHei - tabTableView.navHeight;
            CGFloat maxPixH = 1.f;
            if(maxCulP > 0.f)
            {
                maxPixH = maxCulP;
            }
            CGFloat currentPixH = HeadTopImgHei - tabTableView.tabbarView.frame.origin.y;
            CGFloat newAlpha = currentPixH/maxPixH;
            newAlpha = [self blurImgViewAlphaCurve:newAlpha];
            
            blurHeadImageView.alpha = newAlpha;
            headImageView.alpha = 1.f - newAlpha;
        }
        else
        {
            blurHeadImageView.alpha = 0.f;
            headImageView.alpha = 1.f;
        }
        
        if(scrollView.contentOffset.y < 0.f)//拉大封面图片
        {
            CGFloat offsetPix = scrollView.contentOffset.y;
            headImageView.frame = CGRectMake(0.f+offsetPix*SCREEN_WIDTH/HeadTopImgHei/2.f, 0.f, SCREEN_WIDTH-offsetPix*SCREEN_WIDTH/HeadTopImgHei, HeadTopImgHei-offsetPix);
        }
        else
        {
            headImageView.frame = CGRectMake(0.f, 0.f, SCREEN_WIDTH,HeadTopImgHei);
        }
        
    }
    
}

//alpha logistic曲线 先快后慢上升 0.f～1.f
- (CGFloat)blurImgViewAlphaCurve:(CGFloat)x
{
    CGFloat y = 1.f/(1.f+exp(-1.f*x*5.f))-0.5f;
    y = 2.f*(1.f/(1.f +exp(-1.f*x*5.f))-0.5f);
    
    return y;
    
}


#pragma mark load image action
- (void)loadImage
{
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/jxtaoran123456/QLTabTableviewDemo/master/image/Snapshots/5.jpeg"];
    
    dispatch_queue_t queue = dispatch_queue_create("loadImage",NULL);
    dispatch_async(queue, ^{
        
        NSData *resultData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:resultData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(img != nil && img.size.width > 0.f)
            {
                //适配 adjust
                CGFloat newHei = img.size.height*(view3.frame.size.width/img.size.width);
                view3.frame = CGRectMake(view3.frame.origin.x, view3.frame.origin.y, view3.frame.size.width,newHei);
                view3.image = img;
                view3.contentMode = UIViewContentModeScaleAspectFill;
                [[NSNotificationCenter defaultCenter] postNotificationName:QLNeedRefreshTableReloadDataNotification object:view3];//刷新 tab table页卡高度
            }
        });
        
    });
    
}

- (void)testAction:(id)sender
{
    NSLog(@"test  action");
    
}

-(void)clickImage:(UITapGestureRecognizer *)gesture{
    NSLog(@"点击图片操作");
}



@end
