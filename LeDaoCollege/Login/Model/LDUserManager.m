//
//  LDUserManager.m
//  LeDaoCollege
//
//  Created by Make on 2019/10/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDUserManager.h"
#import "LDUserModel.h"
@implementation LDUserManager

+(instancetype)shareInstance {
    static LDUserManager * model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [LDUserManager new];
    });
    return model;
}

- (void)setCurrentUser:(LDUserModel *)currentUser{
    _currentUser = currentUser;
    [self saveUserID];
}

+ (NSString *)userID {
    NSString * s = [[NSUserDefaults standardUserDefaults]valueForKey:@"_currentUser.userId"];
    return s;
}
+ (void)removeUserID{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"_currentUser.userId"];
}
- (void)saveUserID{
    [[NSUserDefaults standardUserDefaults]setValue:_currentUser.userId forKey:@"_currentUser.userId"];
}
+ (BOOL)isLogin{
    NSString * s = [[NSUserDefaults standardUserDefaults]valueForKey:@"_currentUser.userId"];
    return s.length;
}
@end
