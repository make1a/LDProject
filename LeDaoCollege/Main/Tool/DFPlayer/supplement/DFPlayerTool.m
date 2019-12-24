//
//  DFPlayerTool.m
//  DFPlayer
//
//  Created by ihoudf on 2017/7/30.
//  Copyright © 2017年 ihoudf. All rights reserved.
//

#import "DFPlayerTool.h"


static DFPlayerNetworkStatus _networkStatus;

@implementation DFPlayerTool

+ (NSURL *)customURL:(NSURL *)URL{
    NSString *URLString = [URL absoluteString];
    if ([URLString rangeOfString:@":"].location != NSNotFound) {
        NSString *scheme = [[URLString componentsSeparatedByString:@":"] firstObject];
        if (scheme) {
            NSString *newScheme = [scheme stringByAppendingString:@"-streaming"];
            URLString = [URLString stringByReplacingOccurrencesOfString:scheme withString:newScheme];
            return [NSURL URLWithString:URLString];
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

+ (NSURL *)originalURL:(NSURL *)URL{
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:URL
                                                resolvingAgainstBaseURL:NO];
    components.scheme = [components.scheme stringByReplacingOccurrencesOfString:@"-streaming" withString:@""];
    return [components URL];
}

+ (BOOL)isLocalAudio:(NSURL *)URL{
    return [URL.absoluteString hasPrefix:@"http"] ? NO : YES;
}

+ (BOOL)isNSURL:(NSURL *)URL{
    return [URL isKindOfClass:[NSURL class]];
}

+ (void)startMonitoringNetworkStatus:(void (^)(DFPlayerNetworkStatus))block{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                _networkStatus = DFPlayerNetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _networkStatus = DFPlayerNetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _networkStatus = DFPlayerNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _networkStatus = DFPlayerNetworkStatusReachableViaWiFi;
                break;
        }
        if (block) {
            block(_networkStatus);
        }
    }];
    [mgr startMonitoring];
}

+ (void)stopMonitoringNetwork{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

+ (DFPlayerNetworkStatus)networkStatus{
    return _networkStatus;
}

@end

@implementation UIImage (DFPlayerImageExtensions)

- (UIImage *)imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0){
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation NSString (DFPlayerStringExtensions)

- (NSString *)removeEmptyString{
    NSString *str = [NSString stringWithFormat:@"%@",self];
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)isEmptyString{
    if(!self || [self isEqualToString:@"(null)"] || [self isKindOfClass:[NSNull class]] || [self isEqual:[NSNull null]]){
        return YES;
    }
    return [self removeEmptyString].length == 0;
}

- (BOOL)isContainLetter{
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    return count > 0;
}


@end



