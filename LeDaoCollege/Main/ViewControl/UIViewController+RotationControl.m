//
//  UIViewController+RotationControl.m
//  LeDaoCollege
//
//  Created by Make on 2020/1/3.
//  Copyright © 2020 Make. All rights reserved.
//

#import "UIViewController+RotationControl.h"


@implementation UIViewController (RotationControl)
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
@end
