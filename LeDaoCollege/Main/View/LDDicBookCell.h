//
//  LDDicBookCell.h
//  LeDaoCollege
//
//  Created by make on 2020/2/15.
//  Copyright © 2020 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const kLDDicBookCellIdentifier;

@interface LDDicBookCell : UITableViewCell

@property (nonatomic,strong)UIImageView * bigImageVIew;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * authorLabel;
@property (nonatomic,strong)UILabel * watchLabel;
@property (nonatomic,strong)UILabel * priceLabel;
@property (nonatomic,strong)UILabel * originLabel; //原价
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)masLayoutSubview;
//- (void)refreshWithModel:(LDNewsModel *)model;
@end

NS_ASSUME_NONNULL_END
