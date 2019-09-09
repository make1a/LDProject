//
//  LDNameCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/9.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kLDNameCellIdentifier;
@interface LDNameCell : UITableViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

@end
