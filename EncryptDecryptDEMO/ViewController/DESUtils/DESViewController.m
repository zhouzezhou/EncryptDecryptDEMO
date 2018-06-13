//
//  DESViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "DESViewController.h"
#import "DESUtils.h"

// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface DESViewController ()

@end

@implementation DESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DES加解密";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 待加密字符串
    NSString *oriTxt = @"abc123,./你好";
    NSString *key = @"12345678";
    
    
    // 先把字符串转换为二进制数据
    NSData *d = [oriTxt dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData  = [DESUtils DESEncrypt:d WithKey:key];
    NSString *encryptStr = [encryptData base64EncodedStringWithOptions:0];
    
    NSData *desDecryptData = [DESUtils DESDecrypt:encryptData WithKey:key];
    NSString *desDecryptStr = [[NSString alloc] initWithData:desDecryptData encoding:NSUTF8StringEncoding];
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 4, kScreenWidth - 20, kScreenHeight / 2)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    [displayLabel setText:[NSString stringWithFormat:@"DES加解密:\n明文:%@\n密钥:%@\n密文:\n%@\n解密:%@",
                           oriTxt,
                           key,
                           encryptStr,
                           desDecryptStr]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
