//
//  MYConstansManager.h
//  SmartPaint
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 MY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

//Umeng appkey
UIKIT_EXTERN  NSString * const UMengAppkey;
UIKIT_EXTERN  NSString * const QQAPPID;
UIKIT_EXTERN  NSString * const QQAPPKEY;
UIKIT_EXTERN  NSString * const JPushKEY;
UIKIT_EXTERN  NSString * const WXAPPKEY;
UIKIT_EXTERN  NSString * const WXAPPSecret;

UIKIT_EXTERN  NSString * const UserModelNotification;
UIKIT_EXTERN  NSString * const IsLoginUserdefault;
UIKIT_EXTERN  NSString * const LoginOutUserdefault;
UIKIT_EXTERN  NSString * const kLocalPurchData;
//记录首页图片的name
UIKIT_EXTERN  NSString * const MYUserDefaultHomeBgImageName ;

//完成画图，将图片转到另一个新的容器
UIKIT_EXTERN  NSString * const MYCompleteDrawImageNotification ;
UIKIT_EXTERN  NSString * const MYRestNotification ;

//Pop
UIKIT_EXTERN  NSString * const MYDrawViewPopNotification ;

UIKIT_EXTERN  NSInteger const MYAutoDrawLineWidth ;

UIKIT_EXTERN  NSString * const ZHSpliceVCNotBackNotification ;


UIKIT_EXTERN  NSString * const kSpriteNodeDidLoadlNotification;


typedef void(^backSourceCountBlock)(NSInteger count);

#define kSpliceConatinerBGViewX PtW(11)
#define kSpliceConatinerBGViewY PtH(15)
#define kSpliceConatinerBGViewW PtW(470)
#define kSpliceConatinerBGViewH PtH(480)

#pragma mark - 枚举

