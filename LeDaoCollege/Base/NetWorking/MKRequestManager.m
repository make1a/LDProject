//
//  MKRequestManager.m
//  LeDaoCollege
//
//  Created by Make on 2019/10/12.
//  Copyright © 2019 Make. All rights reserved.
//

#import "MKRequestManager.h"
#import <AFNetworking.h>

@implementation MKRequestManager

+ (void) sendRequestWithMethodType:(MKRequestMethodType)type
                       requestAPI:(NSString *)api
                requestParameters:(NSDictionary *)parameters
                    requestHeader:(NSDictionary *)headerParameters
                          success:(SuccessBlock)success
                            faild:(FaildBlock)faild{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;  // 超时时间设置为10s
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    if (headerParameters != nil)
    {
        // 有自定义的请求头
        for (NSString *httpHeaderField in headerParameters.allKeys) {
            NSString *value = headerParameters[httpHeaderField];
            [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    if ([LDUserManager isLogin]) { //判断的是userID是否为空
        [manager.requestSerializer setValue:[LDUserManager userID] forHTTPHeaderField:@"token"];
    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,api];
    DLog(@"----- 请求的接口：%@ ------- 请求的参数： %@ ---------请求的token： %@",requestUrl,parameters,[LDUserManager userID]);
    if (type == MKRequestMethodTypeGET) {
        // GET
        [manager GET:requestUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            faild(error);
        }];
    } else {
        // POST
        [manager POST:requestUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            faild(error);
        }];
    }
}
@end
