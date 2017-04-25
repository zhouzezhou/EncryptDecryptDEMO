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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
