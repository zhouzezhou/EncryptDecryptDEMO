//
//  AESUtils.h
//  MerchantInfoInputFramework
//
//  Created by zhouzezhou on 2017/8/25.
//  Copyright © 2017年 Zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESUtils : NSObject

// AES加密模式：ECB 填充：pkcs7padding  数据块:128位 偏移量:无 字符集：utf-8

+ (NSData *)AESEncryptDataByData:(NSData *)data andKey:(NSString *)key;
+ (NSData *)AESEncryptDataByString:(NSString *)data andKey:(NSString *)key;

+ (NSString *)AESEncryptStringByData:(NSData *)data andKey:(NSString *)key;
+ (NSString *)AESEncryptStringByString:(NSString *)data andKey:(NSString *)key;

// 解密
+ (NSString *)ZzzAESDecryptDataByString:(NSData *)data andKey:(NSString *)key;

// ------------- 特殊用法 -------------

/**
 *  AES解密
 *  用于二维码解密（特殊用法),说明：
 *  将以16进制格式编码的字符串进行3DES解密后以UTF-8字符串输出
 *
 *  @param hexStr 待解密的16进制string,例如：1CB77A269D9C2DE70819A71998466FFB
 *  @param key     约定的密钥,例如：88888888
 *
 *  @return AES解密后的string,例如：2471905179304
 */
//+ (NSString *)AESDecryptHexStringByString:(NSString *)hexStr andKey:(NSString *)key;


@end
