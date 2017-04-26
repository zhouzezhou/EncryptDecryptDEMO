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
    
    NSString *myText = @"zhouzezhou is mine";
    NSString *encryptPassword = @"zhouzezhou";
    
//    TripleDESUtils *tripleDESUtils = [[TripleDESUtils alloc] init];
    
//    NSString *encryptString = [tripleDESUtils encryptUseDES:myText key:encryptPassword];
    NSString *encryptString = [TripleDESUtils encrypt:myText withKey:encryptPassword];
    NSLog(@"encryptString : \n%@\n", encryptString);
    
    NSString *decryString = [TripleDESUtils decrypt:encryptString withKey:encryptPassword];
    NSLog(@"decryString : \n%@\n", decryString);
    
    // Do any additional setup after loading the view.
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
