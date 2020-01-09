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

//#if 1
//#define REQUEST @"http://api.drawx.xunyinghulian.com"
//#else
//#define REQUEST @"http://47.92.91.192:8002/v1"
//#endif
//
//#define OSSREQUEST @"http://oss.drawx.xunyinghulian.com"

#define kCODE            [responseObject[@"returnCode"] integerValue]
#define kUserID   [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]
#define kUDID     [[NSUserDefaults standardUserDefaults]objectForKey:@"UDID"]
#define kTOKEN    [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]

#define ShowMsgInfo [QMUITips showSucceed:responseObject[@"returnMsg"]]
#define _weakself __weak typeof(self) weakself = self

#define kRequestFailMsg    @"充值失败,请稍后再试"

//PDF管理文件的归档路径
#define SavePDFDocumenToPlisttPath(name)     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:[NSString stringWithFormat:@"/%@.plist",name]]
//PDF Data 归档路径
#define SavePDFDataPath(name)     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:[NSString stringWithFormat:@"/%@.data",name]]

// 颜色
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0f green:((hex & 0xFF00) >> 8) / 255.0f blue:(hex & 0xFF) / 255.0f alpha:a]

#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define rgba(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a] //适配蓝湖

// app主色调
#define MainThemeColor [UIColor colorWithRed:105/255.0 green:182/255.0 blue:129/255.0 alpha:1.0]
#define DisableMainThmeColor UIColorFromHEXA(0xC1E1CB, 1.0)
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define kScreenWidth    SCREEN_WIDTH
#define kScreenHeight   SCREEN_HEIGHT

#define SCREEN_SCALE  ((SCREEN_WIDTH > 414) ? (SCREEN_HEIGHT/375.0) : (SCREEN_WIDTH/375.0))
#define Handle(x)        ((x)*SCREEN_SCALE)
#define Handle_width(w)  ((w)*SCREEN_SCALE)
#define Handle_height(h) ((h)*SCREEN_SCALE)

#define PtHeight(h) h/667.0*SCREEN_HEIGHT
#define PtWidth(w) w/375.0*SCREEN_WIDTH


// 系统默认字体设置和自选字体设置
#define SystemFontSize(fontsize) [UIFont systemFontOfSize:(fontsize)]
#define SystemBoldFontSize(fontsize) [UIFont boldSystemFontOfSize:(fontsize)]
#define CustomFontSize(fontname,fontsize) [UIFont fontWithName:fontname size:fontsize]

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



#define UIColorGray1 UIColorMake(53, 60, 70)
#define UIColorGray2 UIColorMake(73, 80, 90)
#define UIColorGray3 UIColorMake(93, 100, 110)
#define UIColorGray4 UIColorMake(113, 120, 130)
#define UIColorGray5 UIColorMake(133, 140, 150)
#define UIColorGray6 UIColorMake(153, 160, 170)
#define UIColorGray7 UIColorMake(173, 180, 190)
#define UIColorGray8 UIColorMake(196, 200, 208)
#define UIColorGray9 UIColorMake(216, 220, 228)

#define UIColorTheme1 UIColorMake(239, 83, 98) // Grapefruit
#define UIColorTheme2 UIColorMake(254, 109, 75) // Bittersweet
#define UIColorTheme3 UIColorMake(255, 207, 71) // Sunflower
#define UIColorTheme4 UIColorMake(159, 214, 97) // Grass
#define UIColorTheme5 UIColorMake(63, 208, 173) // Mint
#define UIColorTheme6 UIColorMake(49, 189, 243) // Aqua
#define UIColorTheme7 UIColorMake(90, 154, 239) // Blue Jeans
#define UIColorTheme8 UIColorMake(172, 143, 239) // Lavender
#define UIColorTheme9 UIColorMake(238, 133, 193) // Pink Rose

#endif /* Marcros_h */
