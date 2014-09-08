//
//  MainViewController.m
//  xmpp_demo
//
//  Created by renxlin on 14-9-3.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "MainViewController.h"
#import "ChartViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController
{
    NSMutableArray *_onlineUsers;
    UITextField *_message_TF;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ChartHelp *shareChart = [ChartHelp shareChart];
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:USER];
    if (login) {
        if ([shareChart connect]) {
            NSLog(@"显示用户列表 !");
        }else{
            UIAlertView *aleart = [[UIAlertView alloc] initWithTitle:@"ERROR ?" message:@"登录失败！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aleart show];
        }
    }else {
        //设定用户
        UIAlertView *aleart = [[UIAlertView alloc] initWithTitle:@"NOTICE?" message:@"请先登录！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aleart show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"user list";
    _onlineUsers = [NSMutableArray array];
    ChartHelp *shareChart = [ChartHelp shareChart];
    shareChart.chartDelegate = self;
    
//    _message_TF = [[UITextField alloc] init];
//    _message_TF.frame = CGRectMake(10, 70, 200, 45);
//    _message_TF.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
//    _message_TF.layer.cornerRadius = 10;
//    _message_TF.placeholder = @"请输入发送内容";
//    _message_TF.clearButtonMode = UITextFieldViewModeAlways;
//    _message_TF.delegate = self;
//    [self.view addSubview:_message_TF];
//
//    UIButton *sentBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    sentBtn.frame = CGRectMake(220, 70, 80, 45);
//    [sentBtn setTitle:@"发送" forState:UIControlStateNormal];
//    [sentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    sentBtn.layer.cornerRadius = 10;
//    sentBtn.tag = 1;
//    [sentBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:sentBtn];
    
    self.TableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
    self.TableV.delegate = self;
    self.TableV.dataSource = self;
    [self.view addSubview:self.TableV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.TableV.frame.size.width, 44)];
    label.text = @"用户列表";
    label.textAlignment = NSTextAlignmentCenter;
    self.TableV.tableHeaderView = label;
    
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"账号" style:UIBarButtonItemStyleBordered target:self action:@selector(goAccountVC)];
    self.navigationItem.leftBarButtonItem = leftBBI;
    
}

-(void)sendMessage
{
    NSLog(@"send message");
    
}
    
-(void)goAccountVC
{
    NSLog(@"login");
    
    LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_onlineUsers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"FriendListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"friendName";
    cell.detailTextLabel.text = @"xmpp - id";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChartViewController *cvc = [[ChartViewController alloc] init];
    
    cvc.chartWithUser = [_onlineUsers objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:cvc animated:YES];
}





#pragma mark chartHelp Delegate methods:
//新好友上线
-(void)newFriendOnline:(NSString *)friendName
{
    if (![_onlineUsers containsObject:friendName]) {
        [_onlineUsers addObject:friendName];
        [self.TableV reloadData];
    }
}

//好友下线
-(void)friendWentOffline:(NSString *)friendName
{
    if ([_onlineUsers containsObject:friendName]) {
        [_onlineUsers removeObject:friendName];
        [self.TableV reloadData];
    }
}

//链接断开：
-(void)didDisconnect
{


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
