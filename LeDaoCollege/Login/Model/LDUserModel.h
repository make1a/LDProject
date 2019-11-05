//
//  LDUserModel.h
//  LeDaoCollege
//
//  Created by Make on 2019/10/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDUserModel : NSObject
/** <#Description#> **/
@property(nonatomic,strong) NSString *LD_id;
/** <#Description#> **/
@property(nonatomic,strong) NSString *userId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userName;
/** <#Description#> **/
//@property(nonatomic,copy) NSString *activeFlag;
/** <#Description#> **/
//@property(nonatomic,copy) NSString *deleteFlag;
/** <#Description#> **/
//@property(nonatomic,strong) NSNumber *createdBy;
/** <#Description#> **/
//@property(nonatomic,copy) NSString *createdDate;
/** <#Description#> **/
//@property(nonatomic,strong) NSNumber *updateBy;
/** <#Description#> **/
//@property(nonatomic,copy) NSString *updateDate;
/** <#Description#> **/
@property(nonatomic,copy) NSString *sex;
/** <#Description#> **/
@property(nonatomic,copy) NSString *phone;
/** <#Description#> **/
@property(nonatomic,copy) NSString *pwd;
/** <#Description#> **/
@property(nonatomic,copy) NSString *headImgUrl;
/** <#Description#> **/
@property(nonatomic,copy) NSString *token;
/** <#Description#> **/
@property(nonatomic,copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
