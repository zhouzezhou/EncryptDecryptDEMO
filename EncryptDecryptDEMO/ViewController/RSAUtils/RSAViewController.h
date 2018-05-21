//
//  RSAViewController.h
//  EncryptDecryptDEMO
//
//  Created by zhouzezhou on 2017/4/25.
//  Copyright © 2017年 zhouzezhou. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 注意：
 1. 在做RSA加密的时候，RSA里使用了OpenSSL，将整个RSA加密的代码拖出/add files in之后出现某些头文件找不到no find的情况
 原因： Xcode找不到需要的头文件
 解决： 进入项目设置，设置TARGET下项目里的Header Search Paths的路径，添加一项为“$(PROJECT_DIR)/NewRSATUtils”的值，NewRSATUtils为当前项目的名称，如：freeman之类的
 如果openssl头文件所有的文件夹在其它文件夹下面可以将路径具体到头文件所在的上一级，eg:$(PROJECT_DIR)/EncryptDecryptDEMO/EncryptDecryptUtils/RSAUtils
 clean工程再build就可以了,如果仍然不行,把与RSA相关的.a文件删除再重新拖到项目中解决问题

 2. ”Build Settings”->”Enable Bitcode”设置为NO ，因为有些SDK不支持Bitcode
 */
@interface RSAViewController : UIViewController

@end
