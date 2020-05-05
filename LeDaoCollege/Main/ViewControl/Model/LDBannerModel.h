//
//  LDBannerModel.h
//  LeDaoCollege
//
//  Created by make on 2020/5/4.
//  Copyright © 2020 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDBannerModel : NSObject
/**
 {
     activeFlag = Y;
     createdBy = "<null>";
     createdDate = "2019-12-27 10:12:33";
     deleteFlag = N;
     id = 10;
     imgUrl = "http://106.53.126.150:8088/img/banner/ce6f3419-3002-4a32-a21d-9df320c9afb8.png";
     orderNo = 4;
     type = 1;
     updateBy = "<null>";
     updateDate = "2020-04-23 16:04:45";
     userId = "<null>";
     userName = "<null>";
 }
 */
@property (nonatomic,copy)NSString *bID;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *imgUrl;
@end

NS_ASSUME_NONNULL_END
