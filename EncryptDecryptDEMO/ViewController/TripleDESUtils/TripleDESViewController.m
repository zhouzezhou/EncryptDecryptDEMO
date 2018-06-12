//
//  TripleDESViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "TripleDESViewController.h"
#import "TripleDESUtils.h"
#import "Base64Utils.h"
#import <Foundation/NSScanner.h>

// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@interface TripleDESViewController ()

@end

@implementation TripleDESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3DES加解密";
    
    // 二维码16进制字符串加解密
    NSString *plainText = @"abc123,./你好";
    NSString *key       = @"ABCDEFGHIJKLMNOPQRSTUVWX";
    NSString *iv        = @"88888888";
    
    
    NSString *encryptString = [TripleDESUtils getEncryptWithString:plainText keyString: key ivString: iv];
    NSString *decryptString = [TripleDESUtils getDecryptWithString:encryptString keyString: key ivString: iv];
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 10, kScreenWidth - 20, kScreenHeight * 4 / 5)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    [displayLabel setText:[NSString stringWithFormat:@"3DES加解密:\n明文:%@\n密钥:%@\n偏移量iv:%@\n密文:\n%@\n解密:\n%@",
                           plainText,
                           key,
                           iv,
                           encryptString,
                           decryptString]];



    NSString *encryptString2HexString = [TripleDESUtils getHexEncryptWithString:plainText keyString: key ivString: iv];
    NSLog(@"3des加密后输出16进行的字符串:%@",encryptString2HexString);
    
    NSString *decryptHexString2String = [TripleDESUtils getDecryptWithHexString:encryptString2HexString keyString: key ivString: iv];
    NSLog(@"3des解密16进行的字符串为明文:%@",decryptHexString2String);
    
    
    [displayLabel setText:[NSString stringWithFormat:@"%@\n\n----- 特殊用法 ------\n输出16进制密文:\n%@\n16进制密文解密:\n%@",
                           displayLabel.text,
                           encryptString2HexString,
                           decryptHexString2String]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//普通字符串转换为十六进制的。
- (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

// 十六进制转换为普通字符串的。需要加入#import <Foundation/NSScanner.h>
- (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

- (NSData *)hexToBytes:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

@end
