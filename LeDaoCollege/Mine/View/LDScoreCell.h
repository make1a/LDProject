//
//  LDScoreCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/17.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDScoreModel.h"
@interface LDScoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;

@property (weak, nonatomic) IBOutlet UILabel *smallTitleLabel;

- (void)refreshView:(LDScoreModel *)model;
@end
