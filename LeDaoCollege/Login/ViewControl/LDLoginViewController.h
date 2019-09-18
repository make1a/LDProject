//
//  LDLoginViewController.h
//  LeDaoCollege
//
//  Created by make on 2019/9/8.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LDCurrentPageIsLogin = 0,
    LDCurrentPageIsRegister,
    LDCurrentPageIsBindPhone,
} LDCurrentPageEnum;

@interface LDLoginViewController : QMUICommonViewController
@property (nonatomic,assign)LDCurrentPageEnum currentPageType;

@end

NS_ASSUME_NONNULL_END
