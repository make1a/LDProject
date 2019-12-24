//
//  LDVideoTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNewsTableViewCell.h"
#import "LDVideoModel.h"
extern NSString *const kLDVideoTableViewCellIdentifier;
@interface LDVideoTableViewCell : LDNewsTableViewCell
@property (nonatomic,strong)UIImageView *blackImageView ;
@property (nonatomic,strong)UIImageView *playImageView ;
@property (nonatomic,strong)UILabel *durationLabel ;
@property (nonatomic,strong)UIButton * collectionButton;
@property (nonatomic,strong)QMUILabel * priceLabel;
@property (nonatomic,strong)QMUILabel * cheapPriceLabel;
@property (nonatomic,strong)UIImageView * priceImageView;
@property (nonatomic,strong)UIImageView * cheapImageView;

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)refreshWithModel:(LDVideoModel *)model;
@end
