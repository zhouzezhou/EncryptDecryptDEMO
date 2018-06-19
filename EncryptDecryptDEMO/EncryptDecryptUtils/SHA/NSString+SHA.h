//
//  NSString+SHA.h
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2018/6/19.
//  Copyright © 2018 zhouzezhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(SHA)

-(NSString *) sha1;
-(NSString *) sha224;
-(NSString *) sha256;
-(NSString *) sha384;
-(NSString *) sha512;

@end

NS_ASSUME_NONNULL_END
