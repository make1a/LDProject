//
//  LDMineCustomHead.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDMineCustomHead : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headTop;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
