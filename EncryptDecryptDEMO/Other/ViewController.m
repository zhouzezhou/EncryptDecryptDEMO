//
//  ViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "ViewController.h"
#import "AESViewController.h"
#import "DESViewController.h"
#import "SHAViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置子视图的返回按钮Title
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"Home";
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AESBtnClick:(UIButton *)sender
{
    AESViewController *AESvc = [[AESViewController alloc] init];
    [self.navigationController pushViewController:AESvc animated:YES];
}

- (IBAction)DESBtnClick:(UIButton *)sender
{
    DESViewController *DESvc = [[DESViewController alloc] init];
    [self.navigationController pushViewController:DESvc animated:YES];
}

- (IBAction)SHABtnClick:(UIButton *)sender
{
    SHAViewController *SHAvc = [[SHAViewController alloc] init];
    [self.navigationController pushViewController:SHAvc animated:YES];
    
}


@end
