//
//  TFLoginProgram.h
//  ElecSafely
//
//  Created by Tianfu on 01/02/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFLoginProgram;

@protocol TFLoginProgramDelegate <NSObject>

- (void)loginProgram:(TFLoginProgram *)program DidLoginSuccess:(NSString *)account passWord:(NSString *)password;

- (void)loginProgram:(TFLoginProgram *)program DidLoginFailed:(NSString *)error;

@end

@interface TFLoginProgram : NSObject

@property (nonatomic, weak) id<TFLoginProgramDelegate> delegate;


+ (instancetype)sharedInstance;

+ (NSString *)getPassword;

- (void)userLoginWithAccount:(NSString *)account passWord:(NSString *)password;

- (void)relogin:(NSString *)account and:(NSString *)password;


@end
