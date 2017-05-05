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

@interface TripleDESViewController ()

@end

@implementation TripleDESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3DES加解密";
    
    // 普通字符串加解密
//    NSString *plainText = @"zhouzezhou123";
//    NSString *key = @"iRWQckmlKmxVdrjMJFfxrtWr";
//    NSString *iv = @"01234567";
//    
//    NSString *encrypptString = [TripleDESUtils getEncryptWithString:plainText keyString: key ivString: iv];
//    NSString *decryptString = [TripleDESUtils getDecryptWithString:encrypptString keyString: key ivString: iv];
//    
//    NSLog(@"3des加密:%@",encrypptString);
//    NSLog(@"3des解密:%@",decryptString);

    // 二维码16进制字符串加解密
//    NSString *plainText = @"1CB77A269D9C2DE70819A71998466FFB";
    NSString *plainText = @"2471905179304";
    NSString *key       = @"ABCDEFGHIJKLMNOPQRSTUVWX";
    NSString *iv        = @"88888888";
    
    NSString *encryptString2HexString = [TripleDESUtils getHexEncryptWithString:plainText keyString: key ivString: iv];
    NSLog(@"3des加密后输出16进行的字符串:%@",encryptString2HexString);
    
    NSString *decryptHexString2String = [TripleDESUtils getDecryptWithHexString:encryptString2HexString keyString: key ivString: iv];
    NSLog(@"3des解密16进行的字符串为明文:%@",decryptHexString2String);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
