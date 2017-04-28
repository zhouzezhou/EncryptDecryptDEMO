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


@end
