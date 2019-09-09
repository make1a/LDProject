//
//  HNTools.h
//  LiveShow
//
//  Created by Sunwanwan on 2017/7/18.
//  Copyright © 2017年 HN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void  (^BackSure)();
typedef void  (^CancelBack)();
@interface HNTools : NSObject
@property (nonatomic, copy) BackSure block; //!< 确定的回调
@property (nonatomic,copy)CancelBack  canBlock;//取消的回调
/**
 *  过滤空格后返回的字符 是否为空
* @title    标题
* @message  内容
* @sureWord   确定按钮标题
* @cancelStr  取消按钮标题
* @control   显示的控制器
* @block  确定回调
*canBlock   取消回调
 
 */
+ (void)ShowAlertWith:(NSString *)title message:(NSString *)message sureTitle:(NSString*)sureWord andCancel:(NSString*)cancelStr viewControl:(UIViewController *)control andSureBack:(BackSure)block andCancelBack:(CancelBack)canBlock;

///只有确定
+(void)ShowOnlyAlertWith:(NSString*)title message:(NSString*)message andSureTitle:(NSString*)sureTitle viewControl:(UIViewController*)control andSureBack:(BackSure)block;

// 图片加载显示
+ (NSString *)pictureStr:(NSString *)sufficx;
//oss 图片缩略图拼接
+ (NSString*)returnPictureStr:(NSString*)imgUrl andW:(NSInteger)wNum andH:(NSInteger)hNum;
// 请求地址的拼接
+ (NSString *)urlstrSuffix:(NSArray *)key withValue:(NSArray *)value with:(NSString *)suffix;
// 验证图片地址是否有http
+ (BOOL)verificationPictureUrlStr:(NSString*)urlStr;
// 属性文字
+(NSMutableAttributedString *)getAttributedString:(NSString *)allString withStringAttributedDic:(NSDictionary *)dic withSubString:(NSString *)subString withSubStringAttributeDic:(NSDictionary *)subDic;


+ (NSMutableAttributedString *)changeStrWittContext:(NSString *)context ChangeColorText:(NSString *)ColorStr WithColor:(id)ColorValue WithFont:(id)FontValue;

// 获取字符串大小
+(CGRect)getStringFrame:(NSString *)str withFont:(NSInteger)fontSize withMaxSize:(CGSize)size;

// 时间戳转时间
+ (NSString *)turnTimeTimestamp:(NSString *)timeStamp withType:(NSString *)type;

// 将时间戳转换为多少分钟前 (按照时间规格转换)
+ (NSString *)turnTimeForTimestamp:(NSString *)timeStamp showDetail:(BOOL)showDetail;

// 将一段时间转换 eg：5分钟转化为00：05：00
+ (NSString *)changMinuteToTime:(NSString *)minute;

// 验证手机号码是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 *  过滤空格后返回的字符 是否为空
 * @return YES 不为空 NO  为空
 */
+ (BOOL)filterSpace:(NSString*)string;
// 过滤空格
+ (NSString*)filterLastSpace:(NSString*)string;

// 验证邮箱格式是否正确
+ (BOOL)isValidateEmail:(NSString *)email;

// 判断身份证是否是真实的
+ (BOOL)isValidateIDCardNumber:(NSString *)value;

// 支持单次获得网络状态
+ (NSString *)networkStatusChangeApple;
// 图片 Kb 压缩
+ (UIImage *)zipImageWithImage:(UIImage *)image withMaxSize:(NSInteger)kBit;
//   验证 qq  微信  微博 是否可以用
// 检测输入内容是否为数字
+ (BOOL)validateNumber:(NSString*)number;

+ (BOOL)isSupportWX;
+ (BOOL)isSupportQQ;
+ (BOOL)isSupportSina;
// 比较两个时间差
+ (BOOL)comperTTwoMessage:(NSString*)lastTime andNewTime:(NSString*)newTime;
// 验证是否是数字
+(BOOL)isNumber:(NSString *)string;
// 获取软件版本号
+ (NSString*)GetApp_Version;
//   替换万位一下数字
+(NSString*)ChangeNumStr:(NSString*)number;

// 获取当前视图所在的控制器
+(UIViewController*)getcurrentVC:(UIView*)view;
// 获取手机型号
+ (NSString*)deviceVersion;
//获取当前显示控制器
+ (UIViewController *)getCurrentVC;
#pragma mark -----------------------------  项目相关 ---------------------
// 保存图片到沙盒
+ (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName;
// 根据图片名从获取图片路径
+ (NSString *)getImagePathWithName:(NSString *)name;
// 等比例压缩图片
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;


// MD5加密
+ (NSString *)md5To32bit:(NSString *)str;

// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)json;





@end
