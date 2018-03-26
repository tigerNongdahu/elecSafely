//
//  RSA.h
//  iMSSiPhonePlatform
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GenerateSuccessBlock)(void);

@interface RSA : NSObject

@property (nonatomic,readonly) SecKeyRef publicKeyRef;
@property (nonatomic,readonly) SecKeyRef privateKeyRef;
@property (nonatomic,readonly) NSData   *publicKeyBits;
@property (nonatomic,readonly) NSData   *privateKeyBits;
@property (nonatomic,readonly) NSString *publicKeyString;

+  (id)shareInstance;
- (void)generateKeyPairRSACompleteBlock:(GenerateSuccessBlock)_success;

//rsa16进制解密
//密文:9a5bd806dc11baa3b9270dc0588a8e11ce0bb7d4ca56d07ab56bbffa0f39820fa47634eade32fd5aabde840879ffd6ab2ed9833fd2b985804fe5372776a98790bf37d0b06b6f23c905fcdab562c18bd10abaa6b7cbd8cbe2fc961c9f0d3066ea5d75aba7743d6b9b8541e0aeaf2023f05b15ab4d27232b03e3e356395d72fe1a
//解出来的明文:b2fe91fb014275de6eaf36a4b30e3860
+ (NSString *)decryptUTF16String:(NSString *)str privateKey:(NSString *)privKey;

- (NSString *)publicKeyString;
- (NSString *)privateKeyString;

- (NSData *)RSA_EncryptUsingPublicKeyWithData:(NSData *)data;
- (NSData *)RSA_EncryptUsingPrivateKeyWithData:(NSData*)data;
- (NSData *)RSA_DecryptUsingPublicKeyWithData:(NSData *)data;
- (NSData *)RSA_DecryptUsingPrivateKeyWithData:(NSData*)data;
- (NSString *)getPublicKeyAsBase64ForJavaServer;

@end
