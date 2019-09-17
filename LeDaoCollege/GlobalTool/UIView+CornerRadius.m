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

- (void)addGradViewWithSize:(CGSize)size{
    
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(0, 0, size.width, size.height);
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:204/255.0 blue:144/255.0 alpha:1.0];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, size.width, size.height);;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:8/255.0 green:231/255.0 blue:86/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:23/255.0 green:224/255.0 blue:146/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    //        view.layer.cornerRadius = PtHeight(20);
    [self.layer addSublayer:gl];
}
@end
