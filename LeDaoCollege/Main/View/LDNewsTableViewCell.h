//
//  LDNewsTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDNewsModel.h"
extern NSString *const kLDNewsTableViewCellIdentifier;
@interface LDNewsTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * bigImageVIew;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * timeLabel;

@property (nonatomic,copy) void (^didSelectCollectionActionBlock)(void);
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)masLayoutSubview;
- (void)refreshWithModel:(LDNewsModel *)model;
@end
