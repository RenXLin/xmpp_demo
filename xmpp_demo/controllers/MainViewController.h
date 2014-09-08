//
//  MainViewController.h
//  xmpp_demo
//
//  Created by renxlin on 14-9-3.
//  Copyright (c) 2014年 任小林. All rights reserved.
//  好友列表：

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "ChartHelp.h"


@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ChartHelpDelegate>


@property (strong, nonatomic) UITableView *TableV;

@end
