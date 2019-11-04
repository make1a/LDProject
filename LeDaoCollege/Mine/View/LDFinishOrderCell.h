//
//  LDFinishOrderCell.h
//  
//
//  Created by Make on 2019/9/12.
//

#import <UIKit/UIKit.h>
#import "LDOrderModel.h"
extern NSString *const kLDFinishOrderCellIdentifier;
@interface LDFinishOrderCell : UITableViewCell
@property (nonatomic,strong)QMUILabel * tagLabel;
@property (nonatomic,strong)QMUILabel * safePriceLabel;
@property (nonatomic,strong)QMUILabel * priceLabel;
@property (nonatomic,strong)QMUILabel * timeLabel;
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)refreshWith:(LDOrderModel *)model;
@end
