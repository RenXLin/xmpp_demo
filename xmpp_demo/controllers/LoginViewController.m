//
//  LoginViewController.m
//  xmpp_demo
//
//  Created by renxlin on 14-9-3.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *rigthBBI = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(Login)];
    self.navigationItem.rightBarButtonItem = rigthBBI;

}


-(BOOL)validateWithUser:(NSString *)userText andPass:(NSString *)passText andServer:(NSString *)serverText{
    if (userText.length > 0 && passText.length > 0 && serverText.length > 0) {
        return YES;
    }
    return NO;
}
-(void)Login
{
    NSLog(@"login");
    if ([self validateWithUser:self.userTextField.text andPass:_passWordTextField.text andServer:_serverTextField.text]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.userTextField.text forKey:USER];
        [defaults setObject:self.passWordTextField.text forKey:PASSWORD];
        [defaults setObject:self.serverTextField.text forKey:SERVER];
        //保存
        [defaults synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名，密码和服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
