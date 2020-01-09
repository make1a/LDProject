//
//  LDReadProgressView.h
//  LeDaoCollege
//
//  Created by make on 2019/9/12.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDReadProgressView : UIView
@property (nonatomic,strong)QMUISlider * slider;

@property (nonatomic,assign)NSInteger totalPage;
@property (nonatomic,assign)NSInteger curPage;

@property (nonatomic,strong)UIButton * upButton;
@property (nonatomic,strong)UIButton * nextButton;
@property (nonatomic,strong)UIButton * bigButton;
@property (nonatomic,strong)UIButton * smallButton;
@property (nonatomic,strong)UIButton * normalButton;

- (void)showSliderPogress;
@end

NS_ASSUME_NONNULL_END
