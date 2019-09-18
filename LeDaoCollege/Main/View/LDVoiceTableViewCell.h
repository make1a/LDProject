//
//  LDVoiceTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNewsTableViewCell.h"
extern NSString *const kLDVoiceTableViewCellIdentifier;
@interface LDVoiceTableViewCell : LDNewsTableViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

@end
