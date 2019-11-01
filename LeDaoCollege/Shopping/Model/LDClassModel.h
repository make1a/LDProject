//
//  LDClassModel.h
//  LeDaoCollege
//
//  Created by Make on 2019/10/31.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDClassModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *c_id;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userId;
/** <#Description#> **/
@property(nonatomic,copy) NSString *userName;
/** <#Description#> **/
@property(nonatomic,copy) NSString *activeFlag;
/** <#Description#> **/
@property(nonatomic,copy) NSString *deleteFlag;
@property(nonatomic,copy) NSString *collectionFlag;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *createdBy;
/** <#Description#> **/
@property(nonatomic,copy) NSString *createdDate;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *updateBy;
/** <#Description#> **/
@property(nonatomic,copy) NSString *updateDate;
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
/** <#Description#> **/
@property(nonatomic,copy) NSString *bookUrl;
/** <#Description#> **/
@property(nonatomic,copy) NSString *goodsImgVOS;
/** <#Description#> **/
@property(nonatomic,copy) NSString *lecturerName;
/** <#Description#> **/
@property(nonatomic,copy) NSString *lecturerImgUrl;
/** <#Description#> **/
@property(nonatomic,copy) NSString *briefIntroduction;

@property (nonatomic,strong)NSArray * chapterArray;
@end

@interface LDClassChapterModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *c_id;
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
@property(nonatomic,copy) NSString *title;
/** <#Description#> **/
@property(nonatomic,copy) NSString *coverImg;
/** <#Description#> **/
@property(nonatomic,copy) NSString *originalPrice;
/** <#Description#> **/
@property(nonatomic,copy) NSString *discount;
/** <#Description#> **/
@property(nonatomic,copy) NSString *bookInfo;
/** <#Description#> **/
@property(nonatomic,copy) NSString *bookUrl;
/** <#Description#> **/
@property(nonatomic,copy) NSString *goodsImgVOS;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *courseId;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *chapterNo;
/** <#Description#> **/
@property(nonatomic,copy) NSString *chapterTitle;
@property (nonatomic,strong)NSArray * sectionArray;


@end

@interface LDClassChapterSectionModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *c_id;
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
@property(nonatomic,copy) NSString *title;
/** <#Description#> **/
@property(nonatomic,copy) NSString *coverImg;
/** <#Description#> **/
@property(nonatomic,copy) NSString *originalPrice;
/** <#Description#> **/
@property(nonatomic,copy) NSString *discount;
/** <#Description#> **/
@property(nonatomic,copy) NSString *bookInfo;
/** <#Description#> **/
@property(nonatomic,copy) NSString *bookUrl;
/** <#Description#> **/
@property(nonatomic,copy) NSString *goodsImgVOS;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *chapterId;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *sectionNo;
/** <#Description#> **/
@property(nonatomic,copy) NSString *sectionTitle;
/** <#Description#> **/
@property(nonatomic,copy) NSString *sectionContent;
@property (nonatomic,copy)NSString * duration;
@end
NS_ASSUME_NONNULL_END
