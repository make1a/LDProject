//
//  LDBusinessCardView.h
//  LeDaoCollege
//
//  Created by make on 2019/9/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCustomModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDBusinessCardView : UIView
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * sexLabel;
@property (nonatomic,strong) UILabel * birthDayLabel;
@property (nonatomic,strong) UILabel * descLabel;

- (void)updateWith:(LDCustomModel *)model;
@end

NS_ASSUME_NONNULL_END
