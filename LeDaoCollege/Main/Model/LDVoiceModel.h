//
//  LDVoiceModel.h
//  LeDaoCollege
//
//  Created by Make on 2019/10/21.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDVoiceModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *v_id;
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
@property(nonatomic,copy) NSString *coverImg;
/** <#Description#> **/
@property(nonatomic,copy) NSString *title;
/** <#Description#> **/
@property(nonatomic,copy) NSString *audioContent;
/** <#Description#> **/
@property(nonatomic,copy) NSString *isFreeFlag;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *originalPrice;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *discount;
/** <#Description#> **/
@property(nonatomic,copy) NSString *collectionFlag;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *mark;
@property (nonatomic,copy)NSString * contentUrl;
@end

NS_ASSUME_NONNULL_END
