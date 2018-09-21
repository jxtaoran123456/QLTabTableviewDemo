
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"

#import "QLTabScrollTableView.h"
#import "QLBigClickButton.h"

#import "UIColor+Hex.h"
#import "UIImage+ImageEffects.h"

#import "Common.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,QLTabScrollTableViewSelect>
{
    UITableView *mainTableView;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadUI
{
    self.navigationController.navigationBar.hidden = NO;
    
    mainTableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.separatorColor = [UIColor colorWithHex:0x969696 alpha:1.0];
    mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainTableView];
    
}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"tableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if(indexPath.row < 2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"tab scroll tableview style %d",(int)indexPath.row+1];
    }
    else
    {
        cell.textLabel.text = nil;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
        ViewController1 *vc = [[ViewController1 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if(indexPath.row == 1)
    {
        ViewController2 *vc = [[ViewController2 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}






@end
