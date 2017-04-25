//
//  Base64Utils.m
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import "Base64Utils.h"

@implementation Base64Utils

//给定一个字符串，对该字符串进行Base64编码，然后返回编码后的结果
+(NSString *)base64EncodeString:(NSString *)string
{
    //1.先把字符串转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.对二进制数据进行base64编码，返回编码后的字符串
    return [data base64EncodedStringWithOptions:0];
}

+(NSString *)base64EncodeData:(NSData *)data
{
    return [data base64EncodedStringWithOptions:0];
}

//对base64编码后的字符串进行解码
+(NSString *)base64DecodeString:(NSString *)string
{
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
