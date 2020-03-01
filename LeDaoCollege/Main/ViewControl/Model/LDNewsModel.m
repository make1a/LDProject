//
//  LDNewsModel.m
//  LeDaoCollege
//
//  Created by Make on 2019/10/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNewsModel.h"

@implementation LDNewsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"newsId": @"id"};
}


- (NSString *)numOfVisiter{
    NSInteger num = [_numOfVisiter intValue];
    if ( num >= 10000) {
        return @"9999+";
    }
    return _numOfVisiter;
}
@end
