//
//  LDShoppingTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDStoreModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const kLDShoppingTableViewCell;
@interface LDShoppingTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * selectImageView;
@property (nonatomic,strong)UIImageView * bigImageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)QMUILabel * tagLabel;
@property (nonatomic,strong)QMUILabel * cheapPriceLabel;
@property (nonatomic,strong)QMUILabel * priceLabel;
//@property (nonatomic,strong)UIButton * shopButton;
@property (nonatomic,strong)UILabel * watchLabel;

@property (nonatomic,copy)void (^addShopCarActionBlock)(void);

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)refreshWithModel:(LDStoreModel *)model;
@end

NS_ASSUME_NONNULL_END
