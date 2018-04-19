//
//  ViewController.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 15/10/17.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "RSAViewController.h"
#import "HBRSAHandler.h"

@interface RSAViewController ()

@end

@implementation RSAViewController
{
    HBRSAHandler* _handler;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString* private_key_string = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALgv/syFH337KzC29KvR0p6cP+glRqjDYAQno5ifafXZjgf1EhBjZblKv+HiLAzNBOlYU1PnLuOOkZj6pg1A5HUZLpsbYa5Mwr1bUHALjXLaB3THCpZX51/b5L14erGo52Jv/j/63YljEtMm8ALmkY8S+3fPxFeY7ya+2VXMEtplAgMBAAECgYAguvauZWGpQ37zUy+7cLfa061PlYAu8TkYw+qAbqOnupdQtq4VF3S2LqBWhZiKVcxvovB70nM0oNsisjfb1xJBpyfDBFug7d+y2f8yr6aTOezoY5DBYEF3Svg9Kp9ra+vvAYX/7fh+tHCU0HOvp0z8ikZiRSWZaQ+3A2GiCIJrwQJBAPKVji89hGAMEWLJJFZaPiLBqZUwR2W/rp7Ely5ddKfjcosHhggHfOb71BnrMOm0h4S85Gx6a87n9R2To0c51q0CQQDCX6yYdt/9JGORyNSXfzMfSZyVOrMpIo77R0YwKa3UOwwLA56l2Lc4AYO10/lyAyZCKse2/5D9ZZUB7xoYEmGZAkB8MEJVPuoY/bSc3RqENrjetERsAwZaObJcx4oaC3AgTxmhwV1FmQfBfKTODBDDZE+Ijedm/ZlZmHhtBtstKJgVAkBKma/DgHRtUscIT90QHBjB3F3FhJb4pbPcyzksCQMXXmY73/LG0ktXqnUjlyy4zm6jnIm0OZgrOQ6chGkubfeZAkBMCGF2tPfEJh8XODOvlw5ADnUiq+Qe/abcpKowkiT9zP+rYT9XJAx7QxChjdwTZb6ahnJY1+ny1emEHUOs2fm8";
    
    NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4L/7MhR99+yswtvSr0dKenD/oJUaow2AEJ6OYn2n12Y4H9RIQY2W5Sr/h4iwMzQTpWFNT5y7jjpGY+qYNQOR1GS6bG2GuTMK9W1BwC41y2gd0xwqWV+df2+S9eHqxqOdib/4/+t2JYxLTJvAC5pGPEvt3z8RXmO8mvtlVzBLaZQIDAQAB";
    
    
    
    HBRSAHandler* handler = [HBRSAHandler new];
    [handler importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
    [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];
    _handler = handler;
    
    //需要签名的字符串
    NSString *plainText = @"zhouzezhou";
    
    NSString* enPrivateString = [handler encryptWithPrivateKey:plainText];
    NSLog(@"\n\nenPrivateString:\n %@",enPrivateString);
    
    NSString *tempString = @"RH+imgTWqNxXIMWXfHUzvAX45eQyfTgvPHJ4eo8ZMZLORIl+CPe7yQayPTkAbIGfujDTRWWDyfCV2wg/YitGmOOYcsm+BwWGIQUbcpomc5onFOPYi+0PPRBGssqHqWfW0/SAo5POVDK8eXy0mI9CsFn/KXNFeNX+27D1NeliRjAfjWn9KgzECEhXtAqFPMFCkkm36LvxRIhyhVS+ZHEDgPKBbU+6HsAcGknbKjTkhkjMAjlfCPhV4bEXlO7xYjzFUvcfi1uET45YjVKg/L38jdZCWGiryuN3RbDmUIePl+yiCmmXNl0uPrph58vfn2LmVLe+DgP3uVfMmoPI7iYz19/OykuozAihsZQCHeBj9BLvtAC9wPxbQd6j3DukCuVEpYq6SFTQrw2/0pCP/DdKkfO1IdsQBN+3KV9LqedUWNDUkxfn6PxLfPfcipGav1HA6/zldK+B8Ep9hI2pvkaX4RD5xSQO4i+hlixM3eU8UTD6+HdoDGrhJXGqRh8lx9L+5+rhVJPjTUKY2+RepZqNa7laqwbi5tdrqYMHcb/TKvA6KAdsWncUzdT7fZ1C0jyae38R7eHXzJzujvgzwm/x+7QXtSFwn6fP+Rq6lR62z1zb3N18GwW3o+PnyFAK/DUm38gXOuWo5zZsqhz4os8AopFwsDWuvOlOwM5AW2RiXDI=";
    
    
    NSString* dePublicStringtemp = [handler decryptWithPublicKey:tempString];
    NSLog(@"\n\ndePublicString:\n%@",dePublicStringtemp);
}

- (IBAction)clickButotn:(id)sender
{
    NSString *securityKey = @"4xz9ATkHgozzxhQXAvDfus0pybGtMUXRhugwHBUANlI=";
    NSString *result = [_handler decryptWithPublicKey:securityKey];
    NSLog(@"result :%@", result);    
}

@end
