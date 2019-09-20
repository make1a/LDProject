//
//  LDShoppingTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const kLDShoppingTableViewCell;
@interface LDShoppingTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * selectImageView;
@property (nonatomic,strong)UIImageView * bigImageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)QMUILabel * tagLabel;
@property (nonatomic,strong)QMUILabel * cheapPriceLabel;
@property (nonatomic,strong)QMUILabel * priceLabel;

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
