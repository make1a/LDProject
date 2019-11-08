//
//  MKRequestManager.h
//  LeDaoCollege
//
//  Created by Make on 2019/10/12.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络请求类型
typedef NS_ENUM (NSInteger, MKRequestMethodType)
{
    MKRequestMethodTypeGET     = 0,
    MKRequestMethodTypePOST    = 1,
};


typedef void(^SuccessBlock)(id responseObject);

typedef void(^FaildBlock)(NSError *error);

@interface MKRequestManager : NSObject
@property (nonatomic,copy)NSString * urlStr;


/// 网络请求
/// @param type GET or POST
/// @param api API
/// @param parameters 参数
/// @param headerParameters 请求头
/// @param success 成功回调
/// @param faild 失败回调
+ (void)sendRequestWithMethodType:(MKRequestMethodType)type
                       requestAPI:(NSString *)api
                requestParameters:(NSDictionary *)parameters
                    requestHeader:(NSDictionary *)headerParameters
                          success:(SuccessBlock)success
                            faild:(FaildBlock)faild;

+ (void)uploadImage:(UIImage *)image
            success:(SuccessBlock)success
              faild:(FaildBlock)faild;

+ (void)loadFileWith:(NSString *)downloadURL
            progress:(SuccessBlock)progress
            fileName:(NSString *)name
             success:(SuccessBlock)success
               faild:(FaildBlock)faild;
@end


