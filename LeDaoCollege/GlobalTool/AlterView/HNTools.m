//
//  HNTools.m
//  LiveShow
//
//  Created by Sunwanwan on 2017/7/18.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNTools.h"

@implementation HNTools


// 属性文字
+(NSMutableAttributedString *)getAttributedString:(NSString *)allString withStringAttributedDic:(NSDictionary *)dic withSubString:(NSString *)subString withSubStringAttributeDic:(NSDictionary *)subDic
{
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]initWithString:allString attributes:dic];
    NSRange range = [allString rangeOfString:subString];
    [resultString addAttributes:subDic range:range];
    return resultString;
}

+ (NSMutableAttributedString *)changeStrWittContext:(NSString *)context ChangeColorText:(NSString *)ColorStr WithColor:(id)ColorValue WithFont:(id)FontValue {
    if (context == nil || ColorStr == nil) {
        return nil;
    }
    NSMutableAttributedString* inputStr = [[NSMutableAttributedString alloc]initWithString:context];
    NSRange ColorRange = NSMakeRange([[inputStr string]rangeOfString:ColorStr options:NSBackwardsSearch].location, [[inputStr string]rangeOfString:ColorStr].length);
    
    [inputStr addAttributes:@{NSForegroundColorAttributeName:ColorValue,NSFontAttributeName:FontValue} range:ColorRange];
    return inputStr;
    
}
//获取字符串大小
+(CGRect)getStringFrame:(NSString *)str withFont:(NSInteger)fontSize withMaxSize:(CGSize)size{
    
    CGRect rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect;
}

// 时间戳转时间
+ (NSString *)turnTimeTimestamp:(NSString *)timeStamp withType:(NSString *)type
{
    NSTimeInterval time=[timeStamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:type];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}


+ (NSString *)getPeriodOfTime:(NSInteger)time withMinute:(NSInteger)minute
{
    NSInteger totalMin = time *60 + minute;
    NSString *showPeriodOfTime = @"";
    if (totalMin > 0 && totalMin <= 5 * 60)
    {
        showPeriodOfTime = @"凌晨";
    }
    else if (totalMin > 5 * 60 && totalMin < 12 * 60)
    {
        showPeriodOfTime = @"上午";
    }
    else if (totalMin >= 12 * 60 && totalMin <= 18 * 60)
    {
        showPeriodOfTime = @"下午";
    }
    else if ((totalMin > 18 * 60 && totalMin <= (23 * 60 + 59)) || totalMin == 0)
    {
        showPeriodOfTime = @"晚上";
    }
    return showPeriodOfTime;
}



//+ (BOOL)isSupportWX {
//
//    return [WXApi isWXAppSupportApi] && [WXApi isWXAppInstalled];
//}
//
//+ (BOOL)isSupportQQ {
//    return [QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi];
//}
//
//+ (BOOL)isSupportSina {
//
//    return [WeiboSDK isCanSSOInWeiboApp] && [WeiboSDK isWeiboAppInstalled] && [WeiboSDK isCanShareInWeiboAPP];
//}

// 获取软件版本号
+ (NSString*)GetApp_Version
{
   NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
   NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
   return app_Version;
    
}
// 过滤空格
+ (BOOL)filterSpace:(NSString*)string
{
    NSString   *reStr = nil;
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSLog(@"urlStr = %@",string);
    //过滤中间空格
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"urlStr = %@",string);
    reStr = string;
    if (reStr.length>0) {
        return YES;
    }else{
        return NO;
    }
}
// 过滤空格
+ (NSString*)filterLastSpace:(NSString*)string
{
    NSString   *reStr = nil;
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSLog(@"urlStr = %@",string);
    //过滤中间空格
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"urlStr = %@",string);
    reStr = string;
    return  reStr;
    
}
// 验证手机号码是否有效
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188 199
     * 联通号段: 130,131,132,145,155,156,166,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9]|9[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,166,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|6[0-6]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 验证邮箱格式是否正确
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 判断身份证是否是真实的
+ (BOOL)isValidateIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    
    if (!value) {
        return NO;
    }else {
        length = value.length;
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]){
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag){
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    NSInteger year = 0;
    
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
            
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value  substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value  substringWithRange:NSMakeRange(3,1)].intValue + [value  substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value  substringWithRange:NSMakeRange(4,1)].intValue + [value  substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value  substringWithRange:NSMakeRange(5,1)].intValue + [value  substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value  substringWithRange:NSMakeRange(6,1)].intValue + [value  substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value  substringWithRange:NSMakeRange(7,1)].intValue *1 + [value  substringWithRange:NSMakeRange(8,1)].intValue *6 + [value  substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                
                NSString *M =@"F";
                
                NSString *JYM =@"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
            
        default:
            return NO;
            
    }
}


// 图片 Kb 压缩
+ (UIImage *)zipImageWithImage:(UIImage *)image withMaxSize:(NSInteger)kBit
{
    NSLog(@"开始时间");
    if (!image) {
        return nil;
    }
    CGFloat maxFileSize = kBit*1024;
    CGFloat compression = 0.9f;
    //    compression = 0.7;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    int i = 0;
    while ([compressedData length] > maxFileSize) {
        compression *= compression;
        compressedData = UIImageJPEGRepresentation([[self class] compressImage:image newWidth:image.size.width*compression], compression);
        i++;
    }
    NSLog(@"循环处理次数 === %d",i);
    UIImage  *backImg = [UIImage imageWithData:compressedData];
    return backImg;
}
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    @autoreleasepool {
        if (widthScale > heightScale) {
            [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
            
        }
        else {
            [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
            
        }
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
}
// 检测输入内容是否为数字
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
+(NSString*)getPersionAge:(NSString*)birth;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    NSString  *ageStr =[NSString  stringWithFormat:@"%ld",age];
    
    return ageStr;
    
}
#pragma mark -----------------------------  项目相关 ---------------------

// 等比例压缩图片
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 两个时间戳是否相隔5分钟
+ (BOOL)timeIntervalIsSpaceFiveMinutes:(NSString *)lastTime nowTime:(NSString *)nowTime
{    
    NSTimeInterval startTime = [lastTime doubleValue];
    NSTimeInterval endTime = [nowTime doubleValue];
    
    //这个是相隔的秒数
    NSTimeInterval timeInterval = endTime - startTime;
    
    //相距5分钟显示时间Label
    if (fabs (timeInterval) > 300)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isNumber:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//   替换万位一下数字
+(NSString*)ChangeNumStr:(NSString*)number
{
    NSString     *string = nil;
    if ([number isKindOfClass:[NSNull class]]||number==nil||[number isEqualToString:@""]) {
        string =@"0.00";
        return string;
    }
    if ([number rangeOfString:@"."].location!=NSNotFound) {
        // 有小数点数据
        CGFloat    num = [number floatValue];
        NSString  *changeNum=  [NSString stringWithFormat:@"%.2f",num];
        if (num/10000<1) {
            string = [NSString stringWithFormat:@"%@",changeNum];
        }else{
            float  result =  num/10000.0;
            if (result>=1000) {
              string = @"999+万";;
            }else{
                NSString   *hash = [self notRounding:result afterPoint:2];
                string = [NSString  stringWithFormat:@"%@万",hash];
            }
           
            
        }
 
    }else{
         NSInteger  num= [number integerValue];
         NSString  *lastNum=  [NSString stringWithFormat:@"%ld",num];
        if (num/10000<1) {
            string = [NSString stringWithFormat:@"%@",lastNum];
        }else{
            float  result =  num/10000.0;
            if (result>=1000) {
                string = @"999+万";;
            }else{
                NSString   *hash = [self notRounding:result afterPoint:2];
                string = [NSString  stringWithFormat:@"%@万",hash];
            }
        }

        
    }
//    CGFloat    num = [number floatValue];
//    NSString  *lastNum=  [NSString stringWithFormat:@"%.2f",num];
//    if ([lastNum hasPrefix:@"."]) {
//        if (num/10000<1) {
//            string = [NSString stringWithFormat:@"%@",lastNum];
//        }else{
//            float  result =  num/10000.0;
//            NSString   *hash = [self notRounding:result afterPoint:2];
//            string = [NSString  stringWithFormat:@"%@万",hash];
//        }
//        
//    }else{
//        
//        if (num/10000<1) {
//            string = [NSString stringWithFormat:@"%@",lastNum];
//        }else{
//            float  result =  num/10000.0;
//            NSString   *hash = [self notRounding:result afterPoint:2];
//            string = [NSString  stringWithFormat:@"%@万",hash];
//        }
//    }
    return string;
    
}


+ (NSString *)notRounding:(float)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}

// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)json
{
    if (json == nil)
    {
        return nil;
    }
    if ([json isKindOfClass:[NSData class]]) {
        return nil;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString*)returnTimeWithMandS:(NSString*)secondstr;
{
    int timeout = [secondstr intValue];
     NSString *minStr = nil;
     NSString  *secStr = nil;
    int minute = (int)timeout/60;
    int second = timeout-minute*60;
    minStr = [NSString stringWithFormat:@"%.2d",minute];
    secStr = [NSString stringWithFormat:@"%.2d",second];
    NSString   *timeStr =[NSString stringWithFormat:@"%@:%@",minStr,secStr];
    return timeStr;
}

@end
