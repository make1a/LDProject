//
//  LDStoreModel.h
//  LeDaoCollege
//
//  Created by make on 2019/10/19.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDStoreModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *coverImg;
/** <#Description#> **/
@property(nonatomic,strong) NSString *originalPrice;
/** <#Description#> **/
@property(nonatomic,strong) NSString *discount;
/** <#Description#> **/
@property(nonatomic,strong) NSString *s_id;
/** <#Description#> **/
@property(nonatomic,copy) NSString *title;
/** <#Description#> **/
@property(nonatomic,copy) NSString *type;
/** <#Description#> **/
@property(nonatomic,copy) NSString *createDate;
@property(nonatomic,copy) NSString *isPayFlag;
@property(nonatomic,copy) NSString *bookId;
@property(nonatomic,copy) NSString *courseId;

@property (nonatomic,copy)NSString * numOfVisiter;

@end

@interface LDBookModel : NSObject
/** <#Description#> **/
@property(nonatomic,strong) NSString *b_id;
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
@property(nonatomic,copy) NSString *isPayFlag;
/** <#Description#> **/
@property(nonatomic,copy) NSString *title;
/** <#Description#> **/
@property(nonatomic,copy) NSString *coverImg;
/** <#Description#> **/
@property(nonatomic,copy) NSString *originalPrice;
/** <#Description#> **/
@property(nonatomic,copy) NSString *discount;
/** <#Description#> **/
@property(nonatomic,copy) NSString *bookInfo;
@property(nonatomic,copy) NSString *bookUrl;
@property(nonatomic,copy) NSString *collectionFlag;
@property (nonatomic,strong)NSArray * detailArray;
@property(nonatomic,copy) NSString *briefIntroduction;
@end


@interface goodsImgVOSModel : NSObject
/** <#Description#> **/
@property(nonatomic,strong) NSString *b_id;
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
@property(nonatomic,copy) NSString *goodsType;
/** <#Description#> **/
@property(nonatomic,copy) NSString *goodsId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *imgUrl;


@end
NS_ASSUME_NONNULL_END
