//
//  LDTagModel.h
//  LeDaoCollege
//
//  Created by make on 2019/10/19.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDTagModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *imgUrl;
/** <#Description#> **/
@property(nonatomic,copy) NSString *parantItemCode;
/** <#Description#> **/
@property(nonatomic,strong) NSArray *markList;
/** <#Description#> **/
@property(nonatomic,copy) NSString *parentItemDesc;

@end

@interface LDTagDetailModel : NSObject
/** <#Description#> **/
@property(nonatomic,strong) NSString *tagId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userName;
/** <#Description#> **/
@property(nonatomic,copy) NSString *activeFlag;
/** <#Description#> **/
@property(nonatomic,copy) NSString *deleteFlag;
/** <#Description#> **/
@property(nonatomic,copy) NSString *createdBy;
/** <#Description#> **/
@property(nonatomic,copy) NSString *createdDate;
/** <#Description#> **/
@property(nonatomic,copy) NSString *updateBy;
/** <#Description#> **/
@property(nonatomic,copy) NSString *updateDate;
/** <#Description#> **/
@property(nonatomic,copy) NSString *parentId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *markCode;
/** <#Description#> **/
@property(nonatomic,copy) NSString *markDesc;

@end
NS_ASSUME_NONNULL_END
