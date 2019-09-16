//
//  UIView+CornerRadius.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)
- (void)setCornerRadius:(CGFloat)height {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = height;
}
@end
