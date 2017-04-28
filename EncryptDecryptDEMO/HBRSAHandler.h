//
//  HBRSAHandler.h
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 15/10/19.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    KeyTypePublic = 0,
    KeyTypePrivate
}KeyType;

@interface HBRSAHandler : NSObject

// 使用密钥文件导入密钥
- (BOOL)importKeyWithType:(KeyType)type andPath:(NSString*)path;
// 使用密钥字符串导入密钥
- (BOOL)importKeyWithType:(KeyType)type andkeyString:(NSString *)keyString;

//验证签名 Sha1 + RSA
- (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;
//验证签名 md5 + RSA
- (BOOL)verifyMD5String:(NSString *)string withSign:(NSString *)signString;

// RSA签名——SHA1
- (NSString *)signString:(NSString *)string;
// RSA签名——MD5
- (NSString *)signMD5String:(NSString *)string;

// RSA加密——公钥
- (NSString *) encryptWithPublicKey:(NSString*)content;
// RSA加密——私钥 Zzz新加
- (NSString *) encryptWithPrivateKey:(NSString*)content;

// RSA解密——私钥
- (NSString *) decryptWithPrivateKey:(NSString*)content;
// RSA解密——公钥 Zzz新加
- (NSString *) decryptWithPublicKey:(NSString*)content;

@end
