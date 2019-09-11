//
//  LDTagView.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/10.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDTagView : UIView

@property(nonatomic, strong) QMUIFloatLayoutView *advertisingView;

@property (nonatomic,strong) NSArray * titles;

@property (nonatomic,copy)void (^didSelectButtonBlock)(NSInteger index);

@end
