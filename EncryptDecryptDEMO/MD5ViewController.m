//
//  MD5ViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "MD5ViewController.h"
#import "NSString+MD5.h"

// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface MD5ViewController ()

@end

@implementation MD5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MD5加密";
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 4, kScreenWidth - 20, kScreenHeight / 2)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    // md5 加密
    NSString *oriTxt = @"abc123,./";
    
    NSString *encryptTxt = [oriTxt md5Digest];
    
    
    
    [displayLabel setText:[NSString stringWithFormat:@"md5加密:\n明文:abc123,./\n密文:%@", encryptTxt]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
