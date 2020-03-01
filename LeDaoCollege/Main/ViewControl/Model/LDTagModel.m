//
//  LDTagModel.m
//  LeDaoCollege
//
//  Created by make on 2019/10/19.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDTagModel.h"

@implementation LDTagModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"markList":[LDTagDetailModel class]};
}
@end
@implementation LDTagDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tagId": @"id"};
}


@end

