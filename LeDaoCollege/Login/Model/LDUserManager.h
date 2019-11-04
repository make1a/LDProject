//
//  LDUserManager.h
//  LeDaoCollege
//
//  Created by Make on 2019/10/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LDUserModel;
NS_ASSUME_NONNULL_BEGIN

@interface LDUserManager : NSObject
@property (nonatomic,strong) LDUserModel* currentUser;

+(instancetype)shareInstance;
+ (BOOL)isLogin;
+ (NSString *)userName;
+(void)removeUserID;
+ (NSString *)userID;
@end

NS_ASSUME_NONNULL_END
