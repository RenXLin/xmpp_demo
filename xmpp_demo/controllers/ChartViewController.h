//
//  ChartViewController.h
//  xmpp_demo
//
//  Created by renxlin on 14-9-7.
//  Copyright (c) 2014年 任小林. All rights reserved.
//  聊天对话视图：

#import <UIKit/UIKit.h>
#import "ChartHelp.h"

@interface ChartViewController : UIViewController<UITextFieldDelegate,ChartMessageDelegate,UITableViewDataSource,UITableViewDelegate>


//聊天信息
@property(nonatomic,strong)UITableView *MessageTable;

//对方的name；
@property(nonatomic,strong)NSString *chartWithUser;

@end
