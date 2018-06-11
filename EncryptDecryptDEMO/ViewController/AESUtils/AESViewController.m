//
//  AESViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "AESViewController.h"

// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@interface AESViewController ()

@end

@implementation AESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AES加解密";
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 10, kScreenWidth - 20, kScreenHeight * 4 / 5)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    [displayLabel setText:@"zzz"];
//    [displayLabel setText:[NSString stringWithFormat:@"%@\nAES加解密:\n明文:%@\n密文:\n%@\n解密:%@", displayStr, plainText, enPrivateString, dePublicStringtemp]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
