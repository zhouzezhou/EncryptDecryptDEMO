//
//  Base64ViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "Base64ViewController.h"
#import "Base64Utils.h"

// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface Base64ViewController ()

@end

@implementation Base64ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Base64加解密";
    
    NSString *myText = @"abc123,./你好";

    NSString *encryptString = [Base64Utils base64EncodeString:myText];
//    NSLog(@"encryptString : %@",encryptString);
    
    NSString *decryptString = [Base64Utils base64DecodeString:encryptString];
//    NSLog(@"decryptString : %@",decryptString);
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 4, kScreenWidth - 20, kScreenHeight / 2)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    [displayLabel setText:[NSString stringWithFormat:@"Base64加解密:\n明文:%@\n密文:%@\n----------\n解密:%@", myText, encryptString, decryptString]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
