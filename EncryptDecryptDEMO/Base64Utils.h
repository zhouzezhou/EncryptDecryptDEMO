//
//  Base64Utils.h
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Utils : NSObject

// 加密
+(NSString *)base64EncodeString:(NSString *)string;
+(NSString *)base64EncodeData:(NSData *)data;

// 解密
+(NSString *)base64DecodeString:(NSString *)string;
+(NSData *)base64DecodeStringToData:(NSString *)string;

@end
