//
//  AESUtils.m
//  MerchantInfoInputFramework
//
//  Created by zhouzezhou on 2017/8/25.
//  Copyright © 2017年 Zzz. All rights reserved.
//

#import "AESUtils.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation AESUtils

/************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)AESEncryptDataByData:(NSData *)data andKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSData *)AESEncryptDataByString:(NSString *)data andKey:(NSString *)key
{
    // 先把字符串转换为二进制数据
    NSData *d = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self AESEncryptDataByData:d andKey:key];
}

+ (NSString *)AESEncryptStringByData:(NSData *)data andKey:(NSString *)key
{
    NSData *resultData = [self AESEncryptDataByData:data andKey:key];
    
    return [resultData base64EncodedStringWithOptions:0];
}

+ (NSString *)AESEncryptStringByString:(NSString *)data andKey:(NSString *)key
{
    NSData *resultData = [self AESEncryptDataByString:data andKey:key];
    
    return [resultData base64EncodedStringWithOptions:0];
}


// 解密
+ (NSString *)ZzzAESDecryptDataByString:(NSData *)data andKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        /// test
        
        NSString *result = [[NSString alloc] initWithData:[NSData
                                                           dataWithBytes:(const void *)buffer
                                                           length:(NSUInteger)numBytesEncrypted]
                                                 encoding:NSUTF8StringEncoding];
        //        DLog(@"result :%@", result);
        return result;
    }
    
    free(buffer);
    return nil;
}

+ (NSString *)ZzzAESDecryptStringByString:(NSString *)str andKey:(NSString *)key
{
    NSData *AESEncyptData = [[NSData alloc]initWithBase64EncodedString:str options:0];
    return [self ZzzAESDecryptDataByString:AESEncyptData andKey:key];
}



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
//+ (NSString *)AESDecryptHexStringByString:(NSString *)hexStr andKey:(NSString *)key
//{
////    const void * vplainText;
////    size_t plainTextBufferSize;
////    // 16进制转换成10进制 start
////    // ------------ new hex string handle fast
////    const char *chars = [hexStr UTF8String];
////    int i = 0;
////    unsigned long len = hexStr.length;
////
////    NSMutableData *EncryptData = [NSMutableData dataWithCapacity:len / 2];
////    char byteChars[3] = {'\0','\0','\0'};
////    unsigned long wholeByte;
////
////    while (i < len) {
////        byteChars[0] = chars[i++];
////        byteChars[1] = chars[i++];
////        wholeByte = strtoul(byteChars, NULL, 16);
////        [EncryptData appendBytes:&wholeByte length:1];
////    }
////
////    plainTextBufferSize = [EncryptData length];
////    vplainText = [EncryptData bytes];
////    // 16进制转换成10进制 end
//
//    char keyPtr[kCCKeySizeAES256+1];
//    bzero(keyPtr, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = [hexStr length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    size_t numBytesDecrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          keyPtr, kCCBlockSizeAES128,
//                                          NULL,
//                                          [[hexStr dataUsingEncoding:NSUTF8StringEncoding] bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesDecrypted);
//    if (cryptStatus == kCCSuccess) {
//        return [[NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted] base64EncodedStringWithOptions:0];
//    }
//    free(buffer);
//    return nil;
//}

@end
