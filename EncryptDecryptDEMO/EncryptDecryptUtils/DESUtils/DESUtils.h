//
//  DESUtils.h
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESUtils : NSObject

/************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 加密参数 : 加密模式ECB、填充pksc7padding、偏移量无、字符集utf-8
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;

// 加密输入输出String
+ (NSString *)DESEncryptByString:(NSString *)str WithKey:(NSString *)key;

/************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 解密参数 : 加密模式ECB、填充pksc7padding、偏移量无、字符集utf-8
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

// 解密输入输出String
+ (NSString *)DESDecryptByString:(NSString *)str WithKey:(NSString *)key;

/************************************************************
 函数名称 : + (NSData *)DESEncryptNoPadding:(NSData *)data WithKey:(NSData *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSData *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)DESEncryptNoPadding:(NSData *)data WithKey:(NSData *)key;

/************************************************************
 函数名称 : + (NSData *)DESDecryptNoPadding:(NSData *)data WithKey:(NSData *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSData *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)DESDecryptNoPadding:(NSData *)data WithKey:(NSData *)key;

@end
