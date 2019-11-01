//
//  LDSmallClassLessonCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDClassModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDSmallClassLessonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)refreshWith:(LDClassChapterSectionModel *)model;
@end

NS_ASSUME_NONNULL_END
