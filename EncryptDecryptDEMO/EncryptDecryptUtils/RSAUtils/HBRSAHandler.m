//
//  HBRSAHandler.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 15/10/19.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//
#import "HBRSAHandler.h"
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/err.h>
#include <openssl/md5.h>

typedef enum {
    RSA_PADDING_TYPE_NONE       = RSA_NO_PADDING,
    RSA_PADDING_TYPE_PKCS1      = RSA_PKCS1_PADDING,
    RSA_PADDING_TYPE_SSLV23     = RSA_SSLV23_PADDING
}RSA_PADDING_TYPE;

#define  PADDING   RSA_PADDING_TYPE_PKCS1     // 原Padding Type
//#define  PADDING   RSA_PADDING_TYPE_NONE     // 行天下，测试Padding Type

@implementation HBRSAHandler
{
    RSA* _rsa_pub;
    RSA* _rsa_pri;
}

+ (instancetype)sharedInstance
{
    static HBRSAHandler *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HBRSAHandler alloc] init];
        [sharedInstance initRSASign];
    });
    return sharedInstance;
}

//-(instancetype) init
//{
//    self = [super init];
//
//    if(self)
//    {
//        [self initRSASign];
//    }
//    return self;
//}

-(void) initRSASign
{
    // 中付付款宝公私钥
    NSString* private_key_string = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAJYBO5Ym5/XI6RCm7QjAcQ8/KIMrPXu6GTM9E3QtYmSRGGHXH90iTPdIcPK8I+sf5QEftR3cf5RoIv2ymenmunDgcs7JeseMnwviK9CsinocgGlivJp+rbYsDxXlLqtTl41fbhJdPXZAt7pAN6zOkWiFwjaQ87V8pBOio0a+QPMdAgMBAAECgYA9Uh2wwRDcGhiktQh7JmhRikkebgPBW49HsfUM7iyl3eawwIeHF6mNATEjGaQ5Tx2HuxWIMoZ4/aUoPuXKh4a5UU5WYFNWH/vwTH6JumhZ60BHS1GMaXDb7tTQiYbB5W1D3Iqv+IranRHylyJn9owv2pltvwz63vS1uGpjdKGUZQJBAOpVlpp1vJhidw6DuYd3QnP/D/Fcq9/eggv5UzGmETIEFrLaHvRQcyvMFHEK4anaoTVQFU3AMR+sbPRl4AJmtQ8CQQCj36qTPW9K8TIa9f5s5xFwsxb/heh1Cjla6Sb2np0hOwGLmMpgZ29YfcNm1s2Zf81f2yaKxi8yMRA1tNYJFE0TAkBqWk3v7F+cCZRfUglyIf5XBvwFXznicOo05QONFQHY4WIr6jMCT0D2L7lXVMj2ffOMbrw8fW3OIkOQ6Guyq0qhAkBlO/k+OIeWPmZ7rVfdoultO9WLSQgPtZ81AC+nzti2/KK5wEvVPlDU0+xwjWY522/eNZ4bwM7LLPAcnXhT54ytAkAFtHpPNGoGlxF0gusbpGUBtYH8XSjIEKQIRxd1bVqrSJeVzCrNMxXnPUoQ/2pf2RTfZEigZ+iQQLQqjqkXy/vH";
    
    NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChMANl6uxlymElSmPjZ+bI9Z0v0IbqYc8VPwilw+/Jeemw5KuiE7rVz7VbB0LhvDGTr5xTl0lgg9QgE4g5WnujjbZBGgIsJgiZjdFRH4O9HaqchAWwAUEaiLBaf8bRC/9KVSoIXWJXnU9snI4dgg3P46JdIQMkuq7WSFxZy43FPwIDAQAB";
    
    //    _rsaHandler = [HBRSAHandler new];
    
    // 使用公私钥字符串
    [self importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
    [self importKeyWithType:KeyTypePublic andkeyString:public_key_string];
    
}

#pragma mark - public methord
-(BOOL)importKeyWithType:(KeyType)type andPath:(NSString *)path
{
    BOOL status = NO;
    const char* cPath = [path cStringUsingEncoding:NSUTF8StringEncoding];
    FILE* file = fopen(cPath, "rb");
    if (!file) {
        return status;
    }
    if (type == KeyTypePublic) {
        _rsa_pub = NULL;
        if((_rsa_pub = PEM_read_RSA_PUBKEY(file, NULL, NULL, NULL))){
            status = YES;
        }
        
        
    }else if(type == KeyTypePrivate){
        _rsa_pri = NULL;
        if ((_rsa_pri = PEM_read_RSAPrivateKey(file, NULL, NULL, NULL))) {
            status = YES;
        }
        
    }
    fclose(file);
    return status;
    
}
- (BOOL)importKeyWithType:(KeyType)type andkeyString:(NSString *)keyString
{
    if (!keyString) {
        return NO;
    }
    BOOL status = NO;
    BIO *bio = NULL;
    RSA *rsa = NULL;
    bio = BIO_new(BIO_s_file());
    NSString* temPath = NSTemporaryDirectory();
    NSString* rsaFilePath = [temPath stringByAppendingPathComponent:@"RSAKEY"];
    NSString* formatRSAKeyString = [self formatRSAKeyWithKeyString:keyString andKeytype:type];
    BOOL writeSuccess = [formatRSAKeyString writeToFile:rsaFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (!writeSuccess) {
        return NO;
    }
    const char* cPath = [rsaFilePath cStringUsingEncoding:NSUTF8StringEncoding];
    BIO_read_filename(bio, cPath);
    if (type == KeyTypePrivate) {
        rsa = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, "");
        _rsa_pri = rsa;
        if (rsa != NULL && 1 == RSA_check_key(rsa)) {
            status = YES;
        } else {
            status = NO;
        }
        
        
    }
    else{
        rsa = PEM_read_bio_RSA_PUBKEY(bio, NULL, NULL, NULL);
        _rsa_pub = rsa;
        if (rsa != NULL) {
            status = YES;
        } else {
            status = NO;
        }
    }
    
    BIO_free_all(bio);
    [[NSFileManager defaultManager] removeItemAtPath:rsaFilePath error:nil];
    return status;
}


#pragma mark RSA sha1验证签名
//signString为base64字符串
- (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString
{
    if (!_rsa_pub) {
        //        NSLog(@"please import public key first");
        return NO;
    }
    
    const char *message = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int messageLength = (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSData *signatureData = [[NSData alloc]initWithBase64EncodedString:signString options:0];
    unsigned char *sig = (unsigned char *)[signatureData bytes];
    unsigned int sig_len = (int)[signatureData length];
    
    
    
    
    unsigned char sha1[20];
    SHA1((unsigned char *)message, messageLength, sha1);
    int verify_ok = RSA_verify(NID_sha1
                               , sha1, 20
                               , sig, sig_len
                               , _rsa_pub);
    
    if (1 == verify_ok){
        return   YES;
    }
    return NO;
    
    
}
#pragma mark RSA MD5 验证签名
- (BOOL)verifyMD5String:(NSString *)string withSign:(NSString *)signString
{
    if (!_rsa_pub) {
        //        NSLog(@"please import public key first");
        return NO;
    }
    
    const char *message = [string cStringUsingEncoding:NSUTF8StringEncoding];
    // int messageLength = (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSData *signatureData = [[NSData alloc]initWithBase64EncodedString:signString options:0];
    unsigned char *sig = (unsigned char *)[signatureData bytes];
    unsigned int sig_len = (int)[signatureData length];
    
    unsigned char digest[MD5_DIGEST_LENGTH];
    MD5_CTX ctx;
    MD5_Init(&ctx);
    MD5_Update(&ctx, message, strlen(message));
    MD5_Final(digest, &ctx);
    int verify_ok = RSA_verify(NID_md5
                               , digest, MD5_DIGEST_LENGTH
                               , sig, sig_len
                               , _rsa_pub);
    if (1 == verify_ok){
        return   YES;
    }
    return NO;
    
}

- (NSString *)signString:(NSString *)string
{
    if (!_rsa_pri) {
        //        NSLog(@"please import private key first");
        return nil;
    }
    const char *message = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int messageLength = (int)strlen(message);
    unsigned char *sig = (unsigned char *)malloc(256);
    unsigned int sig_len;
    
    unsigned char sha1[20];
    SHA1((unsigned char *)message, messageLength, sha1);
    
    int rsa_sign_valid = RSA_sign(NID_sha1
                                  , sha1, 20
                                  , sig, &sig_len
                                  , _rsa_pri);
    if (rsa_sign_valid == 1) {
        NSData* data = [NSData dataWithBytes:sig length:sig_len];
        
        NSString * base64String = [data base64EncodedStringWithOptions:0];
        free(sig);
        return base64String;
    }
    
    free(sig);
    return nil;
}
- (NSString *)signMD5String:(NSString *)string
{
    if (!_rsa_pri) {
        //        NSLog(@"please import private key first");
        return nil;
    }
    const char *message = [string cStringUsingEncoding:NSUTF8StringEncoding];
    //int messageLength = (int)strlen(message);
    unsigned char *sig = (unsigned char *)malloc(256);
    unsigned int sig_len;
    
    unsigned char digest[MD5_DIGEST_LENGTH];
    MD5_CTX ctx;
    MD5_Init(&ctx);
    MD5_Update(&ctx, message, strlen(message));
    MD5_Final(digest, &ctx);
    
    int rsa_sign_valid = RSA_sign(NID_md5
                                  , digest, MD5_DIGEST_LENGTH
                                  , sig, &sig_len
                                  , _rsa_pri);
    
    if (rsa_sign_valid == 1) {
        NSData* data = [NSData dataWithBytes:sig length:sig_len];
        
        NSString * base64String = [data base64EncodedStringWithOptions:0];
        free(sig);
        return base64String;
    }
    
    free(sig);
    return nil;
    
    
}

- (NSString *) encryptWithPublicKey:(NSString*)content
{
    if (!_rsa_pub) {
        //        NSLog(@"please import public key first");
        return nil;
    }
    int status;
    int length  = (int)[content length];
    unsigned char input[length + 1];
    bzero(input, length + 1);
    int i = 0;
    for (; i < length; i++)
    {
        input[i] = [content characterAtIndex:i];
    }
    
    NSInteger  flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pub];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    status = RSA_public_encrypt(length, (unsigned char*)input, (unsigned char*)encData, _rsa_pub, PADDING);
    
    if (status){
        NSData *returnData = [NSData dataWithBytes:encData length:status];
        free(encData);
        encData = NULL;
        
        //NSString *ret = [returnData base64EncodedString];
        NSString *ret = [returnData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
        return ret;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}

- (NSString *) encryptWithPublicKey_supportCN:(NSString*)content
{
    if (!_rsa_pub) {
        //        NSLog(@"please import public key first");
        return nil;
    }
    int status;
    const char* input = [content UTF8String];
    unsigned long length = strlen(input);
    
    NSInteger  flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pub];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    status = RSA_public_encrypt((int)length, (unsigned char*)input, (unsigned char*)encData, _rsa_pub, PADDING);
    
    if (status){
        NSData *returnData = [NSData dataWithBytes:encData length:status];
        free(encData);
        encData = NULL;
        
        //NSString *ret = [returnData base64EncodedString];
        NSString *ret = [returnData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
        return ret;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}

// RSA加密——私钥 Zzz新加20171222，加入中文支持，可以加密包含中文的字符串
- (NSString *) encryptWithPrivateKey_supportCN:(NSString*)content
{
    if (!_rsa_pri) {
        //        NSLog(@"please import private key first");
        return nil;
    }
    int status;
    const char* input = [content UTF8String];
    unsigned long length = strlen(input);
    
    //test
    //    DLog(@"input is :%s", input);
    //    const char* temp = [content UTF8String];
    //    DLog(@"temp char * is %s", temp);
    //    unsigned long tempStrLenght = strlen(temp);
    //    DLog(@"tempStrLenght is %lu", tempStrLenght);
    
    NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pri];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    status = RSA_private_encrypt((int)length, (unsigned char*)input, (unsigned char*)encData, _rsa_pri, PADDING);
    
    if (status)
    {
        NSData *returnData = [NSData dataWithBytes:encData length:status];
        free(encData);
        encData = NULL;
        
        //NSString *ret = [returnData base64EncodedString];
        NSString *ret = [returnData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
        return ret;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}

// RSA加密——私钥 Zzz新加
- (NSString *) encryptWithPrivateKey:(NSString*)content
{
    if (!_rsa_pri) {
        //        NSLog(@"please import private key first");
        return nil;
    }
    int status;
    int length  = (int)[content length];
    unsigned char input[length + 1];
    bzero(input, length + 1);
    int i = 0;
    for (; i < length; i++)
    {
        input[i] = [content characterAtIndex:i];
    }
    
    NSInteger  flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pri];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    
    status = RSA_private_encrypt(length, (unsigned char*)input, (unsigned char*)encData, _rsa_pri, PADDING);
    
    if (status)
    {
        NSData *returnData = [NSData dataWithBytes:encData length:status];
        free(encData);
        encData = NULL;
        
        //        NSString *ret = [returnData base64EncodedString];
        NSString *ret = [returnData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
        
        return ret;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}

- (NSString *) decryptWithPrivateKey:(NSString*)content
{
    if (!_rsa_pri) {
        //        NSLog(@"please import private key first");
        return nil;
    }
    int status;
    //NSData *data = [content base64DecodedData];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    int length = (int)[data length];
    
    NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pri];
    char *decData = (char*)malloc(flen);
    bzero(decData, flen);
    
    status = RSA_private_decrypt(length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa_pri, PADDING);
    
    if (status)
    {
        //        NSMutableString *decryptString = [[NSMutableString alloc] initWithBytes:decData length:strlen(decData) encoding:NSASCIIStringEncoding];
        // utf-8
        NSMutableString *decryptString = [[NSMutableString alloc] initWithBytes:decData length:strlen(decData) encoding:NSUTF8StringEncoding];
        free(decData);
        decData = NULL;
        
        return decryptString;
    }
    
    free(decData);
    decData = NULL;
    
    return nil;
}

// RSA解密——公钥 Zzz新加
- (NSString *) decryptWithPublicKey:(NSString*)content
{
    if (!_rsa_pub) {
        //        NSLog(@"please import public key first");
        return nil;
    }
    int status;
    //NSData *data = [content base64DecodedData];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    int length = (int)[data length];
    
    NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pub];
    char *decData = (char*)malloc(flen);
    bzero(decData, flen);
    
    status = RSA_public_decrypt(length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa_pub, PADDING);
    
    if (status)
    {
        //        NSMutableString *decryptString = [[NSMutableString alloc] initWithBytes:decData length:strlen(decData) encoding:NSASCIIStringEncoding];
        NSMutableString *decryptString = [[NSMutableString alloc] initWithBytes:decData length:strlen(decData) encoding:NSUTF8StringEncoding];
        free(decData);
        decData = NULL;
        
        return decryptString;
    }
    
    free(decData);
    decData = NULL;
    
    return nil;
}

- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type andRSA:(RSA*)rsa
{
    int len = RSA_size(rsa);
    
    if (padding_type == RSA_PADDING_TYPE_PKCS1 || padding_type == RSA_PADDING_TYPE_SSLV23) {
        len -= 11;
    }
    
    return len;
}

-(NSString*)formatRSAKeyWithKeyString:(NSString*)keyString andKeytype:(KeyType)type
{
    NSInteger lineNum = -1;
    NSMutableString *result = [NSMutableString string];
    
    if (type == KeyTypePrivate) {
        [result appendString:@"-----BEGIN PRIVATE KEY-----\n"];
        lineNum = 79;
    }else if(type == KeyTypePublic){
        [result appendString:@"-----BEGIN PUBLIC KEY-----\n"];
        lineNum = 76;
    }
    
    int count = 0;
    for (int i = 0; i < [keyString length]; ++i) {
        unichar c = [keyString characterAtIndex:i];
        if (c == '\n' || c == '\r') {
            continue;
        }
        [result appendFormat:@"%c", c];
        if (++count == lineNum) {
            [result appendString:@"\n"];
            count = 0;
        }
    }
    if (type == KeyTypePrivate) {
        [result appendString:@"\n-----END PRIVATE KEY-----"];
        
    }else if(type == KeyTypePublic){
        [result appendString:@"\n-----END PUBLIC KEY-----"];
    }
    return result;
    
}

// RSA加密——私钥 Zzz新加20171222，加入中文支持和大长度明文(分段加密,解密需要配合分段解密算法)
- (NSString *) encryptWithPrivateKey_supportLongCN:(NSString*)content
{
    //    NSString *unsignLongStr = @"accName=aaa&accNo=6217851234567890123&accPhoneNo=13764111247&cardType=0&certificatenumber=320602198704162515&inTradeOrderNo=20171207&merchantNo=990290077770049&merchantURL=aaa&terminal=PC&terminalNo=77700624";
    
    const char* unsignLongChar = [content UTF8String];
    unsigned long TextLenght = strlen(unsignLongChar);
    //    DLog(@"unsignLongStr lenght is :%lu", TextLenght);
    int blockLength = 128 -11;//加密必须是这个长度
    unsigned long blockCount = TextLenght/blockLength + 1;
    if(TextLenght == blockLength)
    {
        blockCount = 1;
    }
    
    // 分段明文
    NSMutableData *resultData = [[NSMutableData alloc ] initWithCapacity:0];
    
    for(int i = 0; i < TextLenght; i += blockLength)
    {
        if(TextLenght - i < blockLength)
        {
            unsigned long partLenght = TextLenght - i;
            char partChar[partLenght + 1];
            strncpy(partChar, &unsignLongChar[i], partLenght + 1);
            
            char *encryptWithPrivateKey = [self encryptWithPrivateKey_supportCNTestChar:partChar];
            [resultData appendData:[NSData dataWithBytes:encryptWithPrivateKey length:128]];
        }
        else
        {
            // 注意字符串的拷贝函数memcpy和strncpy 20171226
            unsigned long fullPartLenght = 117;
            char fullPartChar[fullPartLenght + 1];
            memcpy(fullPartChar, unsignLongChar + i, fullPartLenght);
            fullPartChar[fullPartLenght] = '\0';
            
            //test
            //            DLog(@"char lenght %lu", strlen(fullPartChar));
            //            DLog(@"tempStr content is  %s", fullPartChar);
            //            NSString *tStr = [NSString stringWithCString:fullPartChar encoding:NSUTF8StringEncoding];
            
            char *encryptWithPrivateKey = [self encryptWithPrivateKey_supportCNTestChar:fullPartChar];
            [resultData appendData:[NSData dataWithBytes:encryptWithPrivateKey length:128]];
        }
    }
    
    NSString *returnStr = [resultData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
    
    // 去掉换行
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    DLog(@"returnStr is :\n%@", returnStr);
    
    return returnStr;
}

- (char*) encryptWithPrivateKey_supportCNTest:(NSString*)content
{
    
    if (!_rsa_pri) {
        //        NSLog(@"please import private key first");
        return nil;
    }
    int status;
    const char* input = [content UTF8String];
    unsigned long length = strlen(input);
    
    NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pri];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    status = RSA_private_encrypt((int)length, (unsigned char*)input, (unsigned char*)encData, _rsa_pri, PADDING);
    
    if (status)
    {
        //        NSData *returnData = [NSData dataWithBytes:encData length:status];
        //        free(encData);
        //        encData = NULL;
        
        //NSString *ret = [returnData base64EncodedString];
        //        NSString *ret = [returnData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
        return encData;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}

- (char*) encryptWithPrivateKey_supportCNTestChar:(char *)content
{
    
    if (!_rsa_pri) {
        //        NSLog(@"please import private key first");
        return nil;
    }
    int status;
    const char* input = content;
    unsigned long length = strlen(input);
    
    NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING andRSA:_rsa_pri];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    status = RSA_private_encrypt((int)length, (unsigned char*)input, (unsigned char*)encData, _rsa_pri, PADDING);
    
    if (status)
    {
        //        NSData *returnData = [NSData dataWithBytes:encData length:status];
        //        free(encData);
        //        encData = NULL;
        
        //NSString *ret = [returnData base64EncodedString];
        //        NSString *ret = [returnData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
        return encData;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}
@end
