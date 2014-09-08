//
//  ChartViewController.m
//  xmpp_demo
//
//  Created by renxlin on 14-9-7.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "ChartViewController.h"

@interface ChartViewController ()

@end

@implementation ChartViewController
{
    NSMutableArray *_messages;
    UITextField *_message_TF;
    ChartHelp *_shareChart;
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
    _shareChart = [ChartHelp shareChart];
    _shareChart.messageDelegate = self;
    _messages = [[NSMutableArray alloc] init];
    
    _message_TF = [[UITextField alloc] init];
    _message_TF.frame = CGRectMake(10, 70, 200, 45);
    _message_TF.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    _message_TF.layer.cornerRadius = 10;
    _message_TF.placeholder = @"请输入发送内容";
    _message_TF.clearButtonMode = UITextFieldViewModeAlways;
    _message_TF.delegate = self;
    [self.view addSubview:_message_TF];
    
    UIButton *sentBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sentBtn.frame = CGRectMake(220, 70, 80, 45);
    [sentBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sentBtn.layer.cornerRadius = 10;
    sentBtn.tag = 1;
    [sentBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sentBtn];
    
    self.MessageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
    self.MessageTable.delegate = self;
    self.MessageTable.dataSource = self;
    [self.view addSubview:self.MessageTable];

}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_messages count];//[onlineUsers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"messageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[_messages objectAtIndex:indexPath.row] objectForKey:@"msg"];
    cell.detailTextLabel.text= [[_messages objectAtIndex:indexPath.row] objectForKey:@"sender"];
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

-(void)sendMessage
{
    NSLog(@"send message");
    //本地输入框中的信息
    NSString *message = _message_TF.text;
    if (message.length > 0) {
        //XMPPFramework主要是通过KissXML来生成XML文件
        //生成文档
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:message];
        //生成XML消息文档
        NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
        //消息类型
        [mes addAttributeWithName:@"type" stringValue:@"chat"];
        //发送给谁
        [mes addAttributeWithName:@"to" stringValue:_chartWithUser];
        //由谁发送
        [mes addAttributeWithName:@"from" stringValue:[[NSUserDefaults standardUserDefaults] stringForKey:USER]];
        //组合
        [mes addChild:body];
        
        //发送消息
        [_shareChart.xmppStream sendElement:mes];
        _message_TF.text = @"";
        [_message_TF resignFirstResponder];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:message forKey:@"msg"];
        [dictionary setObject:@"you" forKey:@"sender"];
        [_messages addObject:dictionary];
        //重新刷新tableView
        [self.MessageTable reloadData];
    }
}

//当前用户接受到用户的消息：
-(void)newMessageReceived:(NSDictionary *)messageContent
{
    [_messages addObject:messageContent];
    [self.MessageTable reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
