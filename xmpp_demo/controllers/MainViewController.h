//
//  MainViewController.h
//  xmpp_demo
//
//  Created by renxlin on 14-9-3.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UITableView *TableV;

@end
