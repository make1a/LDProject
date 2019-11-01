//
//  LDStoreModel.m
//  LeDaoCollege
//
//  Created by make on 2019/10/19.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDStoreModel.h"

@implementation LDStoreModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"s_id": @"id"};
}
@end

@implementation LDBookModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"b_id": @"id",
             @"detailArray":@"goodsImgVOS"
    };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"detailArray":[goodsImgVOSModel class]};
}
@end


@implementation goodsImgVOSModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"b_id": @"id"};
}
@end
