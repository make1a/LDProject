//
//  LDShoppingHeadView.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDShoppingHeadView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenViewHeight;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet QMUIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *docButton;
@property (weak, nonatomic) IBOutlet UIButton *carButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidth;
@end

NS_ASSUME_NONNULL_END
