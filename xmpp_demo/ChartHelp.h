//
//  ChartHelp.h
//  xmpp_demo
//
//  Created by renxlin on 14-9-7.
//  Copyright (c) 2014年 任小林. All rights reserved.
//  聊天功能实现单例：

#import <Foundation/Foundation.h>
#import "XMPP.h"

@protocol ChartHelpDelegate <NSObject>

-(void)newFriendOnline:(NSString *)friendName;

-(void)friendWentOffline:(NSString *)friendName;

-(void)didDisconnect;

@end


@protocol ChartMessageDelegate <NSObject>

-(void)newMessageReceived:(NSDictionary *)messageContent;

@end


@interface ChartHelp : NSObject<XMPPStreamDelegate>

@property(nonatomic,strong)XMPPStream *xmppStream;



@property(nonatomic,weak)__weak id<ChartHelpDelegate>chartDelegate;
@property(nonatomic,weak)__weak id<ChartMessageDelegate>messageDelegate;


+(id)shareChart;

-(BOOL)connect;
-(void)disconnect;

-(void)setupStream;
-(void)goOnline;
-(void)goOffline;




@end




