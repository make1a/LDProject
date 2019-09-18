//
//  LDMineCustomHead.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDMineCustomHead.h"

@implementation LDMineCustomHead

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
   self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headHeight.constant = 152-20+kNAVIGATION_HEIGHT;
    self.headTop.constant =  kNAVIGATION_HEIGHT+30;
}
@end
