//
//  Base64ViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "Base64ViewController.h"
#import "Base64Utils.h"

@interface Base64ViewController ()

@end

@implementation Base64ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Base64加解密";
    
    NSString *myText = @"zhouzezhou";

    NSString *encryptString = [Base64Utils base64EncodeString:myText];
    NSLog(@"encryptString : %@",encryptString);
    
    NSString *decryptString = [Base64Utils base64DecodeString:encryptString];
    NSLog(@"decryptString : %@",decryptString);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
