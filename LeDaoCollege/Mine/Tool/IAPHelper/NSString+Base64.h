//
//  NSString+Base64.h
//  Newsstand
//
//  Created by Carlo Vigiani on 29/Oct/11.
//  Copyright (c) 2011 viggiosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *) base64StringFromData:(NSData *)data length:(long)length;
//Base64加密
- (NSString*)base64EncodeString ;

//Base64解密
- (NSString*)base64DecodeString ;

@end
