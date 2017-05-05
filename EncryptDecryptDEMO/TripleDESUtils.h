//
//  TripleDESUtils.h
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

// 3DES加密
#import <Foundation/Foundation.h>

@interface TripleDESUtils : NSObject

- (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;


+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSData *)key iv:(NSData*)iv;
+ (NSData *)bDESEncrypt:(NSData *)data WithKey:(NSString *)key iv:(NSString*) iv;


+ (NSString*)encrypt:(NSString*)plainText withKey:(NSString*)key;
+ (NSString*)decrypt:(NSString*)encryptText withKey:(NSString*)key;


/**
*  3des加密
*
*  @param encryptString 待加密的string
*  @param keyString     约定的密钥
*  @param ivString      约定的密钥
*
*  @return 3des加密后的string
*/
+ (NSString*)getEncryptWithString:(NSString*)encryptString keyString:(NSString*)keyString ivString:(NSString*)ivString;

/**
 *  3des解密
 *
 *  @param decryptString 待解密的string
 *  @param keyString     约定的密钥
 *  @param ivString      约定的密钥
 *
 *  @return 3des解密后的string
 */
+ (NSString*)getDecryptWithString:(NSString*)decryptString keyString:(NSString*)keyString ivString:(NSString*)ivString;


// 二维码3DES加解密（特殊用法，输入输出16进制字符串）
/**
 *  3des加密
 *  用于二维码加密（特殊用法),说明：
 *  将明文进行3DES加密后以16进制字符串输出
 *
 *  @param encryptString 待加密的string,例如：2471905179304
 *  @param keyString     约定的密钥,例如：ABCDEFGHIJKLMNOPQRSTUVWX(在算法里会对此key进行一次Base64)
 *  @param ivString      约定的密钥,例如：88888888
 *
 *  @return 3des加密后的16进制string（大写）,例如：1CB77A269D9C2DE70819A71998466FFB
 */
+ (NSString*)getHexEncryptWithString:(NSString*)encryptString keyString:(NSString*)keyString ivString:(NSString*)ivString;

/**
 *  3des解密
 *  用于二维码解密（特殊用法),说明：
 *  将以16进制格式编码的字符串进行3DES解密后以UTF-8字符串输出
 *
 *  @param decryptString 待解密的16进制string,例如：1CB77A269D9C2DE70819A71998466FFB
 *  @param keyString     约定的密钥,例如：ABCDEFGHIJKLMNOPQRSTUVWX(在算法里会对此key进行一次Base64)
 *  @param ivString      约定的密钥,例如：88888888
 *
 *  @return 3des解密后的string,例如：2471905179304
 */
+ (NSString*)getDecryptWithHexString:(NSString*)decryptString keyString:(NSString*)keyString ivString:(NSString*)ivString;


@end
