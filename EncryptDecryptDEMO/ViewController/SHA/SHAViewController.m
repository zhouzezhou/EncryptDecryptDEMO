//
//  SHAViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2018/6/19.
//  Copyright © 2018 zhouzezhou. All rights reserved.
//

#import "SHAViewController.h"
#import "NSString+SHA.h"


// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@interface SHAViewController ()

@end

@implementation SHAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //需要签名的字符串
    NSString *plainText = @"abc123,./你好";
    
    // sha1
    NSString *sha1Str = plainText.sha1;
    
    // sha224
    NSString *sha224Str = plainText.sha224;
    
    // sha256
    NSString *sha256Str = plainText.sha256;
    
    // sha384
    NSString *sha384Str = plainText.sha384;
    
    // sha512
    NSString *sha512Str = plainText.sha512;
    
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 10, kScreenWidth - 20, kScreenHeight * 4 / 5)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    [displayLabel setText:[NSString stringWithFormat:@"SHA加解密\n明文:\n%@\nSHA1密文:\n%@\nsha224密文:\n%@\nsha256密文:\n%@\nsha384密文:\n%@\nsha512密文:\n%@\n",
                           plainText,
                           sha1Str,
                           sha224Str,
                           sha256Str,
                           sha384Str,
                           sha512Str]];
    
}


@end
