//
//  LDVoiceTableViewCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNewsTableViewCell.h"
#import "LDVoiceModel.h"
extern NSString *const kLDVoiceTableViewCellIdentifier;
@interface LDVoiceTableViewCell : UITableViewCell
@property (nonatomic,strong)UIButton * collectionButton;
@property (nonatomic,strong)UIImageView * bigImageVIew;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * watchLabel;

@property (nonatomic,copy) void (^didSelectCollectionActionBlock)(void);
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)refreshWithModel:(LDVoiceModel *)model;
@end
