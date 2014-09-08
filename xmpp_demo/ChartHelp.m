//
//  ChartHelp.m
//  xmpp_demo
//
//  Created by renxlin on 14-9-7.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "ChartHelp.h"

static ChartHelp *_chart;

@implementation ChartHelp
{
    
    NSString *_passWord;
    BOOL _isOpen;
}

+(id)shareChart
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _chart = [[ChartHelp alloc] init];
    });
    return _chart;
}

-(void)setupStream{
    //初始化XMPPStream
    _xmppStream = [[XMPPStream alloc] init];

    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

-(void)goOnline{
    //发送在线状态
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

-(void)goOffline{
    //发送下线状态
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:presence];
}

-(BOOL)connect{
    
    [self setupStream];
    
    //从本地取得用户名，密码和服务器地址
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults stringForKey:USER];
    NSString *pass = [defaults stringForKey:PASSWORD];
    NSString *server = [defaults stringForKey:SERVER];
    if (![_xmppStream isDisconnected]) {
        return YES;
    }
    if (userId == nil || pass == nil) {
        return NO;
    }
    //设置用户
    [_xmppStream setMyJID:[XMPPJID jidWithString:userId]];
    //设置服务器
    [_xmppStream setHostName:server];
    //密码
    _passWord = pass;
    //连接服务器
    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:1 error:&error]) {
        NSLog(@"cant connect %@", server);
        return NO;
    }
    return YES;
}
-(void)disconnect{
    [self goOffline];
    [_xmppStream disconnect];
}

//这几个是基础方法，接下来就是XMPPStreamDelegate中的方法，也是接受好友状态，接受消息的重要方法
//连接服务器
-(void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    NSLog(@" time connect");
}
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"服务器链接正常");
    _isOpen = YES;
    NSError *error = nil;
    //验证密码
    [_xmppStream authenticateWithPassword:_passWord error:&error];
}

//验证通过
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"密码验证通过");
    [self goOnline];
}

//收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    // NSLog(@"message = %@", message);
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:msg forKey:@"msg"];
    [dict setObject:from forKey:@"sender"];
    //消息委托(这个后面讲)
    [_messageDelegate newMessageReceived:dict];
}

//收到好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    // NSLog(@"presence = %@", presence);
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    //当前用户
    NSString *userId = [[sender myJID] user];
    //在线用户
    NSString *presenceFromUser = [[presence from] user];
    if (![presenceFromUser isEqualToString:userId]) {
        //在线状态
        if ([presenceType isEqualToString:@"available"]) {
            //用户列表委托(后面讲)
            [_chartDelegate newFriendOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"renxlindemac-pro"]];
        }else if ([presenceType isEqualToString:@"unavailable"]) {
            //用户列表委托(后面讲)
            [_chartDelegate friendWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"renxlindemac-pro"]];
        }
    }
}



@end
