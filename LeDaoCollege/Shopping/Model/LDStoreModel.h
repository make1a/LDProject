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

@end

NS_ASSUME_NONNULL_END
