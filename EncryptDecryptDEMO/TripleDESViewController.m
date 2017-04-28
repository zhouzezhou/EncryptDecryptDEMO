//
//  TripleDESViewController.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "TripleDESViewController.h"
#import "TripleDESUtils.h"

@interface TripleDESViewController ()

@end

@implementation TripleDESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3DES加解密";
    
    NSString *plainText = @"zhouzezhou123";
    NSString *key = @"iRWQckmlKmxVdrjMJFfxrtWr";
    NSString *iv = @"01234567";
    
    NSString *encrypptString = [TripleDESUtils getEncryptWithString:plainText keyString: key ivString: iv];
    NSString *decryptString = [TripleDESUtils getDecryptWithString:encrypptString keyString: key ivString: iv];
    
    NSLog(@"3des加密:%@",encrypptString);
    NSLog(@"3des解密:%@",decryptString);
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
