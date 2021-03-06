//
//  LDTimerCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kLDTimerCellIdentifier;
@interface LDTimerCell : UITableViewCell

@property (nonatomic,strong)QMUILabel * tagLabel;
@property (nonatomic,strong)QMUILabel * safePriceLabel;
@property (nonatomic,strong)QMUILabel * priceLabel;
@property (nonatomic,strong)QMUILabel * timeLabel;
/**
 本单创建时间戳
 */
@property (nonatomic,assign)NSTimeInterval timeInterval;


@property (nonatomic,copy)void (^timeOverBlock)(void);

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

@end
