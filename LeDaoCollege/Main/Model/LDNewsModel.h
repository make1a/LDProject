//
//  LDNewsModel.h
//  LeDaoCollege
//
//  Created by Make on 2019/10/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDNewsModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *newsId;
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
@property(nonatomic,copy) NSString *publishTime;
/** <#Description#> **/
@property(nonatomic,copy) NSString *content;
/** <#Description#> **/
@property(nonatomic,copy) NSString *collectionFlag;
@property (nonatomic,copy)NSString * contentUrl;
@property (nonatomic,copy)NSString * numOfVisiter;
@end

NS_ASSUME_NONNULL_END
