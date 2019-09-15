//
//  MKIndexView.m
//  LeDaoCollege
//
//  Created by make on 2019/9/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "MKIndexView.h"
@interface MKIndexView()
@property (nonatomic, weak) UILabel *label;
@end
@implementation MKIndexView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"ico_schedule"];
        [self addTitleLabel];
    }
    return self;
}

- (void)addTitleLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    _label = label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = self.bounds;
}
@end
