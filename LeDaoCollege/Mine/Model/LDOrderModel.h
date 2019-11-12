//
//  LDOrderModel.h
//  LeDaoCollege
//
//  Created by Make on 2019/11/4.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDOrderModel : NSObject
/** <#Description#> **/
@property(nonatomic,copy) NSString *orderNo;
/** <#Description#> **/
@property(nonatomic,copy) NSString *coverImg;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *originalPrice;
/** <#Description#> **/
@property(nonatomic,strong) NSString *goodsId;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *goodsPrice;
/** <#Description#> **/
@property(nonatomic,strong) NSNumber *discount;
/** <#Description#> **/
@property(nonatomic,copy) NSString *title;
/** <#Description#> **/
@property(nonatomic,copy) NSString *activeFlag;
/** <#Description#> **/
@property(nonatomic,copy) NSString *goodsType;
/** <#Description#> **/
@property(nonatomic,copy) NSString *createDate;

@end

NS_ASSUME_NONNULL_END
