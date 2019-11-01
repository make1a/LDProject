//
//  LDClassModel.m
//  LeDaoCollege
//
//  Created by Make on 2019/10/31.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDClassModel.h"

@implementation LDClassModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"c_id": @"id",
             @"chapterArray":@"courseChapterVOS"
    };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"chapterArray":[LDClassChapterModel class]};
}
@end

@implementation LDClassChapterModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"c_id": @"id",
             @"sectionArray":@"courseSectionVOS"
    };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"sectionArray":[LDClassChapterSectionModel class]};
}
@end

@implementation LDClassChapterSectionModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"c_id": @"id",
    };
}

@end
