//
//  TripleDESUtils.h
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripleDESUtils : NSObject

- (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;


+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSData *)key iv:(NSData*)iv;
+ (NSData *)bDESEncrypt:(NSData *)data WithKey:(NSString *)key iv:(NSString*) iv;


+ (NSString*)encrypt:(NSString*)plainText withKey:(NSString*)key;
+ (NSString*)decrypt:(NSString*)encryptText withKey:(NSString*)key;
@end
