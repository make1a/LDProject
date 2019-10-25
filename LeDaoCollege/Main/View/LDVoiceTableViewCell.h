//
//  LDVoiceTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNewsTableViewCell.h"
#import "LDVoiceModel.h"
extern NSString *const kLDVoiceTableViewCellIdentifier;
@interface LDVoiceTableViewCell : LDNewsTableViewCell
@property (nonatomic,strong)UIButton * collectionButton;



+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)refreshWithModel:(LDVoiceModel *)model;
@end
