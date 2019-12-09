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
    manager.requestSerializer.timeoutInterval = 100;  // 超时时间设置为10s
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

+ (void)uploadImage:(UIImage *)image
            success:(SuccessBlock)success
              faild:(FaildBlock)faild{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"file/upload"];
    
    image = [HNTools zipImageWithImage:image withMaxSize:5];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    if ([LDUserManager isLogin]) { //判断的是userID是否为空
        [manager.requestSerializer setValue:[LDUserManager userID] forHTTPHeaderField:@"token"];
    }

    [manager POST:requestUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"headImage.png" mimeType:@"image/png"];
        NSData *d = [@"headImg" dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:d name:@"fileType"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error);
    }];
    
}

+ (void)loadFileWith:(NSString *)downloadURL
            progress:(SuccessBlock)progress
            fileName:(NSString *)name
             success:(SuccessBlock)success
               faild:(FaildBlock)faild{
    AFHTTPSessionManager *manage  = [AFHTTPSessionManager manager];
    manage.securityPolicy.validatesDomainName = NO;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: downloadURL]];

    NSURLSessionDownloadTask *downloadTask = [manage downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress([NSString stringWithFormat:@"%.2f",downloadProgress.fractionCompleted*100]);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *bookName;
        if (name.length > 0) {
            bookName = name;
        }else {
            bookName = response.suggestedFilename;
        }
        bookName = [NSString stringWithFormat:@"%@.pdf",bookName];
        NSString *fullpath = [caches stringByAppendingPathComponent:bookName];
        NSURL *filePathUrl = [NSURL fileURLWithPath:fullpath];
        return filePathUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (filePath) {
            success(filePath);
        }else {
            faild(error);
        }
    }];
    [downloadTask resume];
}
@end
