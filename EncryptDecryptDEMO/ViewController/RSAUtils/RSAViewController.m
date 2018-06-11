//
//  ViewController.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 15/10/17.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "RSAViewController.h"
#import "HBRSAHandler.h"


// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface RSAViewController ()

@end

@implementation RSAViewController
{
    HBRSAHandler* _handler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString* private_key_string = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALG3J92DoFqE8wUe7mmDa9zHNit1wTPOXJEtJgBTTZX+TOk1aY/aT/K57HnGaWyEt9rjaxveLqcnd/y8D0oqLX5N7FQ1aiF3c67qilpzT4AWVcL81OXvR03+r+bve6MF970kgvfB0d9YBJ/MJ8sabnH1qy46cAxXv5kh3Vbfu0eRAgMBAAECgYEArp5j6nFqP2dBDrgM1NpQQrfvjxZ+RzQummt9WnZ/1rDvy3ozBikhw0NSi3kcn4dszAQHe3N97bqHWGtErr/wv/WIPj9PrJgIrgdJ6mdCQoYpeeA2pcDcp/mcNT6LiOpl2I9TAF5vhIcjRGH5h9bO4bjsmEIfNqMvW3tqmibt3T0CQQDgVbSu1t8jjs9r8xQT/AOdYnBK0Lfkb6LTfhwU9HKIme2Ts2iBzae27SyLkb7Eu6qO1FkmW2b5MQ7YeLC7w3uLAkEAyszehcziQf/XopfK/TqZxiBMG/jn02AKJDmLjaS7tO2w4ubhgCxHN+rkIXJYZFlbUEf5KzhOjTV5p3zy4HPc0wJBAKnGcw12tDy20aeCuQk+yoWLgCw+tUz+Z53jbOE29o8G31POjSLfPzQjXnjp/hPpavTZI/bxaYbhZ7jP7gDLum0CQBN6wDkL6AO85mKIwAe41EJyobziGKp2BCNcn6n4U8taNW5mDOz509FsL4OC7zicWKgKccWT//+STmAnIVEr798CQQDeW940PxBWJm+GqMb0BVhELvULu6Ai8nH1HW9tnm7IL7P67C4JQaRbPsOqZsQZcTXRCutuaDHmCEaZhEm9YR0X";
    
    NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCxtyfdg6BahPMFHu5pg2vcxzYrdcEzzlyRLSYAU02V/kzpNWmP2k/yuex5xmlshLfa42sb3i6nJ3f8vA9KKi1+TexUNWohd3Ou6opac0+AFlXC/NTl70dN/q/m73ujBfe9JIL3wdHfWASfzCfLGm5x9asuOnAMV7+ZId1W37tHkQIDAQAB";
    
    
    
    HBRSAHandler* handler = [HBRSAHandler new];
    [handler importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
    [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];
    _handler = handler;
    
    //需要签名的字符串
    NSString *plainText = @"abc123,./你好";
    NSString *displayStr = @"";
    
    // 签名 和 验证签名
    NSString *signMD5 = [handler signMD5String:plainText];
    BOOL isRightSignMD5 = [handler verifyMD5String:plainText withSign:signMD5];
    
    displayStr = [NSString stringWithFormat:@"RSA签名和验证签名:\n明文:%@\n签名结果:\n%@\n验证:%@\n----------\n", plainText, signMD5, isRightSignMD5?@"TRUE":@"FALSE"];
    
    // 加解密
    NSString* enPrivateString = [handler encryptWithPrivateKey_supportLongCN:plainText];
//    NSLog(@"\n\nenPrivateString:\n %@",enPrivateString);
    
    NSString* dePublicStringtemp = [handler decryptWithPublicKey:enPrivateString];
//    NSLog(@"\n\ndePublicString:\n%@",dePublicStringtemp);
    
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 10, kScreenWidth - 20, kScreenHeight * 4 / 5)];
    [displayLabel setBackgroundColor:[UIColor greenColor]];
    [displayLabel setNumberOfLines:0];
    [self.view addSubview:displayLabel];
    
    [displayLabel setText:[NSString stringWithFormat:@"%@\nRSA加解密:\n明文:%@\n密文:\n%@\n解密:%@", displayStr, plainText, enPrivateString, dePublicStringtemp]];
    
}

- (IBAction)clickButotn:(id)sender
{
    NSString *securityKey = @"4xz9ATkHgozzxhQXAvDfus0pybGtMUXRhugwHBUANlI=";
    NSString *result = [_handler decryptWithPublicKey:securityKey];
    NSLog(@"result :%@", result);    
}

@end
