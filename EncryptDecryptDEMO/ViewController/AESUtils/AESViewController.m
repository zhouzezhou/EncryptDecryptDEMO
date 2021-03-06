//
//  AESViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "AESViewController.h"
#import "AESUtils.h"

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
    
    // 待加密字符串
    NSString *oriTxt = @"abc123,./你好";
    NSString *key = @"12345678";
    
    NSString *AESEncyptStr = [AESUtils AESEncryptStringByString:oriTxt andKey:key];
//    NSData *AESEncyptData = [AESUtils AESEncryptDataByString:oriTxt andKey:key];
    
//    NSData *AESEncyptData = [[NSData alloc]initWithBase64EncodedString:AESEncyptStr options:0];
    
    NSString *AESDecryptStr = [AESUtils ZzzAESDecryptStringByString:AESEncyptStr andKey:key];
    
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 4, kScreenWidth - 20, kScreenHeight / 2)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    [displayLabel setText:[NSString stringWithFormat:@"AES加解密:\n明文:%@\n密钥:%@\n密文:\n%@\n----------\n解密:%@",
                           oriTxt,
                           key,
                           AESEncyptStr,
                           AESDecryptStr]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
