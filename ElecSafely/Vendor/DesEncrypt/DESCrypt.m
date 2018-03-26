//
//  DESCrypt.m
//  EncryptTest
//
//  Created by duziqing on 12-11-6.
//  Copyright (c) 2012年 duziqing. All rights reserved.
//

#import "DESCrypt.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"
#import "Base64.h"

@implementation DESCrypt

const Byte iv[] = {1,2,3,4,5,6,7,8};

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [Base64 encode:data];
    }
    return ciphertext;
}

+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    NSString *plaintext = nil;
    NSData *cipherdata = [Base64 decode:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

+ (NSString *)encryptHEX:(NSString *)message password:(NSString *)password
{
    //补齐字节
    message =[self buqi:message];
    NSData* encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] DESEncryptedDataUsingKey:[password dataUsingEncoding:NSUTF8StringEncoding]  error:nil];
    return [encryptedData stringWithHexBytes2];
}

+ (NSString *)decryptHEX:(NSString *)encodedString password:(NSString *)password
{
    NSData *encryptedData = [NSData stringToByte:encodedString];
    NSData *decryptedData = [encryptedData decryptedDESDataUsingKey:[password dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSString *)encryptUTF8:(NSString *)message password:(NSString *)password
{
    //补齐字节
    NSData* encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] DESEncryptedDataUsingKeyUseUTF8:[password dataUsingEncoding:NSUTF8StringEncoding]  error:nil];

    NSString *base64String = [NSString base64StringFromData:encryptedData length:[encryptedData length]];

//    HWLog(@"-----encryptUTF8= %@",base64String);

    return base64String;
}

+ (NSString *)decryptUTF8:(NSString *)base64EncodedString password:(NSString *)password
{
    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
    NSData *decryptedData = [encryptedData decryptedDESDataUsingKeyUseUTF8:[password dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    
//    HWLog(@"----decryptUTF8=%@", [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding]);
    
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSString*)buqi:(NSString*)a
{
    NSData *aData = [a dataUsingEncoding: NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[aData bytes];
    NSUInteger l = [aData length];
    NSUInteger yushu = l%8;
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;

    NSUInteger buqidata = 8 - yushu;
    bufferPtrSize = 8 - yushu + l;
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, buqidata, bufferPtrSize);
    memcpy((void *)bufferPtr,bytes,l);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)bufferPtrSize];
    free(bufferPtr);
    bufferPtr = NULL;
    return [[NSString alloc]initWithData:myData encoding:NSUTF8StringEncoding];
}
//+ (NSString *)encrypt:(NSString *)message password:(NSString *)password {
//    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
//    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
//    return base64EncodedString;
//}
//
//+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password {
//    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
//    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
//    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
//}

@end
