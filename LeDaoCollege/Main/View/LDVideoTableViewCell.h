//
//  LDVideoTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNewsTableViewCell.h"
extern NSString *const kLDVideoTableViewCellIdentifier;
@interface LDVideoTableViewCell : LDNewsTableViewCell
@property (nonatomic,strong)UIImageView *blackImageView ;
@property (nonatomic,strong)UIImageView *playImageView ;
@property (nonatomic,strong)UILabel *durationLabel ;

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

@end
