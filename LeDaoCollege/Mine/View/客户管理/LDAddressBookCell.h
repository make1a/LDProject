//
//  LDAddressBookCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/25.
//  Copyright © 2019 Make. All rights reserved.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDAddressBookCell : QMUITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

NS_ASSUME_NONNULL_END
