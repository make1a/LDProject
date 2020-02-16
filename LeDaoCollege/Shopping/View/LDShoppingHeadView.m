//
//  LDShoppingHeadView.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShoppingHeadView.h"

@implementation LDShoppingHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.greenViewHeight.constant = kSTATUSBAR_HEIGHT+PtHeight(110);
//    self.scrollViewHeight.constant = SCREEN_WIDTH * 9/16;
//    self.scrollViewWidth.constant = SCREEN_WIDTH;
    [self.cycleScrollView setCornerRadius:5];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.greenViewHeight.constant + self.cycleScrollView.frame.size.height/2);
    
    self.searchButton.frame = CGRectMake(PtWidth(18), kSTATUSBAR_HEIGHT+8, PtWidth(290), PtHeight(32));
    [self.searchButton setCornerRadius:PtHeight(16)];
    self.searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    self.searchButton.imagePosition = QMUIButtonImagePositionLeft;
    self.searchButton.spacingBetweenImageAndTitle = 15;
    
    self.cycleScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.searchButton.frame)+20, SCREEN_WIDTH, 180);
    
    CGFloat y = self.searchButton.center.y - 20/2;
    self.docButton.frame = CGRectMake(PtWidth(335), y, 20, 20);
//    [self.docButton sizeToFit];
    
//    self.carButton.frame = CGRectMake(PtWidth(342), y, 20, 20);
//    [self.carButton sizeToFit];
}
@end
