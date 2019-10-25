//
//  LDVideoModel.h
//  LeDaoCollege
//
//  Created by Make on 2019/10/21.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDVideoModel : NSObject
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *v_id;
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
@property(nonatomic,copy) NSString *isFreeFlag;
/** <#Description#> **/
@property(nonatomic,copy) NSString *briefIntroduction;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *originalPrice;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *discount;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *mark;
/** <#Description#> **/
@property(nonatomic,copy) NSString *markName;
/** <#Description#> **/
@property(nonatomic,copy) NSString *collectionFlag;

@property (nonatomic,strong)NSArray * detailArray;
@end


@interface LDVideoDetailModel : NSObject
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *v_id;
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
@property(nonatomic,strong) NSNumber *videoId;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *sectionNo;
/** <#Description#> **/
@property(nonatomic,copy) NSString *sectionName;
/** <#Description#> **/
@property(nonatomic,copy) NSString *sectionContent;
@end
NS_ASSUME_NONNULL_END
