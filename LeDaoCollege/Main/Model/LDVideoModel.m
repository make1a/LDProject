//
//  LDVideoModel.m
//  LeDaoCollege
//
//  Created by Make on 2019/10/21.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVideoModel.h"

@implementation LDVideoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"v_id": @"id",
             @"detailArray":@"videoSectionVOS"
    };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"detailArray":[LDVideoDetailModel class]};
}
@end


@implementation LDVideoDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"v_id": @"id"};
}

@end
