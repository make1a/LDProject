//
//  LDNormalTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kLDNormalTableViewCell;

@interface LDNormalTableViewCell : UITableViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
