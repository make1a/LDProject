//
//  LDShoppingDetailNameViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/12/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDShoppingDetailNameViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *salePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchLabel;

@end

NS_ASSUME_NONNULL_END
