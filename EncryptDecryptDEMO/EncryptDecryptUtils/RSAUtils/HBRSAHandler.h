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

+ (instancetype)sharedInstance;

-(void) initRSASign;

// 使用密钥文件导入密钥
- (BOOL)importKeyWithType:(KeyType)type andPath:(NSString*)path;
// 使用密钥字符串导入密钥
- (BOOL)importKeyWithType:(KeyType)type andkeyString:(NSString *)keyString;

// 验证签名 Sha1 + RSA
- (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;
// 验证签名 md5 + RSA
- (BOOL)verifyMD5String:(NSString *)string withSign:(NSString *)signString;

// RSA签名——SHA1
- (NSString *)signString:(NSString *)string;
// RSA签名——MD5
- (NSString *)signMD5String:(NSString *)string;

// RSA加密——公钥
- (NSString *) encryptWithPublicKey:(NSString*)content;
// RSA加密——公钥 Zzz新加20171222，加入中文支持，可以加密包含中文的字符串
- (NSString *) encryptWithPublicKey_supportCN:(NSString*)content;
// RSA加密——私钥 Zzz新加
- (NSString *) encryptWithPrivateKey:(NSString*)content;
// RSA加密——私钥 Zzz新加20171222，加入中文支持，可以加密包含中文的字符串
- (NSString *) encryptWithPrivateKey_supportCN:(NSString*)content;

// RSA解密——私钥
- (NSString *) decryptWithPrivateKey:(NSString*)content;
// RSA解密——公钥 Zzz新加
- (NSString *) decryptWithPublicKey:(NSString*)content;

////////////////////////////////////////////////////////////
// 当待加密的字符串长度大于117时（PKCS1Padding）超出RSA直接加密的最大明文长度，
// 使用分段加密，将明文按最大长度进行裁剪后依次加密，之后将密文合并进行Base64编码后输出
// 使用RSA加密大长度的内容将消耗较多时间，较为合理的方法为使用RSA加密对称加密算法里的密钥，
// 然后使用对称加密算法加密大长度明文
// 周泽舟，20171222，zhouzezhou.com

// RSA加密——私钥 Zzz新加20171222，加入中文支持和大长度明文(分段加密,解密需要配合分段解密算法)
- (NSString *) encryptWithPrivateKey_supportLongCN:(NSString*)content;

@end

