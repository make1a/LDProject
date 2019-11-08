//
//  LDCustomModel.h
//  LeDaoCollege
//
//  Created by Make on 2019/11/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDCustomModel : NSObject
/** <#Description#> **/
@property(nonatomic,strong) NSString *c_id;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userName;
/** <#Description#> **/
@property(nonatomic,copy) NSString *activeFlag;
/** <#Description#> **/
@property(nonatomic,copy) NSString *deleteFlag;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *createdBy;
/** <#Description#> **/
@property(nonatomic,copy) NSString *createdDate;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *updateBy;
/** <#Description#> **/
@property(nonatomic,copy) NSString *updateDate;
/** <#Description#> **/
@property(nonatomic,copy) NSString *name;
/** <#Description#> **/
@property(nonatomic,copy) NSString *sex;
/** <#Description#> **/
@property(nonatomic,copy) NSString *position;
/** <#Description#> **/
@property(nonatomic,copy) NSString *birthDate;
/** <#Description#> **/
@property(nonatomic,copy) NSString *phone;
/** <#Description#> **/
@property(nonatomic,copy) NSString *companyName;

@end

@interface LDCustomLogModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *createdDate;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userName;
/** <#Description#> **/
@property(nonatomic,copy) NSString *content;

@end
NS_ASSUME_NONNULL_END
