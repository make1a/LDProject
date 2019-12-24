//
//  LDShujiaModel.m
//  LeDaoCollege
//
//  Created by Make on 2019/11/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShujiaModel.h"

@implementation LDShujiaModel
- (NSString *)numOfVisiter{
    if (!_numOfVisiter) {
        return @"0";
    }
    NSInteger num = [_numOfVisiter intValue];
    if ( num >= 10000) {
        
        return @"9999+";
    }
    return _numOfVisiter;
}
@end
