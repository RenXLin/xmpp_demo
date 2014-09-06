//
//  MainViewController.m
//  xmpp_demo
//
//  Created by renxlin on 14-9-3.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    NSMutableArray *onlineUsers;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"user list";
    onlineUsers = [NSMutableArray array];

    
    UITextField *Message_tf = [[UITextField alloc] init];
    Message_tf.frame = CGRectMake(10, 70, 200, 45);
    Message_tf.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    Message_tf.layer.cornerRadius = 10;
    Message_tf.placeholder = @"请输入发送内容";
    Message_tf.clearButtonMode = UITextFieldViewModeAlways;
    Message_tf.delegate = self;
    [self.view addSubview:Message_tf];

    UIButton *sentBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sentBtn.frame = CGRectMake(220, 70, 80, 45);
    [sentBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sentBtn.layer.cornerRadius = 10;
    sentBtn.tag = 1;
    [sentBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sentBtn];
    
    self.TableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
    self.TableV.delegate = self;
    self.TableV.dataSource = self;
    [self.view addSubview:self.TableV];
    
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"账号" style:UIBarButtonItemStyleBordered target:self action:@selector(Login)];
    self.navigationItem.leftBarButtonItem = leftBBI;
    
}
-(void)sendMessage
{
    NSLog(@"send message");
}
-(void)Login
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
    return 5;//[onlineUsers count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"userCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"aa";
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
