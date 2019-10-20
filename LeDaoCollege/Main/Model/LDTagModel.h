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
@property(nonatomic,copy) NSString *tagId;
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
@property(nonatomic,copy) NSString *parentItemId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *itemCode;
/** <#Description#> **/
@property(nonatomic,copy) NSString *itemDesc;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *itemOrder;

@end

NS_ASSUME_NONNULL_END
