//
//  LDAddNameTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2020/3/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const kLDAddNameCellIdentifier;
@interface LDAddNameTableViewCell : UITableViewCell

@property (nonatomic,strong)UITextField * textField;
@property (nonatomic,strong)UIImageView * starImageView;
@property (nonatomic,strong)UILabel * nameLabel;
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;
- (void)setNameText:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
