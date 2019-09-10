//
//  LDVoiceCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/10.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kLDVoiceCellIdentifier;
@interface LDVoiceCell : UITableViewCell

@property (nonatomic,strong)UIImageView * bigImageVIew;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UIImageView * playImageView;
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

@end
