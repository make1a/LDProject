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
             @"detailArray":@[@"courseChapterVOS",@"videoSectionVOS"]
    };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"detailArray":[LDVideoDetailModel class]};
}

- (NSString *)numOfVisiter{
    NSInteger num = [_numOfVisiter intValue];
    if ( num >= 10000) {
        return @"9999+";
    }
    return _numOfVisiter;
}
@end


@implementation LDVideoDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"v_id": @"id"};
}

@end
