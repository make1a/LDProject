//
//  Marcros.h
//  SmartPaint
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 MY. All rights reserved.
//

#ifndef Marcros_h
#define Marcros_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#if 1
#define REQUEST @"http://api.drawx.xunyinghulian.com"
#else
#define REQUEST @"http://47.92.91.192:8002/v1"
#endif

#define OSSREQUEST @"http://oss.drawx.xunyinghulian.com"

#define kCODE            [responseObject[@"code"] integerValue]


#define _weakself __weak typeof(self) weakself = self

// 颜色
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0f green:((hex & 0xFF00) >> 8) / 255.0f blue:(hex & 0xFF) / 255.0f alpha:a]

#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define rgba(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a] //适配蓝湖

#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define PtH(h) h/512.0*SCREEN_HEIGHT
#define PtW(w) w/683.0*SCREEN_WIDTH


/**
 iPhoneX适配
 */

#define DT_IS_IPHONEX_XS   (SCREEN_HEIGHT == 812.f)  //是否是iPhoneX、iPhoneXS
#define DT_IS_IPHONEXR_XSMax   (SCREEN_HEIGHT == 896.f)  //是否是iPhoneXR、iPhoneX Max
#define iPhoneX  (DT_IS_IPHONEX_XS||DT_IS_IPHONEXR_XSMax)  //是否是iPhoneX系列手机

#define kTABBAR_HEIGHT (iPhoneX?(49.f+34.f):49.f)

/**
 Return the statusBar height.
 */
#define kSTATUSBAR_HEIGHT (iPhoneX?44.0f:20.f)

#define LiveRemandViewY   (iPhoneX?44.0f:0.f)

/**
 Return the navigationBar height.
 */
#define kNAVIGATION_HEIGHT (44.f)

/**
 Return the (navigationBar + statusBar) height.
 */
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX?88.0f:64.f)

/**
 Return 没有tabar 距 底边高度
 */
#define BOTTOM_SPACE_HEIGHT (iPhoneX?34.0f:0.0f)



#endif /* Marcros_h */
